import 'package:africa_rice/data/services/user_session.dart';
import 'package:africa_rice/widgets/capture.dart';
import 'package:africa_rice/widgets/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';
  String _email = '';
  int _currentPageIndex = 0; // 0 = Capture, 1 = Profile
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
    _scaffoldKey.currentState?.closeEndDrawer(); // Close the drawer after selection
    
    // Reload user data when navigating to any page to reflect any profile updates
    if (index == 0 || index == 1) {
      _loadUserData();
    }
  }

  String get _currentPageTitle {
    switch (_currentPageIndex) {
      case 0:
        return 'Capture Image';
      case 1:
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
        return ProfilePage(key: ValueKey(_currentPageIndex)); // Force rebuild with key
      default:
        return const Capture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_currentPageTitle),
        centerTitle: true,
        automaticallyImplyLeading: false, // Disable back button
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
                  const SizedBox(height: 12),
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
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              selected: _currentPageIndex == 1,
              selectedTileColor: Colors.green.shade50,
              onTap: () => _navigateToPage(1),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('About Africa Rice'),
                    content: const Text(
                      'Africa Rice App\nVersion 1.0.0\n\nA rice grain analysis application.',
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
