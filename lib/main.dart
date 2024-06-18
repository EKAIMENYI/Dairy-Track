import 'package:dairytrack/Sign_In/SignInPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dairy Track App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor:
              Color.fromARGB(255, 206, 201, 215), // Light blue base color
        ),
        useMaterial3: true,
      ),
      home: SignInPage(),
    );
  }
}
