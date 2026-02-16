import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text()();
  TextColumn get email => text().unique()();
  TextColumn get password => text()();
  TextColumn get role => text()();
  TextColumn get organisation => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Scans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get imagePath => text()();
  DateTimeColumn get scanDate => dateTime().withDefault(currentDateAndTime)();
  
  // GPS coordinates (optional)
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  
  // Grain count and structure
  IntColumn get totalGrains => integer()();
  IntColumn get brokenGrains => integer()();
  IntColumn get longGrains => integer()();
  IntColumn get mediumGrains => integer()();
  IntColumn get shortGrains => integer()();
  
  // Grain color composition (counts)
  IntColumn get blackGrains => integer()();
  IntColumn get chalkyGrains => integer()();
  IntColumn get redGrains => integer()();
  IntColumn get yellowGrains => integer()();
  IntColumn get greenGrains => integer()();
  
  // Kernel shape (averages)
  RealColumn get avgLength => real()();
  RealColumn get avgWidth => real()();
  RealColumn get avgLWR => real()();
  
  // CIELAB color values
  RealColumn get cielabL => real()();
  RealColumn get cielabA => real()();
  RealColumn get cielabB => real()();
  
  // Computed percentages and classifications
  RealColumn get brokenPercent => real()();
  RealColumn get blackPercent => real()();
  RealColumn get chalkyPercent => real()();
  RealColumn get redPercent => real()();
  RealColumn get yellowPercent => real()();
  RealColumn get greenPercent => real()();
  RealColumn get longPercent => real()();
  RealColumn get mediumPercent => real()();
  RealColumn get shortPercent => real()();
  
  // Classifications
  TextColumn get millingGrade => text()(); // Premium, Grade 1, Grade 2, Grade 3
  TextColumn get grainShape => text()(); // Bold, Medium, Slender
  TextColumn get grainLength => text()(); // Long grain, Medium grain, Short grain, Mixed
  TextColumn get chalkinessStatus => text()(); // Not chalky, Chalky
  TextColumn get qualityIssues => text().nullable()(); // Damaged, Immature, Red strips, Fermented
  
  // Model version for traceability
  TextColumn get modelVersion => text()();
}

@DriftDatabase(tables: [Users, Scans])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1 && to == 2) {
            // Recreate the users table with the new schema
            await m.deleteTable('users');
            await m.createTable(users);
          }
          if (from == 2 && to == 3) {
            // Add scans table
            await m.createTable(scans);
          }
          if (from == 1 && to == 3) {
            // Recreate the users table and add scans table
            await m.deleteTable('users');
            await m.createTable(users);
            await m.createTable(scans);
          }
        },
      );

  Future<int> insertUser(UsersCompanion user) {
    return into(users).insert(user);
  }

  Future<List<User>> getAllUsers() {
    return select(users).get();
  }

  Stream<List<User>> watchAllUsers() {
    return select(users).watch();
  }

  Future<bool> updateUser(UsersCompanion user) {
    return update(users).replace(user);
  }

  Future<int> updateUserProfile(int userId, UsersCompanion user) {
    return (update(users)..where((tbl) => tbl.id.equals(userId))).write(user);
  }

  Future<int> deleteUser(int userId) {
    return (delete(users)..where((tbl) => tbl.id.equals(userId))).go();
  }

  // Scans operations
  Future<int> insertScan(ScansCompanion scan) {
    return into(scans).insert(scan);
  }

  Future<List<Scan>> getAllScans(int userId) {
    return (select(scans)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.scanDate)])
          ..limit(100))
        .get();
  }

  Future<Scan?> getScanById(int scanId) {
    return (select(scans)..where((tbl) => tbl.id.equals(scanId))).getSingleOrNull();
  }

  Stream<List<Scan>> watchUserScans(int userId) {
    return (select(scans)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.scanDate)])
          ..limit(100))
        .watch();
  }

  Future<int> deleteScan(int scanId) {
    return (delete(scans)..where((tbl) => tbl.id.equals(scanId))).go();
  }

  Future<int> deleteOldScans(int userId, int keepCount) async {
    final allScans = await (select(scans)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.scanDate)]))
        .get();
    
    if (allScans.length > keepCount) {
      final scansToDelete = allScans.skip(keepCount).toList();
      int deletedCount = 0;
      for (final scan in scansToDelete) {
        await (delete(scans)..where((tbl) => tbl.id.equals(scan.id))).go();
        deletedCount++;
      }
      return deletedCount;
    }
    return 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
