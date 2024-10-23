// screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'admin_request_list_screen.dart';
import 'user_request_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isAdmin = false; // Replace this with actual admin check logic

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: isAdmin ? 2 : 1, vsync: this);
    _checkUserRole(); // Check if user is admin
  }

  void _checkUserRole() async {
    // Here, implement logic to check if the user is an admin
    // For simplicity, it's hardcoded to false.
    // You can fetch admin roles from Firebase if necessary.
    setState(() {
      isAdmin = false; // Adjust this based on real authentication logic
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    // Redirect to login screen after logout
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpdesk System'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
        bottom: isAdmin
            ? TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'User Requests'),
                  Tab(text: 'Admin Requests'),
                ],
              )
            : null,
      ),
      body: isAdmin
          ? TabBarView(
              controller: _tabController,
              children: const [
                UserRequestListScreen(),
                AdminRequestListScreen(),
              ],
            )
          : const UserRequestListScreen(),
    );
  }
}
