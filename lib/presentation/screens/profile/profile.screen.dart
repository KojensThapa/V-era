import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Widget'),
        ),
        body: const Center(
          child: Text('Hello, World! from profile.screen.dart'),
        ),
      ), 
    );
  }
}