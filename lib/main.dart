import 'package:flutter/material.dart';
import 'package:answers/start_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
