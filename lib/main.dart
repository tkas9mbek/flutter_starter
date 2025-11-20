import 'package:flutter/material.dart';

void main() {
  runApp(const UIKitDemoApp());
}

class UIKitDemoApp extends StatelessWidget {
  const UIKitDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starter UIKit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Starter UIKit Package'),
        ),
      ),
    );
  }
}
