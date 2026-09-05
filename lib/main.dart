import 'package:humanbeans_clock/Clock.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  /// Root for the clock app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Eventually',
      home: Clock(),
      debugShowCheckedModeBanner: false,
    );
  }
}
