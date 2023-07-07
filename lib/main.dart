import 'package:auth_with_phone_number/features/auth_feature/presention/Screen/signup_with_phone_number.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "vazir"),
      home: const SignupScreen(),
    );
  }
}
