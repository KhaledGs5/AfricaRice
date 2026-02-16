import 'package:africa_rice/data/services/user_session.dart';
import 'package:africa_rice/widgets/capture.dart';
import 'package:africa_rice/widgets/profile.dart';
import 'package:africa_rice/widgets/history_screen.dart';
import 'package:africa_rice/widgets/disclaimer_dialog.dart';
import 'package:africa_rice/data/services/csv_export_service.dart';
import 'package:africa_rice/data/services/rice_quality_model.dart';
import 'package:africa_rice/data/database/app_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';
  String _email = '';
  int _currentPageIndex = 0; // 0 = Capture, 1 = History, 2 = Profile
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AppDatabase _database;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
    _loadUserData();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final username = await UserSession.getUsername();
    final email = await UserSession.getEmail();
    setState(() {
      _username = username ?? 'User';
      _email = email ?? '';
    });
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    _scaffoldKey.currentState?.closeEndDrawer(); 
    
    if (index == 0 || index == 1 || index == 2) {
      _loadUserData();
    }
  }

  String get _currentPageTitle {
    switch (_currentPageIndex) {
      case 0:
        return 'Capture Image';
      case 1:
        return 'Scan History';
      case 2:
        return 'Profile';
      default:
        return 'Africa Rice';
    }
  }

  Widget get _currentPage {
    switch (_currentPageIndex) {
      case 0:
        return const Capture();
      case 1:
        return const HistoryScreen();
      case 2:
        return ProfilePage(key: ValueKey(_currentPageIndex)); 
      default:
        return const Capture();
    }
  }

  Future<void> _exportData() async {
    try {
      final userId = await UserSession.getUserId();
      if (userId == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      final scans = await _database.getAllScans(userId);
      
      if (scans.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No scans to export')),
        );
        return;
      }

      await CSVExportService.exportAndShare(scans, username: _username);
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exported ${scans.length} scans successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    }
  }

  String _getModelVersion() {
    return RiceQualityModel.modelVersion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_currentPageTitle),
        centerTitle: true,
        automaticallyImplyLeading: false, 
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              child: CircleAvatar(
                backgroundColor: Colors.green.shade700,
                child: Text(
                  _username.isNotEmpty ? _username[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade700,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      _username.isNotEmpty ? _username[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Capture'),
              selected: _currentPageIndex == 0,
              selectedTileColor: Colors.green.shade50,
              onTap: () => _navigateToPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              selected: _currentPageIndex == 1,
              selectedTileColor: Colors.green.shade50,
              onTap: () => _navigateToPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              selected: _currentPageIndex == 2,
              selectedTileColor: Colors.green.shade50,
              onTap: () => _navigateToPage(2),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('Export Data'),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
                _exportData();
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning_amber_rounded),
              title: const Text('View Disclaimer'),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
                showDisclaimerDialog(context, canDismiss: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('About Africa Rice'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Africa Rice Quality Assessment App',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          const Text('Version 1.0.0'),
                          const SizedBox(height: 16),
                          const Text(
                            'A mobile application for rapid field-level rice quality assessment using AI-powered image analysis.',
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
                          const Text(
                            'Model Information',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Model Version: ${_getModelVersion()}',
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Based on UNIDO AfricaRice Quality Assessment Challenge',
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
                          const Text(
                            'Developed By',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'UNIDO & AfricaRice',
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Intellectual property co-owned by the United Nations Industrial Development Organization (UNIDO) and Africa Rice Center (AfricaRice).',
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
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
      ),
      body: _currentPage,
    );
  }
}
