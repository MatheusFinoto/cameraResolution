import 'package:camera_resolution/src/view/base/base_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Resolution',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const BaseScreen(),
    );
  }
}
