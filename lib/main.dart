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
      // The clock face keeps a 5:3 aspect ratio, so on other window shapes it
      // is letterboxed. Paint the bars black instead of leaving them
      // transparent (white page on web, window background on desktop).
      home: ColoredBox(color: Colors.black, child: Clock()),
      debugShowCheckedModeBanner: false,
    );
  }
}
