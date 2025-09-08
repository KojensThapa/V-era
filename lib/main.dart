import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v_era/presentation/screens/splash/splash_screen.dart';
import 'package:v_era/presentation/screens/profile/profile.screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V-era',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      // Add this later when you have other screens ready:
      routes: {
      //   '/dashboard': (context) => const MainDashboard(),
      //   '/login': (context) => const LoginScreen(),
      //   '/signup': (context) => const SignupScreen(),
      //   '/scan': (context) => const ScanScreen(),
      //   '/events': (context) => const EventsScreen(),
        '/profile': (context) => const ProfileScreen(),
        // Add other routes as you develop them
      },
    );
  }
}