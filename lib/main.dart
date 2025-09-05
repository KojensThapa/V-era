import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v_era/presentation/screens/splash/splash_screen.dart';

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
      home:  SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
} 