import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MistriApp());
}

class MistriApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mistri.com',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
