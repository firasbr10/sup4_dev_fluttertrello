import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sup4_dev_fluttertrello/providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).signOut(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connecté en tant que : ${user?.email ?? ''}'),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Indicateur de chargement temporaire
          ],
        ),
      ),
    );
  }
}