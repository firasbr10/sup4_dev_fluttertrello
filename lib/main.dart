import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sup4_dev_fluttertrello/providers/auth_provider.dart';
import 'package:sup4_dev_fluttertrello/views/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import 'package:sup4_dev_fluttertrello/views/dashboard/dashboard_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialisation Firebase avec configuration explicite
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web, 
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUP4-DEV FlutterTrello',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {
        '/dashboard': (context) => const DashboardScreen(), 
      },
    );
  }
}