// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organisationMeta = const VerificationMeta(
    'organisation',
  );
  @override
  late final GeneratedColumn<String> organisation = GeneratedColumn<String>(
    'organisation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    email,
    password,
    role,
    organisation,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('organisation')) {
      context.handle(
        _organisationMeta,
        organisation.isAcceptableOrUnknown(
          data['organisation']!,
          _organisationMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      organisation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organisation'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String email;
  final String password;
  final String role;
  final String? organisation;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    this.organisation,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || organisation != null) {
      map['organisation'] = Variable<String>(organisation);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      email: Value(email),
      password: Value(password),
      role: Value(role),
      organisation: organisation == null && nullToAbsent
          ? const Value.absent()
          : Value(organisation),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      role: serializer.fromJson<String>(json['role']),
      organisation: serializer.fromJson<String?>(json['organisation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'role': serializer.toJson<String>(role),
      'organisation': serializer.toJson<String?>(organisation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? role,
    Value<String?> organisation = const Value.absent(),
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    role: role ?? this.role,
    organisation: organisation.present ? organisation.value : this.organisation,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      role: data.role.present ? data.role.value : this.role,
      organisation: data.organisation.present
          ? data.organisation.value
          : this.organisation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('role: $role, ')
          ..write('organisation: $organisation, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, username, email, password, role, organisation, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.email == this.email &&
          other.password == this.password &&
          other.role == this.role &&
          other.organisation == this.organisation &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> email;
  final Value<String> password;
  final Value<String> role;
  final Value<String?> organisation;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.role = const Value.absent(),
    this.organisation = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String email,
    required String password,
    required String role,
    this.organisation = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : username = Value(username),
       email = Value(email),
       password = Value(password),
       role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? role,
    Expression<String>? organisation,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (role != null) 'role': role,
      if (organisation != null) 'organisation': organisation,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? email,
    Value<String>? password,
    Value<String>? role,
    Value<String?>? organisation,
    Value<DateTime>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      organisation: organisation ?? this.organisation,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (organisation.present) {
      map['organisation'] = Variable<String>(organisation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('role: $role, ')
          ..write('organisation: $organisation, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ScansTable extends Scans with TableInfo<$ScansTable, Scan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scanDateMeta = const VerificationMeta(
    'scanDate',
  );
  @override
  late final GeneratedColumn<DateTime> scanDate = GeneratedColumn<DateTime>(
    'scan_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalGrainsMeta = const VerificationMeta(
    'totalGrains',
  );
  @override
  late final GeneratedColumn<int> totalGrains = GeneratedColumn<int>(
    'total_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brokenGrainsMeta = const VerificationMeta(
    'brokenGrains',
  );
  @override
  late final GeneratedColumn<int> brokenGrains = GeneratedColumn<int>(
    'broken_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longGrainsMeta = const VerificationMeta(
    'longGrains',
  );
  @override
  late final GeneratedColumn<int> longGrains = GeneratedColumn<int>(
    'long_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediumGrainsMeta = const VerificationMeta(
    'mediumGrains',
  );
  @override
  late final GeneratedColumn<int> mediumGrains = GeneratedColumn<int>(
    'medium_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortGrainsMeta = const VerificationMeta(
    'shortGrains',
  );
  @override
  late final GeneratedColumn<int> shortGrains = GeneratedColumn<int>(
    'short_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _blackGrainsMeta = const VerificationMeta(
    'blackGrains',
  );
  @override
  late final GeneratedColumn<int> blackGrains = GeneratedColumn<int>(
    'black_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chalkyGrainsMeta = const VerificationMeta(
    'chalkyGrains',
  );
  @override
  late final GeneratedColumn<int> chalkyGrains = GeneratedColumn<int>(
    'chalky_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _redGrainsMeta = const VerificationMeta(
    'redGrains',
  );
  @override
  late final GeneratedColumn<int> redGrains = GeneratedColumn<int>(
    'red_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yellowGrainsMeta = const VerificationMeta(
    'yellowGrains',
  );
  @override
  late final GeneratedColumn<int> yellowGrains = GeneratedColumn<int>(
    'yellow_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _greenGrainsMeta = const VerificationMeta(
    'greenGrains',
  );
  @override
  late final GeneratedColumn<int> greenGrains = GeneratedColumn<int>(
    'green_grains',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgLengthMeta = const VerificationMeta(
    'avgLength',
  );
  @override
  late final GeneratedColumn<double> avgLength = GeneratedColumn<double>(
    'avg_length',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgWidthMeta = const VerificationMeta(
    'avgWidth',
  );
  @override
  late final GeneratedColumn<double> avgWidth = GeneratedColumn<double>(
    'avg_width',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgLWRMeta = const VerificationMeta('avgLWR');
  @override
  late final GeneratedColumn<double> avgLWR = GeneratedColumn<double>(
    'avg_l_w_r',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cielabLMeta = const VerificationMeta(
    'cielabL',
  );
  @override
  late final GeneratedColumn<double> cielabL = GeneratedColumn<double>(
    'cielab_l',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cielabAMeta = const VerificationMeta(
    'cielabA',
  );
  @override
  late final GeneratedColumn<double> cielabA = GeneratedColumn<double>(
    'cielab_a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cielabBMeta = const VerificationMeta(
    'cielabB',
  );
  @override
  late final GeneratedColumn<double> cielabB = GeneratedColumn<double>(
    'cielab_b',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brokenPercentMeta = const VerificationMeta(
    'brokenPercent',
  );
  @override
  late final GeneratedColumn<double> brokenPercent = GeneratedColumn<double>(
    'broken_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _blackPercentMeta = const VerificationMeta(
    'blackPercent',
  );
  @override
  late final GeneratedColumn<double> blackPercent = GeneratedColumn<double>(
    'black_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chalkyPercentMeta = const VerificationMeta(
    'chalkyPercent',
  );
  @override
  late final GeneratedColumn<double> chalkyPercent = GeneratedColumn<double>(
    'chalky_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _redPercentMeta = const VerificationMeta(
    'redPercent',
  );
  @override
  late final GeneratedColumn<double> redPercent = GeneratedColumn<double>(
    'red_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yellowPercentMeta = const VerificationMeta(
    'yellowPercent',
  );
  @override
  late final GeneratedColumn<double> yellowPercent = GeneratedColumn<double>(
    'yellow_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _greenPercentMeta = const VerificationMeta(
    'greenPercent',
  );
  @override
  late final GeneratedColumn<double> greenPercent = GeneratedColumn<double>(
    'green_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longPercentMeta = const VerificationMeta(
    'longPercent',
  );
  @override
  late final GeneratedColumn<double> longPercent = GeneratedColumn<double>(
    'long_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediumPercentMeta = const VerificationMeta(
    'mediumPercent',
  );
  @override
  late final GeneratedColumn<double> mediumPercent = GeneratedColumn<double>(
    'medium_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortPercentMeta = const VerificationMeta(
    'shortPercent',
  );
  @override
  late final GeneratedColumn<double> shortPercent = GeneratedColumn<double>(
    'short_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _millingGradeMeta = const VerificationMeta(
    'millingGrade',
  );
  @override
  late final GeneratedColumn<String> millingGrade = GeneratedColumn<String>(
    'milling_grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grainShapeMeta = const VerificationMeta(
    'grainShape',
  );
  @override
  late final GeneratedColumn<String> grainShape = GeneratedColumn<String>(
    'grain_shape',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grainLengthMeta = const VerificationMeta(
    'grainLength',
  );
  @override
  late final GeneratedColumn<String> grainLength = GeneratedColumn<String>(
    'grain_length',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chalkinessStatusMeta = const VerificationMeta(
    'chalkinessStatus',
  );
  @override
  late final GeneratedColumn<String> chalkinessStatus = GeneratedColumn<String>(
    'chalkiness_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityIssuesMeta = const VerificationMeta(
    'qualityIssues',
  );
  @override
  late final GeneratedColumn<String> qualityIssues = GeneratedColumn<String>(
    'quality_issues',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    imagePath,
    scanDate,
    latitude,
    longitude,
    totalGrains,
    brokenGrains,
    longGrains,
    mediumGrains,
    shortGrains,
    blackGrains,
    chalkyGrains,
    redGrains,
    yellowGrains,
    greenGrains,
    avgLength,
    avgWidth,
    avgLWR,
    cielabL,
    cielabA,
    cielabB,
    brokenPercent,
    blackPercent,
    chalkyPercent,
    redPercent,
    yellowPercent,
    greenPercent,
    longPercent,
    mediumPercent,
    shortPercent,
    millingGrade,
    grainShape,
    grainLength,
    chalkinessStatus,
    qualityIssues,
    modelVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Scan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('scan_date')) {
      context.handle(
        _scanDateMeta,
        scanDate.isAcceptableOrUnknown(data['scan_date']!, _scanDateMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('total_grains')) {
      context.handle(
        _totalGrainsMeta,
        totalGrains.isAcceptableOrUnknown(
          data['total_grains']!,
          _totalGrainsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalGrainsMeta);
    }
    if (data.containsKey('broken_grains')) {
      context.handle(
        _brokenGrainsMeta,
        brokenGrains.isAcceptableOrUnknown(
          data['broken_grains']!,
          _brokenGrainsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_brokenGrainsMeta);
    }
    if (data.containsKey('long_grains')) {
      context.handle(
        _longGrainsMeta,
        longGrains.isAcceptableOrUnknown(data['long_grains']!, _longGrainsMeta),
      );
    } else if (isInserting) {
      context.missing(_longGrainsMeta);
    }
    if (data.containsKey('medium_grains')) {
      context.handle(
        _mediumGrainsMeta,
        mediumGrains.isAcceptableOrUnknown(
          data['medium_grains']!,
          _mediumGrainsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediumGrainsMeta);
    }
    if (data.containsKey('short_grains')) {
      context.handle(
        _shortGrainsMeta,
        shortGrains.isAcceptableOrUnknown(
          data['short_grains']!,
          _shortGrainsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shortGrainsMeta);
    }
    if (data.containsKey('black_grains')) {
      context.handle(
        _blackGrainsMeta,
        blackGrains.isAcceptableOrUnknown(
          data['black_grains']!,
          _blackGrainsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_blackGrainsMeta);
    }
    if (data.containsKey('chalky_grains')) {
      context.handle(
        _chalkyGrainsMeta,
        chalkyGrains.isAcceptableOrUnknown(
          data['chalky_grains']!,
          _chalkyGrainsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chalkyGrainsMeta);
    }
    if (data.containsKey('red_grains')) {
      context.handle(
        _redGrainsMeta,
        redGrains.isAcceptableOrUnknown(data['red_grains']!, _redGrainsMeta),
      );
    } else if (isInserting) {
      context.missing(_redGrainsMeta);
    }
    if (data.containsKey('yellow_grains')) {
      context.handle(
        _yellowGrainsMeta,
        yellowGrains.isAcceptableOrUnknown(
          data['yellow_grains']!,
          _yellowGrainsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_yellowGrainsMeta);
    }
    if (data.containsKey('green_grains')) {
      context.handle(
        _greenGrainsMeta,
        greenGrains.isAcceptableOrUnknown(
          data['green_grains']!,
          _greenGrainsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_greenGrainsMeta);
    }
    if (data.containsKey('avg_length')) {
      context.handle(
        _avgLengthMeta,
        avgLength.isAcceptableOrUnknown(data['avg_length']!, _avgLengthMeta),
      );
    } else if (isInserting) {
      context.missing(_avgLengthMeta);
    }
    if (data.containsKey('avg_width')) {
      context.handle(
        _avgWidthMeta,
        avgWidth.isAcceptableOrUnknown(data['avg_width']!, _avgWidthMeta),
      );
    } else if (isInserting) {
      context.missing(_avgWidthMeta);
    }
    if (data.containsKey('avg_l_w_r')) {
      context.handle(
        _avgLWRMeta,
        avgLWR.isAcceptableOrUnknown(data['avg_l_w_r']!, _avgLWRMeta),
      );
    } else if (isInserting) {
      context.missing(_avgLWRMeta);
    }
    if (data.containsKey('cielab_l')) {
      context.handle(
        _cielabLMeta,
        cielabL.isAcceptableOrUnknown(data['cielab_l']!, _cielabLMeta),
      );
    } else if (isInserting) {
      context.missing(_cielabLMeta);
    }
    if (data.containsKey('cielab_a')) {
      context.handle(
        _cielabAMeta,
        cielabA.isAcceptableOrUnknown(data['cielab_a']!, _cielabAMeta),
      );
    } else if (isInserting) {
      context.missing(_cielabAMeta);
    }
    if (data.containsKey('cielab_b')) {
      context.handle(
        _cielabBMeta,
        cielabB.isAcceptableOrUnknown(data['cielab_b']!, _cielabBMeta),
      );
    } else if (isInserting) {
      context.missing(_cielabBMeta);
    }
    if (data.containsKey('broken_percent')) {
      context.handle(
        _brokenPercentMeta,
        brokenPercent.isAcceptableOrUnknown(
          data['broken_percent']!,
          _brokenPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_brokenPercentMeta);
    }
    if (data.containsKey('black_percent')) {
      context.handle(
        _blackPercentMeta,
        blackPercent.isAcceptableOrUnknown(
          data['black_percent']!,
          _blackPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_blackPercentMeta);
    }
    if (data.containsKey('chalky_percent')) {
      context.handle(
        _chalkyPercentMeta,
        chalkyPercent.isAcceptableOrUnknown(
          data['chalky_percent']!,
          _chalkyPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chalkyPercentMeta);
    }
    if (data.containsKey('red_percent')) {
      context.handle(
        _redPercentMeta,
        redPercent.isAcceptableOrUnknown(data['red_percent']!, _redPercentMeta),
      );
    } else if (isInserting) {
      context.missing(_redPercentMeta);
    }
    if (data.containsKey('yellow_percent')) {
      context.handle(
        _yellowPercentMeta,
        yellowPercent.isAcceptableOrUnknown(
          data['yellow_percent']!,
          _yellowPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_yellowPercentMeta);
    }
    if (data.containsKey('green_percent')) {
      context.handle(
        _greenPercentMeta,
        greenPercent.isAcceptableOrUnknown(
          data['green_percent']!,
          _greenPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_greenPercentMeta);
    }
    if (data.containsKey('long_percent')) {
      context.handle(
        _longPercentMeta,
        longPercent.isAcceptableOrUnknown(
          data['long_percent']!,
          _longPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_longPercentMeta);
    }
    if (data.containsKey('medium_percent')) {
      context.handle(
        _mediumPercentMeta,
        mediumPercent.isAcceptableOrUnknown(
          data['medium_percent']!,
          _mediumPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediumPercentMeta);
    }
    if (data.containsKey('short_percent')) {
      context.handle(
        _shortPercentMeta,
        shortPercent.isAcceptableOrUnknown(
          data['short_percent']!,
          _shortPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shortPercentMeta);
    }
    if (data.containsKey('milling_grade')) {
      context.handle(
        _millingGradeMeta,
        millingGrade.isAcceptableOrUnknown(
          data['milling_grade']!,
          _millingGradeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_millingGradeMeta);
    }
    if (data.containsKey('grain_shape')) {
      context.handle(
        _grainShapeMeta,
        grainShape.isAcceptableOrUnknown(data['grain_shape']!, _grainShapeMeta),
      );
    } else if (isInserting) {
      context.missing(_grainShapeMeta);
    }
    if (data.containsKey('grain_length')) {
      context.handle(
        _grainLengthMeta,
        grainLength.isAcceptableOrUnknown(
          data['grain_length']!,
          _grainLengthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grainLengthMeta);
    }
    if (data.containsKey('chalkiness_status')) {
      context.handle(
        _chalkinessStatusMeta,
        chalkinessStatus.isAcceptableOrUnknown(
          data['chalkiness_status']!,
          _chalkinessStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chalkinessStatusMeta);
    }
    if (data.containsKey('quality_issues')) {
      context.handle(
        _qualityIssuesMeta,
        qualityIssues.isAcceptableOrUnknown(
          data['quality_issues']!,
          _qualityIssuesMeta,
        ),
      );
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_modelVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Scan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Scan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      scanDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scan_date'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      totalGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_grains'],
      )!,
      brokenGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}broken_grains'],
      )!,
      longGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}long_grains'],
      )!,
      mediumGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}medium_grains'],
      )!,
      shortGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}short_grains'],
      )!,
      blackGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}black_grains'],
      )!,
      chalkyGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chalky_grains'],
      )!,
      redGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}red_grains'],
      )!,
      yellowGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}yellow_grains'],
      )!,
      greenGrains: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}green_grains'],
      )!,
      avgLength: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_length'],
      )!,
      avgWidth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_width'],
      )!,
      avgLWR: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_l_w_r'],
      )!,
      cielabL: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cielab_l'],
      )!,
      cielabA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cielab_a'],
      )!,
      cielabB: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cielab_b'],
      )!,
      brokenPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}broken_percent'],
      )!,
      blackPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}black_percent'],
      )!,
      chalkyPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}chalky_percent'],
      )!,
      redPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}red_percent'],
      )!,
      yellowPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yellow_percent'],
      )!,
      greenPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}green_percent'],
      )!,
      longPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}long_percent'],
      )!,
      mediumPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}medium_percent'],
      )!,
      shortPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}short_percent'],
      )!,
      millingGrade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}milling_grade'],
      )!,
      grainShape: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grain_shape'],
      )!,
      grainLength: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grain_length'],
      )!,
      chalkinessStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chalkiness_status'],
      )!,
      qualityIssues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality_issues'],
      ),
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      )!,
    );
  }

  @override
  $ScansTable createAlias(String alias) {
    return $ScansTable(attachedDatabase, alias);
  }
}

