import 'dart:io';
import 'package:africa_rice/data/database/app_database.dart';
import 'package:africa_rice/data/services/user_session.dart';
import 'package:africa_rice/widgets/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final AppDatabase _database;
  List<Scan> _scans = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
    _loadScans();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  Future<void> _loadScans() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userId = await UserSession.getUserId();
      if (userId == null) {
        setState(() {
          _errorMessage = 'User not logged in';
          _isLoading = false;
        });
        return;
      }

      final scans = await _database.getAllScans(userId);
      setState(() {
        _scans = scans;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading scans: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteScan(Scan scan) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Scan'),
        content: const Text('Are you sure you want to delete this scan? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _database.deleteScan(scan.id);
        
        // Delete the image file if it exists
        final imageFile = File(scan.imagePath);
        if (await imageFile.exists()) {
          await imageFile.delete();
        }
        
        await _loadScans();
        
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Scan deleted successfully')),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting scan: $e')),
        );
      }
    }
  }

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
        title: const Text('Scan History'),
        centerTitle: true,
        actions: [
          if (_scans.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Info',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Scan History'),
                    content: Text('Showing ${_scans.length} most recent scans.\nMaximum of 100 scans are stored.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadScans,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_scans.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history, size: 80, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No scan history yet',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Text(
                'Scan your first rice sample to see results here',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadScans,
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _scans.length,
        itemBuilder: (context, index) {
          final scan = _scans[index];
          return _buildScanCard(scan);
        },
      ),
    );
  }

  Widget _buildScanCard(Scan scan) {
    final imageFile = File(scan.imagePath);
    final imageExists = imageFile.existsSync();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(scan: scan),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imageExists
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
              ),
              const SizedBox(width: 12),
              
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date
                    Text(
                      DateFormat('MMM dd, yyyy - hh:mm a').format(scan.scanDate),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    
                    // Milling Grade
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getGradeColor(scan.millingGrade).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _getGradeColor(scan.millingGrade),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            scan.millingGrade,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getGradeColor(scan.millingGrade),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          scan.grainShape,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    
                    // Additional info
                    Row(
                      children: [
                        Icon(Icons.grain, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          '${scan.totalGrains} grains',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.broken_image, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          '${scan.brokenPercent.toStringAsFixed(1)}% broken',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Actions
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view',
                    child: Row(
                      children: [
                        Icon(Icons.visibility, size: 20),
                        SizedBox(width: 8),
                        Text('View Details'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'view') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsScreen(scan: scan),
                      ),
                    );
                  } else if (value == 'delete') {
                    _deleteScan(scan);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
