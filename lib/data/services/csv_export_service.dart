import 'dart:io';
import 'package:africa_rice/data/database/app_database.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CSVExportService {
  /// Export scans to CSV file
  static Future<String> exportToCSV(List<Scan> scans) async {
    final buffer = StringBuffer();
    
    // CSV Header
    buffer.writeln(
      'Scan ID,Date & Time,GPS Latitude,GPS Longitude,Total Grains,Broken Grains,Long Grains,Medium Grains,Short Grains,'
      'Black Grains,Chalky Grains,Red Grains,Yellow Grains,Green Grains,'
      'Avg Length (mm),Avg Width (mm),Length-Width Ratio,'
      'CIE L*,CIE a*,CIE b*,'
      'Broken %,Black %,Chalky %,Red %,Yellow %,Green %,Long %,Medium %,Short %,'
      'Milling Grade,Grain Shape,Grain Length,Chalkiness Status,Quality Issues,Model Version'
    );
    
    // CSV Data
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    for (final scan in scans) {
      buffer.writeln(
        '${scan.id},'
        '${dateFormat.format(scan.scanDate)},'
        '${scan.latitude ?? ""},'
        '${scan.longitude ?? ""},'
        '${scan.totalGrains},'
        '${scan.brokenGrains},'
        '${scan.longGrains},'
        '${scan.mediumGrains},'
        '${scan.shortGrains},'
        '${scan.blackGrains},'
        '${scan.chalkyGrains},'
        '${scan.redGrains},'
        '${scan.yellowGrains},'
        '${scan.greenGrains},'
        '${scan.avgLength.toStringAsFixed(2)},'
        '${scan.avgWidth.toStringAsFixed(2)},'
        '${scan.avgLWR.toStringAsFixed(2)},'
        '${scan.cielabL.toStringAsFixed(2)},'
        '${scan.cielabA.toStringAsFixed(2)},'
        '${scan.cielabB.toStringAsFixed(2)},'
        '${scan.brokenPercent.toStringAsFixed(2)},'
        '${scan.blackPercent.toStringAsFixed(2)},'
        '${scan.chalkyPercent.toStringAsFixed(2)},'
        '${scan.redPercent.toStringAsFixed(2)},'
        '${scan.yellowPercent.toStringAsFixed(2)},'
        '${scan.greenPercent.toStringAsFixed(2)},'
        '${scan.longPercent.toStringAsFixed(2)},'
        '${scan.mediumPercent.toStringAsFixed(2)},'
        '${scan.shortPercent.toStringAsFixed(2)},'
        '"${scan.millingGrade}",'
        '"${scan.grainShape}",'
        '"${scan.grainLength}",'
        '"${scan.chalkinessStatus}",'
        '"${scan.qualityIssues ?? ""}",'
        '"${scan.modelVersion}"'
      );
    }
    
    return buffer.toString();
  }
  
  /// Save and share CSV file
  static Future<void> exportAndShare(List<Scan> scans, {String? username}) async {
    if (scans.isEmpty) {
      throw Exception('No scans to export');
    }
    
    // Generate CSV content
    final csvContent = await exportToCSV(scans);
    
    // Save to temporary file
    final directory = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final userPrefix = username != null ? '${username}_' : '';
    final fileName = 'africa_rice_${userPrefix}export_$timestamp.csv';
    final filePath = '${directory.path}/$fileName';
    
    final file = File(filePath);
    await file.writeAsString(csvContent);
    
    // Share the file
    await Share.shareXFiles(
      [XFile(filePath)],
      subject: 'Africa Rice Quality Assessment Data',
      text: 'Rice quality assessment data exported from Africa Rice app.\n'
            'Total scans: ${scans.length}\n'
            'Export date: ${DateFormat('MMM dd, yyyy HH:mm').format(DateTime.now())}',
    );
  }
}