class Scan extends DataClass implements Insertable<Scan> {
  final int id;
  final int userId;
  final String imagePath;
  final DateTime scanDate;
  final double? latitude;
  final double? longitude;
  final int totalGrains;
  final int brokenGrains;
  final int longGrains;
  final int mediumGrains;
  final int shortGrains;
  final int blackGrains;
  final int chalkyGrains;
  final int redGrains;
  final int yellowGrains;
  final int greenGrains;
  final double avgLength;
  final double avgWidth;
  final double avgLWR;
  final double cielabL;
  final double cielabA;
  final double cielabB;
  final double brokenPercent;
  final double blackPercent;
  final double chalkyPercent;
  final double redPercent;
  final double yellowPercent;
  final double greenPercent;
  final double longPercent;
  final double mediumPercent;
  final double shortPercent;
  final String millingGrade;
  final String grainShape;
  final String grainLength;
  final String chalkinessStatus;
  final String? qualityIssues;
  final String modelVersion;
  const Scan({
    required this.id,
    required this.userId,
    required this.imagePath,
    required this.scanDate,
    this.latitude,
    this.longitude,
    required this.totalGrains,
    required this.brokenGrains,
    required this.longGrains,
    required this.mediumGrains,
    required this.shortGrains,
    required this.blackGrains,
    required this.chalkyGrains,
    required this.redGrains,
    required this.yellowGrains,
    required this.greenGrains,
    required this.avgLength,
    required this.avgWidth,
    required this.avgLWR,
    required this.cielabL,
    required this.cielabA,
    required this.cielabB,
    required this.brokenPercent,
    required this.blackPercent,
    required this.chalkyPercent,
    required this.redPercent,
    required this.yellowPercent,
    required this.greenPercent,
    required this.longPercent,
    required this.mediumPercent,
    required this.shortPercent,
    required this.millingGrade,
    required this.grainShape,
    required this.grainLength,
    required this.chalkinessStatus,
    this.qualityIssues,
    required this.modelVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['image_path'] = Variable<String>(imagePath);
    map['scan_date'] = Variable<DateTime>(scanDate);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['total_grains'] = Variable<int>(totalGrains);
    map['broken_grains'] = Variable<int>(brokenGrains);
    map['long_grains'] = Variable<int>(longGrains);
    map['medium_grains'] = Variable<int>(mediumGrains);
    map['short_grains'] = Variable<int>(shortGrains);
    map['black_grains'] = Variable<int>(blackGrains);
    map['chalky_grains'] = Variable<int>(chalkyGrains);
    map['red_grains'] = Variable<int>(redGrains);
    map['yellow_grains'] = Variable<int>(yellowGrains);
    map['green_grains'] = Variable<int>(greenGrains);
    map['avg_length'] = Variable<double>(avgLength);
    map['avg_width'] = Variable<double>(avgWidth);
    map['avg_l_w_r'] = Variable<double>(avgLWR);
    map['cielab_l'] = Variable<double>(cielabL);
    map['cielab_a'] = Variable<double>(cielabA);
    map['cielab_b'] = Variable<double>(cielabB);
    map['broken_percent'] = Variable<double>(brokenPercent);
    map['black_percent'] = Variable<double>(blackPercent);
    map['chalky_percent'] = Variable<double>(chalkyPercent);
    map['red_percent'] = Variable<double>(redPercent);
    map['yellow_percent'] = Variable<double>(yellowPercent);
    map['green_percent'] = Variable<double>(greenPercent);
    map['long_percent'] = Variable<double>(longPercent);
    map['medium_percent'] = Variable<double>(mediumPercent);
    map['short_percent'] = Variable<double>(shortPercent);
    map['milling_grade'] = Variable<String>(millingGrade);
    map['grain_shape'] = Variable<String>(grainShape);
    map['grain_length'] = Variable<String>(grainLength);
    map['chalkiness_status'] = Variable<String>(chalkinessStatus);
    if (!nullToAbsent || qualityIssues != null) {
      map['quality_issues'] = Variable<String>(qualityIssues);
    }
    map['model_version'] = Variable<String>(modelVersion);
    return map;
  }

  ScansCompanion toCompanion(bool nullToAbsent) {
    return ScansCompanion(
      id: Value(id),
      userId: Value(userId),
      imagePath: Value(imagePath),
      scanDate: Value(scanDate),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      totalGrains: Value(totalGrains),
      brokenGrains: Value(brokenGrains),
      longGrains: Value(longGrains),
      mediumGrains: Value(mediumGrains),
      shortGrains: Value(shortGrains),
      blackGrains: Value(blackGrains),
      chalkyGrains: Value(chalkyGrains),
      redGrains: Value(redGrains),
      yellowGrains: Value(yellowGrains),
      greenGrains: Value(greenGrains),
      avgLength: Value(avgLength),
      avgWidth: Value(avgWidth),
      avgLWR: Value(avgLWR),
      cielabL: Value(cielabL),
      cielabA: Value(cielabA),
      cielabB: Value(cielabB),
      brokenPercent: Value(brokenPercent),
      blackPercent: Value(blackPercent),
      chalkyPercent: Value(chalkyPercent),
      redPercent: Value(redPercent),
      yellowPercent: Value(yellowPercent),
      greenPercent: Value(greenPercent),
      longPercent: Value(longPercent),
      mediumPercent: Value(mediumPercent),
      shortPercent: Value(shortPercent),
      millingGrade: Value(millingGrade),
      grainShape: Value(grainShape),
      grainLength: Value(grainLength),
      chalkinessStatus: Value(chalkinessStatus),
      qualityIssues: qualityIssues == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityIssues),
      modelVersion: Value(modelVersion),
    );
  }

