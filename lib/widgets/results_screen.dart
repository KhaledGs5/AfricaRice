import 'dart:io';
import 'package:africa_rice/data/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultsScreen extends StatelessWidget {
  final Scan scan;

  const ResultsScreen({super.key, required this.scan});

  Color _getGradeColor(String grade) {
    switch (grade.toLowerCase()) {
      case 'premium':
        return Colors.green.shade700;
      case 'grade 1':
        return Colors.green;
      case 'grade 2':
        return Colors.orange;
      case 'grade 3':
        return Colors.red.shade300;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rice Quality Results'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image preview
            if (File(scan.imagePath).existsSync())
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Image.file(
                  File(scan.imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scan metadata
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('MMM dd, yyyy - hh:mm a').format(scan.scanDate),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          if (scan.latitude != null && scan.longitude != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'GPS: ${scan.latitude!.toStringAsFixed(6)}, ${scan.longitude!.toStringAsFixed(6)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.api, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'Model: ${scan.modelVersion}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Summary Section
                  const Text(
                    'Quality Summary',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
                  // Milling Grade
                  _buildSummaryCard(
                    'Milling Grade',
                    scan.millingGrade,
                    _getGradeColor(scan.millingGrade),
                    Icons.grade,
                  ),
                  
                  // Grain Shape
                  _buildSummaryCard(
                    'Grain Shape',
                    scan.grainShape,
                    Colors.blue,
                    Icons.straighten,
                  ),
                  
                  // Grain Length Classification
                  _buildSummaryCard(
                    'Grain Length',
                    scan.grainLength,
                    Colors.purple,
                    Icons.height,
                  ),
                  
                  // Chalkiness Status
                  _buildSummaryCard(
                    'Chalkiness',
                    scan.chalkinessStatus,
                    scan.chalkinessStatus.toLowerCase().contains('not') 
                        ? Colors.green 
                        : Colors.orange,
                    Icons.blur_on,
                  ),
                  
                  // Quality Issues
                  if (scan.qualityIssues != null && scan.qualityIssues!.isNotEmpty)
                    _buildSummaryCard(
                      'Quality Issues',
                      scan.qualityIssues!,
                      Colors.red,
                      Icons.warning,
                    ),
                  
                  const SizedBox(height: 24),
                  const Divider(),
                  
                  // Detailed Metrics
                  ExpansionTile(
                    title: const Text(
                      'Detailed Metrics',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    initiallyExpanded: false,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Grain Count & Structure
                            _buildDetailSection(
                              'Grain Count & Structure',
                              [
                                _buildDetailRow('Total Grains', '${scan.totalGrains}'),
                                _buildDetailRow('Broken Grains', '${scan.brokenGrains} (${scan.brokenPercent.toStringAsFixed(1)}%)'),
                                _buildDetailRow('Long Grains', '${scan.longGrains} (${scan.longPercent.toStringAsFixed(1)}%)'),
                                _buildDetailRow('Medium Grains', '${scan.mediumGrains} (${scan.mediumPercent.toStringAsFixed(1)}%)'),
                                _buildDetailRow('Short Grains', '${scan.shortGrains} (${scan.shortPercent.toStringAsFixed(1)}%)'),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Grain Color Composition
                            _buildDetailSection(
                              'Grain Color Composition',
                              [
                                _buildDetailRow('Black Grains', '${scan.blackGrains} (${scan.blackPercent.toStringAsFixed(1)}%)'),
                                _buildDetailRow('Chalky Grains', '${scan.chalkyGrains} (${scan.chalkyPercent.toStringAsFixed(1)}%)'),
                                _buildDetailRow('Red Grains', '${scan.redGrains} (${scan.redPercent.toStringAsFixed(1)}%)'),
                                _buildDetailRow('Yellow Grains', '${scan.yellowGrains} (${scan.yellowPercent.toStringAsFixed(1)}%)'),
                                _buildDetailRow('Green Grains', '${scan.greenGrains} (${scan.greenPercent.toStringAsFixed(1)}%)'),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Kernel Shape Measurements
                            _buildDetailSection(
                              'Kernel Shape (Average)',
                              [
                                _buildDetailRow('Length', '${scan.avgLength.toStringAsFixed(2)} mm'),
                                _buildDetailRow('Width', '${scan.avgWidth.toStringAsFixed(2)} mm'),
                                _buildDetailRow('Length-to-Width Ratio', scan.avgLWR.toStringAsFixed(2)),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // CIELAB Color Values
                            _buildDetailSection(
                              'CIELAB Color Profile',
                              [
                                _buildDetailRow('L* (Lightness)', scan.cielabL.toStringAsFixed(2)),
                                _buildDetailRow('a* (Red-Green)', scan.cielabA.toStringAsFixed(2)),
                                _buildDetailRow('b* (Yellow-Blue)', scan.cielabB.toStringAsFixed(2)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Classifications Legend
                  ExpansionTile(
                    title: const Text(
                      'Understanding Classifications',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    initiallyExpanded: false,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLegendSection(
                              'Milling Grade (Based on Broken %)',
                              [
                                'Premium: Less than 5% broken',
                                'Grade 1: 5-10% broken',
                                'Grade 2: 10-15% broken',
                                'Grade 3: 15-20% broken',
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildLegendSection(
                              'Grain Shape (Length-Width Ratio)',
                              [
                                'Bold: LWR < 2.1',
                                'Medium: LWR 2.2 - 2.9',
                                'Slender: LWR > 3.0',
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildLegendSection(
                              'Grain Length Classification',
                              [
                                'Long grain: >90% long grains',
                                'Medium grain: >90% medium grains',
                                'Short grain: >90% short grains',
                                'Mixed: None of the above',
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildLegendSection(
                              'Quality Indicators',
                              [
                                'Chalky: >20% chalky grains',
                                'Damaged: >10% black grains',
                                'Immature: >10% green grains',
                                'Red strips: >10% red grains',
                                'Fermented: >10% yellow grains (non-parboiled)',
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: rows),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 6),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item, style: const TextStyle(fontSize: 13))),
                ],
              ),
            )),
      ],
    );
  }
}