  factory Scan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Scan(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      scanDate: serializer.fromJson<DateTime>(json['scanDate']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      totalGrains: serializer.fromJson<int>(json['totalGrains']),
      brokenGrains: serializer.fromJson<int>(json['brokenGrains']),
      longGrains: serializer.fromJson<int>(json['longGrains']),
      mediumGrains: serializer.fromJson<int>(json['mediumGrains']),
      shortGrains: serializer.fromJson<int>(json['shortGrains']),
      blackGrains: serializer.fromJson<int>(json['blackGrains']),
      chalkyGrains: serializer.fromJson<int>(json['chalkyGrains']),
      redGrains: serializer.fromJson<int>(json['redGrains']),
      yellowGrains: serializer.fromJson<int>(json['yellowGrains']),
      greenGrains: serializer.fromJson<int>(json['greenGrains']),
      avgLength: serializer.fromJson<double>(json['avgLength']),
      avgWidth: serializer.fromJson<double>(json['avgWidth']),
      avgLWR: serializer.fromJson<double>(json['avgLWR']),
      cielabL: serializer.fromJson<double>(json['cielabL']),
      cielabA: serializer.fromJson<double>(json['cielabA']),
      cielabB: serializer.fromJson<double>(json['cielabB']),
      brokenPercent: serializer.fromJson<double>(json['brokenPercent']),
      blackPercent: serializer.fromJson<double>(json['blackPercent']),
      chalkyPercent: serializer.fromJson<double>(json['chalkyPercent']),
      redPercent: serializer.fromJson<double>(json['redPercent']),
      yellowPercent: serializer.fromJson<double>(json['yellowPercent']),
      greenPercent: serializer.fromJson<double>(json['greenPercent']),
      longPercent: serializer.fromJson<double>(json['longPercent']),
      mediumPercent: serializer.fromJson<double>(json['mediumPercent']),
      shortPercent: serializer.fromJson<double>(json['shortPercent']),
      millingGrade: serializer.fromJson<String>(json['millingGrade']),
      grainShape: serializer.fromJson<String>(json['grainShape']),
      grainLength: serializer.fromJson<String>(json['grainLength']),
      chalkinessStatus: serializer.fromJson<String>(json['chalkinessStatus']),
      qualityIssues: serializer.fromJson<String?>(json['qualityIssues']),
      modelVersion: serializer.fromJson<String>(json['modelVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'imagePath': serializer.toJson<String>(imagePath),
      'scanDate': serializer.toJson<DateTime>(scanDate),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'totalGrains': serializer.toJson<int>(totalGrains),
      'brokenGrains': serializer.toJson<int>(brokenGrains),
      'longGrains': serializer.toJson<int>(longGrains),
      'mediumGrains': serializer.toJson<int>(mediumGrains),
      'shortGrains': serializer.toJson<int>(shortGrains),
      'blackGrains': serializer.toJson<int>(blackGrains),
      'chalkyGrains': serializer.toJson<int>(chalkyGrains),
      'redGrains': serializer.toJson<int>(redGrains),
      'yellowGrains': serializer.toJson<int>(yellowGrains),
      'greenGrains': serializer.toJson<int>(greenGrains),
      'avgLength': serializer.toJson<double>(avgLength),
      'avgWidth': serializer.toJson<double>(avgWidth),
      'avgLWR': serializer.toJson<double>(avgLWR),
      'cielabL': serializer.toJson<double>(cielabL),
      'cielabA': serializer.toJson<double>(cielabA),
      'cielabB': serializer.toJson<double>(cielabB),
      'brokenPercent': serializer.toJson<double>(brokenPercent),
      'blackPercent': serializer.toJson<double>(blackPercent),
      'chalkyPercent': serializer.toJson<double>(chalkyPercent),
      'redPercent': serializer.toJson<double>(redPercent),
      'yellowPercent': serializer.toJson<double>(yellowPercent),
      'greenPercent': serializer.toJson<double>(greenPercent),
      'longPercent': serializer.toJson<double>(longPercent),
      'mediumPercent': serializer.toJson<double>(mediumPercent),
      'shortPercent': serializer.toJson<double>(shortPercent),
      'millingGrade': serializer.toJson<String>(millingGrade),
      'grainShape': serializer.toJson<String>(grainShape),
      'grainLength': serializer.toJson<String>(grainLength),
      'chalkinessStatus': serializer.toJson<String>(chalkinessStatus),
      'qualityIssues': serializer.toJson<String?>(qualityIssues),
      'modelVersion': serializer.toJson<String>(modelVersion),
    };
  }

  Scan copyWith({
    int? id,
    int? userId,
    String? imagePath,
    DateTime? scanDate,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    int? totalGrains,
    int? brokenGrains,
    int? longGrains,
    int? mediumGrains,
    int? shortGrains,
    int? blackGrains,
    int? chalkyGrains,
    int? redGrains,
    int? yellowGrains,
    int? greenGrains,
    double? avgLength,
    double? avgWidth,
    double? avgLWR,
    double? cielabL,
    double? cielabA,
    double? cielabB,
    double? brokenPercent,
    double? blackPercent,
    double? chalkyPercent,
    double? redPercent,
    double? yellowPercent,
    double? greenPercent,
    double? longPercent,
    double? mediumPercent,
    double? shortPercent,
    String? millingGrade,
    String? grainShape,
    String? grainLength,
    String? chalkinessStatus,
    Value<String?> qualityIssues = const Value.absent(),
    String? modelVersion,
  }) => Scan(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    imagePath: imagePath ?? this.imagePath,
    scanDate: scanDate ?? this.scanDate,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    totalGrains: totalGrains ?? this.totalGrains,
    brokenGrains: brokenGrains ?? this.brokenGrains,
    longGrains: longGrains ?? this.longGrains,
    mediumGrains: mediumGrains ?? this.mediumGrains,
    shortGrains: shortGrains ?? this.shortGrains,
    blackGrains: blackGrains ?? this.blackGrains,
    chalkyGrains: chalkyGrains ?? this.chalkyGrains,
    redGrains: redGrains ?? this.redGrains,
    yellowGrains: yellowGrains ?? this.yellowGrains,
    greenGrains: greenGrains ?? this.greenGrains,
    avgLength: avgLength ?? this.avgLength,
    avgWidth: avgWidth ?? this.avgWidth,
    avgLWR: avgLWR ?? this.avgLWR,
    cielabL: cielabL ?? this.cielabL,
    cielabA: cielabA ?? this.cielabA,
    cielabB: cielabB ?? this.cielabB,
    brokenPercent: brokenPercent ?? this.brokenPercent,
    blackPercent: blackPercent ?? this.blackPercent,
    chalkyPercent: chalkyPercent ?? this.chalkyPercent,
    redPercent: redPercent ?? this.redPercent,
    yellowPercent: yellowPercent ?? this.yellowPercent,
    greenPercent: greenPercent ?? this.greenPercent,
    longPercent: longPercent ?? this.longPercent,
    mediumPercent: mediumPercent ?? this.mediumPercent,
    shortPercent: shortPercent ?? this.shortPercent,
    millingGrade: millingGrade ?? this.millingGrade,
    grainShape: grainShape ?? this.grainShape,
    grainLength: grainLength ?? this.grainLength,
    chalkinessStatus: chalkinessStatus ?? this.chalkinessStatus,
    qualityIssues: qualityIssues.present
        ? qualityIssues.value
        : this.qualityIssues,
    modelVersion: modelVersion ?? this.modelVersion,
  );
  Scan copyWithCompanion(ScansCompanion data) {
    return Scan(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      scanDate: data.scanDate.present ? data.scanDate.value : this.scanDate,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      totalGrains: data.totalGrains.present
          ? data.totalGrains.value
          : this.totalGrains,
      brokenGrains: data.brokenGrains.present
          ? data.brokenGrains.value
          : this.brokenGrains,
      longGrains: data.longGrains.present
          ? data.longGrains.value
          : this.longGrains,
      mediumGrains: data.mediumGrains.present
          ? data.mediumGrains.value
          : this.mediumGrains,
      shortGrains: data.shortGrains.present
          ? data.shortGrains.value
          : this.shortGrains,
      blackGrains: data.blackGrains.present
          ? data.blackGrains.value
          : this.blackGrains,
      chalkyGrains: data.chalkyGrains.present
          ? data.chalkyGrains.value
          : this.chalkyGrains,
      redGrains: data.redGrains.present ? data.redGrains.value : this.redGrains,
      yellowGrains: data.yellowGrains.present
          ? data.yellowGrains.value
          : this.yellowGrains,
      greenGrains: data.greenGrains.present
          ? data.greenGrains.value
          : this.greenGrains,
      avgLength: data.avgLength.present ? data.avgLength.value : this.avgLength,
      avgWidth: data.avgWidth.present ? data.avgWidth.value : this.avgWidth,
      avgLWR: data.avgLWR.present ? data.avgLWR.value : this.avgLWR,
      cielabL: data.cielabL.present ? data.cielabL.value : this.cielabL,
      cielabA: data.cielabA.present ? data.cielabA.value : this.cielabA,
      cielabB: data.cielabB.present ? data.cielabB.value : this.cielabB,
      brokenPercent: data.brokenPercent.present
          ? data.brokenPercent.value
          : this.brokenPercent,
      blackPercent: data.blackPercent.present
          ? data.blackPercent.value
          : this.blackPercent,
      chalkyPercent: data.chalkyPercent.present
          ? data.chalkyPercent.value
          : this.chalkyPercent,
      redPercent: data.redPercent.present
          ? data.redPercent.value
          : this.redPercent,
      yellowPercent: data.yellowPercent.present
          ? data.yellowPercent.value
          : this.yellowPercent,
      greenPercent: data.greenPercent.present
          ? data.greenPercent.value
          : this.greenPercent,
      longPercent: data.longPercent.present
          ? data.longPercent.value
          : this.longPercent,
      mediumPercent: data.mediumPercent.present
          ? data.mediumPercent.value
          : this.mediumPercent,
      shortPercent: data.shortPercent.present
          ? data.shortPercent.value
          : this.shortPercent,
      millingGrade: data.millingGrade.present
          ? data.millingGrade.value
          : this.millingGrade,
      grainShape: data.grainShape.present
          ? data.grainShape.value
          : this.grainShape,
      grainLength: data.grainLength.present
          ? data.grainLength.value
          : this.grainLength,
      chalkinessStatus: data.chalkinessStatus.present
          ? data.chalkinessStatus.value
          : this.chalkinessStatus,
      qualityIssues: data.qualityIssues.present
          ? data.qualityIssues.value
          : this.qualityIssues,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Scan(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('imagePath: $imagePath, ')
          ..write('scanDate: $scanDate, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('totalGrains: $totalGrains, ')
          ..write('brokenGrains: $brokenGrains, ')
          ..write('longGrains: $longGrains, ')
          ..write('mediumGrains: $mediumGrains, ')
          ..write('shortGrains: $shortGrains, ')
          ..write('blackGrains: $blackGrains, ')
          ..write('chalkyGrains: $chalkyGrains, ')
          ..write('redGrains: $redGrains, ')
          ..write('yellowGrains: $yellowGrains, ')
          ..write('greenGrains: $greenGrains, ')
          ..write('avgLength: $avgLength, ')
          ..write('avgWidth: $avgWidth, ')
          ..write('avgLWR: $avgLWR, ')
          ..write('cielabL: $cielabL, ')
          ..write('cielabA: $cielabA, ')
          ..write('cielabB: $cielabB, ')
          ..write('brokenPercent: $brokenPercent, ')
          ..write('blackPercent: $blackPercent, ')
          ..write('chalkyPercent: $chalkyPercent, ')
          ..write('redPercent: $redPercent, ')
          ..write('yellowPercent: $yellowPercent, ')
          ..write('greenPercent: $greenPercent, ')
          ..write('longPercent: $longPercent, ')
          ..write('mediumPercent: $mediumPercent, ')
          ..write('shortPercent: $shortPercent, ')
          ..write('millingGrade: $millingGrade, ')
          ..write('grainShape: $grainShape, ')
          ..write('grainLength: $grainLength, ')
          ..write('chalkinessStatus: $chalkinessStatus, ')
          ..write('qualityIssues: $qualityIssues, ')
          ..write('modelVersion: $modelVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    userId,
    imagePath,
    scanDate,
    latitude,
    longitude,
    totalGrains,
    brokenGrains,
    longGrains,
    mediumGrains,
    shortGrains,
    blackGrains,
    chalkyGrains,
    redGrains,
    yellowGrains,
    greenGrains,
    avgLength,
    avgWidth,
    avgLWR,
    cielabL,
    cielabA,
    cielabB,
    brokenPercent,
    blackPercent,
    chalkyPercent,
    redPercent,
    yellowPercent,
    greenPercent,
    longPercent,
    mediumPercent,
    shortPercent,
    millingGrade,
    grainShape,
    grainLength,
    chalkinessStatus,
    qualityIssues,
    modelVersion,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Scan &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.imagePath == this.imagePath &&
          other.scanDate == this.scanDate &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.totalGrains == this.totalGrains &&
          other.brokenGrains == this.brokenGrains &&
          other.longGrains == this.longGrains &&
          other.mediumGrains == this.mediumGrains &&
          other.shortGrains == this.shortGrains &&
          other.blackGrains == this.blackGrains &&
          other.chalkyGrains == this.chalkyGrains &&
          other.redGrains == this.redGrains &&
          other.yellowGrains == this.yellowGrains &&
          other.greenGrains == this.greenGrains &&
          other.avgLength == this.avgLength &&
          other.avgWidth == this.avgWidth &&
          other.avgLWR == this.avgLWR &&
          other.cielabL == this.cielabL &&
          other.cielabA == this.cielabA &&
          other.cielabB == this.cielabB &&
          other.brokenPercent == this.brokenPercent &&
          other.blackPercent == this.blackPercent &&
          other.chalkyPercent == this.chalkyPercent &&
          other.redPercent == this.redPercent &&
          other.yellowPercent == this.yellowPercent &&
          other.greenPercent == this.greenPercent &&
          other.longPercent == this.longPercent &&
          other.mediumPercent == this.mediumPercent &&
          other.shortPercent == this.shortPercent &&
          other.millingGrade == this.millingGrade &&
          other.grainShape == this.grainShape &&
          other.grainLength == this.grainLength &&
          other.chalkinessStatus == this.chalkinessStatus &&
          other.qualityIssues == this.qualityIssues &&
          other.modelVersion == this.modelVersion);
}

class ScansCompanion extends UpdateCompanion<Scan> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> imagePath;
  final Value<DateTime> scanDate;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<int> totalGrains;
  final Value<int> brokenGrains;
  final Value<int> longGrains;
  final Value<int> mediumGrains;
  final Value<int> shortGrains;
  final Value<int> blackGrains;
  final Value<int> chalkyGrains;
  final Value<int> redGrains;
  final Value<int> yellowGrains;
  final Value<int> greenGrains;
  final Value<double> avgLength;
  final Value<double> avgWidth;
  final Value<double> avgLWR;
  final Value<double> cielabL;
  final Value<double> cielabA;
  final Value<double> cielabB;
  final Value<double> brokenPercent;
  final Value<double> blackPercent;
  final Value<double> chalkyPercent;
  final Value<double> redPercent;
  final Value<double> yellowPercent;
  final Value<double> greenPercent;
  final Value<double> longPercent;
  final Value<double> mediumPercent;
  final Value<double> shortPercent;
  final Value<String> millingGrade;
  final Value<String> grainShape;
  final Value<String> grainLength;
  final Value<String> chalkinessStatus;
  final Value<String?> qualityIssues;
  final Value<String> modelVersion;
  const ScansCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.scanDate = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.totalGrains = const Value.absent(),
    this.brokenGrains = const Value.absent(),
    this.longGrains = const Value.absent(),
    this.mediumGrains = const Value.absent(),
    this.shortGrains = const Value.absent(),
    this.blackGrains = const Value.absent(),
    this.chalkyGrains = const Value.absent(),
    this.redGrains = const Value.absent(),
    this.yellowGrains = const Value.absent(),
    this.greenGrains = const Value.absent(),
    this.avgLength = const Value.absent(),
    this.avgWidth = const Value.absent(),
    this.avgLWR = const Value.absent(),
    this.cielabL = const Value.absent(),
    this.cielabA = const Value.absent(),
    this.cielabB = const Value.absent(),
    this.brokenPercent = const Value.absent(),
    this.blackPercent = const Value.absent(),
    this.chalkyPercent = const Value.absent(),
    this.redPercent = const Value.absent(),
    this.yellowPercent = const Value.absent(),
    this.greenPercent = const Value.absent(),
    this.longPercent = const Value.absent(),
    this.mediumPercent = const Value.absent(),
    this.shortPercent = const Value.absent(),
    this.millingGrade = const Value.absent(),
    this.grainShape = const Value.absent(),
    this.grainLength = const Value.absent(),
    this.chalkinessStatus = const Value.absent(),
    this.qualityIssues = const Value.absent(),
    this.modelVersion = const Value.absent(),
  });
  ScansCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String imagePath,
    this.scanDate = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required int totalGrains,
    required int brokenGrains,
    required int longGrains,
    required int mediumGrains,
    required int shortGrains,
    required int blackGrains,
    required int chalkyGrains,
    required int redGrains,
    required int yellowGrains,
    required int greenGrains,
    required double avgLength,
    required double avgWidth,
    required double avgLWR,
    required double cielabL,
    required double cielabA,
    required double cielabB,
    required double brokenPercent,
    required double blackPercent,
    required double chalkyPercent,
    required double redPercent,
    required double yellowPercent,
    required double greenPercent,
    required double longPercent,
    required double mediumPercent,
    required double shortPercent,
    required String millingGrade,
    required String grainShape,
    required String grainLength,
    required String chalkinessStatus,
    this.qualityIssues = const Value.absent(),
    required String modelVersion,
  }) : userId = Value(userId),
       imagePath = Value(imagePath),
       totalGrains = Value(totalGrains),
       brokenGrains = Value(brokenGrains),
       longGrains = Value(longGrains),
       mediumGrains = Value(mediumGrains),
       shortGrains = Value(shortGrains),
       blackGrains = Value(blackGrains),
       chalkyGrains = Value(chalkyGrains),
       redGrains = Value(redGrains),
       yellowGrains = Value(yellowGrains),
       greenGrains = Value(greenGrains),
       avgLength = Value(avgLength),
       avgWidth = Value(avgWidth),
       avgLWR = Value(avgLWR),
       cielabL = Value(cielabL),
       cielabA = Value(cielabA),
       cielabB = Value(cielabB),
       brokenPercent = Value(brokenPercent),
       blackPercent = Value(blackPercent),
       chalkyPercent = Value(chalkyPercent),
       redPercent = Value(redPercent),
       yellowPercent = Value(yellowPercent),
       greenPercent = Value(greenPercent),
       longPercent = Value(longPercent),
       mediumPercent = Value(mediumPercent),
       shortPercent = Value(shortPercent),
       millingGrade = Value(millingGrade),
       grainShape = Value(grainShape),
       grainLength = Value(grainLength),
       chalkinessStatus = Value(chalkinessStatus),
       modelVersion = Value(modelVersion);
  static Insertable<Scan> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? imagePath,
    Expression<DateTime>? scanDate,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? totalGrains,
    Expression<int>? brokenGrains,
    Expression<int>? longGrains,
    Expression<int>? mediumGrains,
    Expression<int>? shortGrains,
    Expression<int>? blackGrains,
    Expression<int>? chalkyGrains,
    Expression<int>? redGrains,
    Expression<int>? yellowGrains,
    Expression<int>? greenGrains,
    Expression<double>? avgLength,
    Expression<double>? avgWidth,
    Expression<double>? avgLWR,
    Expression<double>? cielabL,
    Expression<double>? cielabA,
    Expression<double>? cielabB,
    Expression<double>? brokenPercent,
    Expression<double>? blackPercent,
    Expression<double>? chalkyPercent,
    Expression<double>? redPercent,
    Expression<double>? yellowPercent,
    Expression<double>? greenPercent,
    Expression<double>? longPercent,
    Expression<double>? mediumPercent,
    Expression<double>? shortPercent,
    Expression<String>? millingGrade,
    Expression<String>? grainShape,
    Expression<String>? grainLength,
    Expression<String>? chalkinessStatus,
    Expression<String>? qualityIssues,
    Expression<String>? modelVersion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (imagePath != null) 'image_path': imagePath,
      if (scanDate != null) 'scan_date': scanDate,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (totalGrains != null) 'total_grains': totalGrains,
      if (brokenGrains != null) 'broken_grains': brokenGrains,
      if (longGrains != null) 'long_grains': longGrains,
      if (mediumGrains != null) 'medium_grains': mediumGrains,
      if (shortGrains != null) 'short_grains': shortGrains,
      if (blackGrains != null) 'black_grains': blackGrains,
      if (chalkyGrains != null) 'chalky_grains': chalkyGrains,
      if (redGrains != null) 'red_grains': redGrains,
      if (yellowGrains != null) 'yellow_grains': yellowGrains,
      if (greenGrains != null) 'green_grains': greenGrains,
      if (avgLength != null) 'avg_length': avgLength,
      if (avgWidth != null) 'avg_width': avgWidth,
      if (avgLWR != null) 'avg_l_w_r': avgLWR,
      if (cielabL != null) 'cielab_l': cielabL,
      if (cielabA != null) 'cielab_a': cielabA,
      if (cielabB != null) 'cielab_b': cielabB,
      if (brokenPercent != null) 'broken_percent': brokenPercent,
      if (blackPercent != null) 'black_percent': blackPercent,
      if (chalkyPercent != null) 'chalky_percent': chalkyPercent,
      if (redPercent != null) 'red_percent': redPercent,
      if (yellowPercent != null) 'yellow_percent': yellowPercent,
      if (greenPercent != null) 'green_percent': greenPercent,
      if (longPercent != null) 'long_percent': longPercent,
      if (mediumPercent != null) 'medium_percent': mediumPercent,
      if (shortPercent != null) 'short_percent': shortPercent,
      if (millingGrade != null) 'milling_grade': millingGrade,
      if (grainShape != null) 'grain_shape': grainShape,
      if (grainLength != null) 'grain_length': grainLength,
      if (chalkinessStatus != null) 'chalkiness_status': chalkinessStatus,
      if (qualityIssues != null) 'quality_issues': qualityIssues,
      if (modelVersion != null) 'model_version': modelVersion,
    });
  }

  ScansCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? imagePath,
    Value<DateTime>? scanDate,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<int>? totalGrains,
    Value<int>? brokenGrains,
    Value<int>? longGrains,
    Value<int>? mediumGrains,
    Value<int>? shortGrains,
    Value<int>? blackGrains,
    Value<int>? chalkyGrains,
    Value<int>? redGrains,
    Value<int>? yellowGrains,
    Value<int>? greenGrains,
    Value<double>? avgLength,
    Value<double>? avgWidth,
    Value<double>? avgLWR,
    Value<double>? cielabL,
    Value<double>? cielabA,
    Value<double>? cielabB,
    Value<double>? brokenPercent,
    Value<double>? blackPercent,
    Value<double>? chalkyPercent,
    Value<double>? redPercent,
    Value<double>? yellowPercent,
    Value<double>? greenPercent,
    Value<double>? longPercent,
    Value<double>? mediumPercent,
    Value<double>? shortPercent,
    Value<String>? millingGrade,
    Value<String>? grainShape,
    Value<String>? grainLength,
    Value<String>? chalkinessStatus,
    Value<String?>? qualityIssues,
    Value<String>? modelVersion,
  }) {
    return ScansCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
      scanDate: scanDate ?? this.scanDate,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      totalGrains: totalGrains ?? this.totalGrains,
      brokenGrains: brokenGrains ?? this.brokenGrains,
      longGrains: longGrains ?? this.longGrains,
      mediumGrains: mediumGrains ?? this.mediumGrains,
      shortGrains: shortGrains ?? this.shortGrains,
      blackGrains: blackGrains ?? this.blackGrains,
      chalkyGrains: chalkyGrains ?? this.chalkyGrains,
      redGrains: redGrains ?? this.redGrains,
      yellowGrains: yellowGrains ?? this.yellowGrains,
      greenGrains: greenGrains ?? this.greenGrains,
      avgLength: avgLength ?? this.avgLength,
      avgWidth: avgWidth ?? this.avgWidth,
      avgLWR: avgLWR ?? this.avgLWR,
      cielabL: cielabL ?? this.cielabL,
      cielabA: cielabA ?? this.cielabA,
      cielabB: cielabB ?? this.cielabB,
      brokenPercent: brokenPercent ?? this.brokenPercent,
      blackPercent: blackPercent ?? this.blackPercent,
      chalkyPercent: chalkyPercent ?? this.chalkyPercent,
      redPercent: redPercent ?? this.redPercent,
      yellowPercent: yellowPercent ?? this.yellowPercent,
      greenPercent: greenPercent ?? this.greenPercent,
      longPercent: longPercent ?? this.longPercent,
      mediumPercent: mediumPercent ?? this.mediumPercent,
      shortPercent: shortPercent ?? this.shortPercent,
      millingGrade: millingGrade ?? this.millingGrade,
      grainShape: grainShape ?? this.grainShape,
      grainLength: grainLength ?? this.grainLength,
      chalkinessStatus: chalkinessStatus ?? this.chalkinessStatus,
      qualityIssues: qualityIssues ?? this.qualityIssues,
      modelVersion: modelVersion ?? this.modelVersion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (scanDate.present) {
      map['scan_date'] = Variable<DateTime>(scanDate.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (totalGrains.present) {
      map['total_grains'] = Variable<int>(totalGrains.value);
    }
    if (brokenGrains.present) {
      map['broken_grains'] = Variable<int>(brokenGrains.value);
    }
    if (longGrains.present) {
      map['long_grains'] = Variable<int>(longGrains.value);
    }
    if (mediumGrains.present) {
      map['medium_grains'] = Variable<int>(mediumGrains.value);
    }
    if (shortGrains.present) {
      map['short_grains'] = Variable<int>(shortGrains.value);
    }
    if (blackGrains.present) {
      map['black_grains'] = Variable<int>(blackGrains.value);
    }
    if (chalkyGrains.present) {
      map['chalky_grains'] = Variable<int>(chalkyGrains.value);
    }
    if (redGrains.present) {
      map['red_grains'] = Variable<int>(redGrains.value);
    }
    if (yellowGrains.present) {
      map['yellow_grains'] = Variable<int>(yellowGrains.value);
    }
    if (greenGrains.present) {
      map['green_grains'] = Variable<int>(greenGrains.value);
    }
    if (avgLength.present) {
      map['avg_length'] = Variable<double>(avgLength.value);
    }
    if (avgWidth.present) {
      map['avg_width'] = Variable<double>(avgWidth.value);
    }
    if (avgLWR.present) {
      map['avg_l_w_r'] = Variable<double>(avgLWR.value);
    }
    if (cielabL.present) {
      map['cielab_l'] = Variable<double>(cielabL.value);
    }
    if (cielabA.present) {
      map['cielab_a'] = Variable<double>(cielabA.value);
    }
    if (cielabB.present) {
      map['cielab_b'] = Variable<double>(cielabB.value);
    }
    if (brokenPercent.present) {
      map['broken_percent'] = Variable<double>(brokenPercent.value);
    }
    if (blackPercent.present) {
      map['black_percent'] = Variable<double>(blackPercent.value);
    }
    if (chalkyPercent.present) {
      map['chalky_percent'] = Variable<double>(chalkyPercent.value);
    }
    if (redPercent.present) {
      map['red_percent'] = Variable<double>(redPercent.value);
    }
    if (yellowPercent.present) {
      map['yellow_percent'] = Variable<double>(yellowPercent.value);
    }
    if (greenPercent.present) {
      map['green_percent'] = Variable<double>(greenPercent.value);
    }
    if (longPercent.present) {
      map['long_percent'] = Variable<double>(longPercent.value);
    }
    if (mediumPercent.present) {
      map['medium_percent'] = Variable<double>(mediumPercent.value);
    }
    if (shortPercent.present) {
      map['short_percent'] = Variable<double>(shortPercent.value);
    }
    if (millingGrade.present) {
      map['milling_grade'] = Variable<String>(millingGrade.value);
    }
    if (grainShape.present) {
      map['grain_shape'] = Variable<String>(grainShape.value);
    }
    if (grainLength.present) {
      map['grain_length'] = Variable<String>(grainLength.value);
    }
    if (chalkinessStatus.present) {
      map['chalkiness_status'] = Variable<String>(chalkinessStatus.value);
    }
    if (qualityIssues.present) {
      map['quality_issues'] = Variable<String>(qualityIssues.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScansCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('imagePath: $imagePath, ')
          ..write('scanDate: $scanDate, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('totalGrains: $totalGrains, ')
          ..write('brokenGrains: $brokenGrains, ')
          ..write('longGrains: $longGrains, ')
          ..write('mediumGrains: $mediumGrains, ')
          ..write('shortGrains: $shortGrains, ')
          ..write('blackGrains: $blackGrains, ')
          ..write('chalkyGrains: $chalkyGrains, ')
          ..write('redGrains: $redGrains, ')
          ..write('yellowGrains: $yellowGrains, ')
          ..write('greenGrains: $greenGrains, ')
          ..write('avgLength: $avgLength, ')
          ..write('avgWidth: $avgWidth, ')
          ..write('avgLWR: $avgLWR, ')
          ..write('cielabL: $cielabL, ')
          ..write('cielabA: $cielabA, ')
          ..write('cielabB: $cielabB, ')
          ..write('brokenPercent: $brokenPercent, ')
          ..write('blackPercent: $blackPercent, ')
          ..write('chalkyPercent: $chalkyPercent, ')
          ..write('redPercent: $redPercent, ')
          ..write('yellowPercent: $yellowPercent, ')
          ..write('greenPercent: $greenPercent, ')
          ..write('longPercent: $longPercent, ')
          ..write('mediumPercent: $mediumPercent, ')
          ..write('shortPercent: $shortPercent, ')
          ..write('millingGrade: $millingGrade, ')
          ..write('grainShape: $grainShape, ')
          ..write('grainLength: $grainLength, ')
          ..write('chalkinessStatus: $chalkinessStatus, ')
          ..write('qualityIssues: $qualityIssues, ')
          ..write('modelVersion: $modelVersion')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ScansTable scans = $ScansTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, scans];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String email,
      required String password,
      required String role,
      Value<String?> organisation,
      Value<DateTime> createdAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> email,
      Value<String> password,
      Value<String> role,
      Value<String?> organisation,
      Value<DateTime> createdAt,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ScansTable, List<Scan>> _scansRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scans,
    aliasName: $_aliasNameGenerator(db.users.id, db.scans.userId),
  );

  $$ScansTableProcessedTableManager get scansRefs {
    final manager = $$ScansTableTableManager(
      $_db,
      $_db.scans,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organisation => $composableBuilder(
    column: $table.organisation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scansRefs(
    Expression<bool> Function($$ScansTableFilterComposer f) f,
  ) {
    final $$ScansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scans,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScansTableFilterComposer(
            $db: $db,
            $table: $db.scans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organisation => $composableBuilder(
    column: $table.organisation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get organisation => $composableBuilder(
    column: $table.organisation,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> scansRefs<T extends Object>(
    Expression<T> Function($$ScansTableAnnotationComposer a) f,
  ) {
    final $$ScansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scans,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScansTableAnnotationComposer(
            $db: $db,
            $table: $db.scans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool scansRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> organisation = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                email: email,
                password: password,
                role: role,
                organisation: organisation,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String email,
                required String password,
                required String role,
                Value<String?> organisation = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                email: email,
                password: password,
                role: role,
                organisation: organisation,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({scansRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (scansRefs) db.scans],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scansRefs)
                    await $_getPrefetchedData<User, $UsersTable, Scan>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences._scansRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).scansRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool scansRefs})
    >;
typedef $$ScansTableCreateCompanionBuilder =
    ScansCompanion Function({
      Value<int> id,
      required int userId,
      required String imagePath,
      Value<DateTime> scanDate,
      Value<double?> latitude,
      Value<double?> longitude,
      required int totalGrains,
      required int brokenGrains,
      required int longGrains,
      required int mediumGrains,
      required int shortGrains,
      required int blackGrains,
      required int chalkyGrains,
      required int redGrains,
      required int yellowGrains,
      required int greenGrains,
      required double avgLength,
      required double avgWidth,
      required double avgLWR,
      required double cielabL,
      required double cielabA,
      required double cielabB,
      required double brokenPercent,
      required double blackPercent,
      required double chalkyPercent,
      required double redPercent,
      required double yellowPercent,
      required double greenPercent,
      required double longPercent,
      required double mediumPercent,
      required double shortPercent,
      required String millingGrade,
      required String grainShape,
      required String grainLength,
      required String chalkinessStatus,
      Value<String?> qualityIssues,
      required String modelVersion,
    });
typedef $$ScansTableUpdateCompanionBuilder =
    ScansCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> imagePath,
      Value<DateTime> scanDate,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<int> totalGrains,
      Value<int> brokenGrains,
      Value<int> longGrains,
      Value<int> mediumGrains,
      Value<int> shortGrains,
      Value<int> blackGrains,
      Value<int> chalkyGrains,
      Value<int> redGrains,
      Value<int> yellowGrains,
      Value<int> greenGrains,
      Value<double> avgLength,
      Value<double> avgWidth,
      Value<double> avgLWR,
      Value<double> cielabL,
      Value<double> cielabA,
      Value<double> cielabB,
      Value<double> brokenPercent,
      Value<double> blackPercent,
      Value<double> chalkyPercent,
      Value<double> redPercent,
      Value<double> yellowPercent,
      Value<double> greenPercent,
      Value<double> longPercent,
      Value<double> mediumPercent,
      Value<double> shortPercent,
      Value<String> millingGrade,
      Value<String> grainShape,
      Value<String> grainLength,
      Value<String> chalkinessStatus,
      Value<String?> qualityIssues,
      Value<String> modelVersion,
    });

final class $$ScansTableReferences
    extends BaseReferences<_$AppDatabase, $ScansTable, Scan> {
  $$ScansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias($_aliasNameGenerator(db.scans.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScansTableFilterComposer extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scanDate => $composableBuilder(
    column: $table.scanDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalGrains => $composableBuilder(
    column: $table.totalGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get brokenGrains => $composableBuilder(
    column: $table.brokenGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longGrains => $composableBuilder(
    column: $table.longGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mediumGrains => $composableBuilder(
    column: $table.mediumGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shortGrains => $composableBuilder(
    column: $table.shortGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get blackGrains => $composableBuilder(
    column: $table.blackGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chalkyGrains => $composableBuilder(
    column: $table.chalkyGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get redGrains => $composableBuilder(
    column: $table.redGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yellowGrains => $composableBuilder(
    column: $table.yellowGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get greenGrains => $composableBuilder(
    column: $table.greenGrains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgLength => $composableBuilder(
    column: $table.avgLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgWidth => $composableBuilder(
    column: $table.avgWidth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgLWR => $composableBuilder(
    column: $table.avgLWR,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cielabL => $composableBuilder(
    column: $table.cielabL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cielabA => $composableBuilder(
    column: $table.cielabA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cielabB => $composableBuilder(
    column: $table.cielabB,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get brokenPercent => $composableBuilder(
    column: $table.brokenPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get blackPercent => $composableBuilder(
    column: $table.blackPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chalkyPercent => $composableBuilder(
    column: $table.chalkyPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get redPercent => $composableBuilder(
    column: $table.redPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yellowPercent => $composableBuilder(
    column: $table.yellowPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get greenPercent => $composableBuilder(
    column: $table.greenPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longPercent => $composableBuilder(
    column: $table.longPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mediumPercent => $composableBuilder(
    column: $table.mediumPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shortPercent => $composableBuilder(
    column: $table.shortPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get millingGrade => $composableBuilder(
    column: $table.millingGrade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grainShape => $composableBuilder(
    column: $table.grainShape,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grainLength => $composableBuilder(
    column: $table.grainLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chalkinessStatus => $composableBuilder(
    column: $table.chalkinessStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qualityIssues => $composableBuilder(
    column: $table.qualityIssues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScansTableOrderingComposer
    extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scanDate => $composableBuilder(
    column: $table.scanDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalGrains => $composableBuilder(
    column: $table.totalGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get brokenGrains => $composableBuilder(
    column: $table.brokenGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longGrains => $composableBuilder(
    column: $table.longGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mediumGrains => $composableBuilder(
    column: $table.mediumGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shortGrains => $composableBuilder(
    column: $table.shortGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get blackGrains => $composableBuilder(
    column: $table.blackGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chalkyGrains => $composableBuilder(
    column: $table.chalkyGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get redGrains => $composableBuilder(
    column: $table.redGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yellowGrains => $composableBuilder(
    column: $table.yellowGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get greenGrains => $composableBuilder(
    column: $table.greenGrains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgLength => $composableBuilder(
    column: $table.avgLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgWidth => $composableBuilder(
    column: $table.avgWidth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgLWR => $composableBuilder(
    column: $table.avgLWR,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cielabL => $composableBuilder(
    column: $table.cielabL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cielabA => $composableBuilder(
    column: $table.cielabA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cielabB => $composableBuilder(
    column: $table.cielabB,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get brokenPercent => $composableBuilder(
    column: $table.brokenPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get blackPercent => $composableBuilder(
    column: $table.blackPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chalkyPercent => $composableBuilder(
    column: $table.chalkyPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get redPercent => $composableBuilder(
    column: $table.redPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yellowPercent => $composableBuilder(
    column: $table.yellowPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get greenPercent => $composableBuilder(
    column: $table.greenPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longPercent => $composableBuilder(
    column: $table.longPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mediumPercent => $composableBuilder(
    column: $table.mediumPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shortPercent => $composableBuilder(
    column: $table.shortPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get millingGrade => $composableBuilder(
    column: $table.millingGrade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grainShape => $composableBuilder(
    column: $table.grainShape,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grainLength => $composableBuilder(
    column: $table.grainLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chalkinessStatus => $composableBuilder(
    column: $table.chalkinessStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qualityIssues => $composableBuilder(
    column: $table.qualityIssues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScansTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get scanDate =>
      $composableBuilder(column: $table.scanDate, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get totalGrains => $composableBuilder(
    column: $table.totalGrains,
    builder: (column) => column,
  );

  GeneratedColumn<int> get brokenGrains => $composableBuilder(
    column: $table.brokenGrains,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longGrains => $composableBuilder(
    column: $table.longGrains,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mediumGrains => $composableBuilder(
    column: $table.mediumGrains,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shortGrains => $composableBuilder(
    column: $table.shortGrains,
    builder: (column) => column,
  );

  GeneratedColumn<int> get blackGrains => $composableBuilder(
    column: $table.blackGrains,
    builder: (column) => column,
  );

  GeneratedColumn<int> get chalkyGrains => $composableBuilder(
    column: $table.chalkyGrains,
    builder: (column) => column,
  );

  GeneratedColumn<int> get redGrains =>
      $composableBuilder(column: $table.redGrains, builder: (column) => column);

  GeneratedColumn<int> get yellowGrains => $composableBuilder(
    column: $table.yellowGrains,
    builder: (column) => column,
  );

  GeneratedColumn<int> get greenGrains => $composableBuilder(
    column: $table.greenGrains,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgLength =>
      $composableBuilder(column: $table.avgLength, builder: (column) => column);

  GeneratedColumn<double> get avgWidth =>
      $composableBuilder(column: $table.avgWidth, builder: (column) => column);

  GeneratedColumn<double> get avgLWR =>
      $composableBuilder(column: $table.avgLWR, builder: (column) => column);

  GeneratedColumn<double> get cielabL =>
      $composableBuilder(column: $table.cielabL, builder: (column) => column);

  GeneratedColumn<double> get cielabA =>
      $composableBuilder(column: $table.cielabA, builder: (column) => column);

  GeneratedColumn<double> get cielabB =>
      $composableBuilder(column: $table.cielabB, builder: (column) => column);

  GeneratedColumn<double> get brokenPercent => $composableBuilder(
    column: $table.brokenPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get blackPercent => $composableBuilder(
    column: $table.blackPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get chalkyPercent => $composableBuilder(
    column: $table.chalkyPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get redPercent => $composableBuilder(
    column: $table.redPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get yellowPercent => $composableBuilder(
    column: $table.yellowPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get greenPercent => $composableBuilder(
    column: $table.greenPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get longPercent => $composableBuilder(
    column: $table.longPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get mediumPercent => $composableBuilder(
    column: $table.mediumPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get shortPercent => $composableBuilder(
    column: $table.shortPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get millingGrade => $composableBuilder(
    column: $table.millingGrade,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grainShape => $composableBuilder(
    column: $table.grainShape,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grainLength => $composableBuilder(
    column: $table.grainLength,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chalkinessStatus => $composableBuilder(
    column: $table.chalkinessStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qualityIssues => $composableBuilder(
    column: $table.qualityIssues,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScansTable,
          Scan,
          $$ScansTableFilterComposer,
          $$ScansTableOrderingComposer,
          $$ScansTableAnnotationComposer,
          $$ScansTableCreateCompanionBuilder,
          $$ScansTableUpdateCompanionBuilder,
          (Scan, $$ScansTableReferences),
          Scan,
          PrefetchHooks Function({bool userId})
        > {
  $$ScansTableTableManager(_$AppDatabase db, $ScansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<DateTime> scanDate = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<int> totalGrains = const Value.absent(),
                Value<int> brokenGrains = const Value.absent(),
                Value<int> longGrains = const Value.absent(),
                Value<int> mediumGrains = const Value.absent(),
                Value<int> shortGrains = const Value.absent(),
                Value<int> blackGrains = const Value.absent(),
                Value<int> chalkyGrains = const Value.absent(),
                Value<int> redGrains = const Value.absent(),
                Value<int> yellowGrains = const Value.absent(),
                Value<int> greenGrains = const Value.absent(),
                Value<double> avgLength = const Value.absent(),
                Value<double> avgWidth = const Value.absent(),
                Value<double> avgLWR = const Value.absent(),
                Value<double> cielabL = const Value.absent(),
                Value<double> cielabA = const Value.absent(),
                Value<double> cielabB = const Value.absent(),
                Value<double> brokenPercent = const Value.absent(),
                Value<double> blackPercent = const Value.absent(),
                Value<double> chalkyPercent = const Value.absent(),
                Value<double> redPercent = const Value.absent(),
                Value<double> yellowPercent = const Value.absent(),
                Value<double> greenPercent = const Value.absent(),
                Value<double> longPercent = const Value.absent(),
                Value<double> mediumPercent = const Value.absent(),
                Value<double> shortPercent = const Value.absent(),
                Value<String> millingGrade = const Value.absent(),
                Value<String> grainShape = const Value.absent(),
                Value<String> grainLength = const Value.absent(),
                Value<String> chalkinessStatus = const Value.absent(),
                Value<String?> qualityIssues = const Value.absent(),
                Value<String> modelVersion = const Value.absent(),
              }) => ScansCompanion(
                id: id,
                userId: userId,
                imagePath: imagePath,
                scanDate: scanDate,
                latitude: latitude,
                longitude: longitude,
                totalGrains: totalGrains,
                brokenGrains: brokenGrains,
                longGrains: longGrains,
                mediumGrains: mediumGrains,
                shortGrains: shortGrains,
                blackGrains: blackGrains,
                chalkyGrains: chalkyGrains,
                redGrains: redGrains,
                yellowGrains: yellowGrains,
                greenGrains: greenGrains,
                avgLength: avgLength,
                avgWidth: avgWidth,
                avgLWR: avgLWR,
                cielabL: cielabL,
                cielabA: cielabA,
                cielabB: cielabB,
                brokenPercent: brokenPercent,
                blackPercent: blackPercent,
                chalkyPercent: chalkyPercent,
                redPercent: redPercent,
                yellowPercent: yellowPercent,
                greenPercent: greenPercent,
                longPercent: longPercent,
                mediumPercent: mediumPercent,
                shortPercent: shortPercent,
                millingGrade: millingGrade,
                grainShape: grainShape,
                grainLength: grainLength,
                chalkinessStatus: chalkinessStatus,
                qualityIssues: qualityIssues,
                modelVersion: modelVersion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String imagePath,
                Value<DateTime> scanDate = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                required int totalGrains,
                required int brokenGrains,
                required int longGrains,
                required int mediumGrains,
                required int shortGrains,
                required int blackGrains,
                required int chalkyGrains,
                required int redGrains,
                required int yellowGrains,
                required int greenGrains,
                required double avgLength,
                required double avgWidth,
                required double avgLWR,
                required double cielabL,
                required double cielabA,
                required double cielabB,
                required double brokenPercent,
                required double blackPercent,
                required double chalkyPercent,
                required double redPercent,
                required double yellowPercent,
                required double greenPercent,
                required double longPercent,
                required double mediumPercent,
                required double shortPercent,
                required String millingGrade,
                required String grainShape,
                required String grainLength,
                required String chalkinessStatus,
                Value<String?> qualityIssues = const Value.absent(),
                required String modelVersion,
              }) => ScansCompanion.insert(
                id: id,
                userId: userId,
                imagePath: imagePath,
                scanDate: scanDate,
                latitude: latitude,
                longitude: longitude,
                totalGrains: totalGrains,
                brokenGrains: brokenGrains,
                longGrains: longGrains,
                mediumGrains: mediumGrains,
                shortGrains: shortGrains,
                blackGrains: blackGrains,
                chalkyGrains: chalkyGrains,
                redGrains: redGrains,
                yellowGrains: yellowGrains,
                greenGrains: greenGrains,
                avgLength: avgLength,
                avgWidth: avgWidth,
                avgLWR: avgLWR,
                cielabL: cielabL,
                cielabA: cielabA,
                cielabB: cielabB,
                brokenPercent: brokenPercent,
                blackPercent: blackPercent,
                chalkyPercent: chalkyPercent,
                redPercent: redPercent,
                yellowPercent: yellowPercent,
                greenPercent: greenPercent,
                longPercent: longPercent,
                mediumPercent: mediumPercent,
                shortPercent: shortPercent,
                millingGrade: millingGrade,
                grainShape: grainShape,
                grainLength: grainLength,
                chalkinessStatus: chalkinessStatus,
                qualityIssues: qualityIssues,
                modelVersion: modelVersion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ScansTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$ScansTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$ScansTableReferences
                                    ._userIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScansTable,
      Scan,
      $$ScansTableFilterComposer,
      $$ScansTableOrderingComposer,
      $$ScansTableAnnotationComposer,
      $$ScansTableCreateCompanionBuilder,
      $$ScansTableUpdateCompanionBuilder,
      (Scan, $$ScansTableReferences),
      Scan,
      PrefetchHooks Function({bool userId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ScansTableTableManager get scans =>
      $$ScansTableTableManager(_db, _db.scans);
}
