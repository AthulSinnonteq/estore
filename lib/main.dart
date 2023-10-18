import 'package:estore/screens/home.dart';
import 'package:estore/screens/login_page.dart';
import 'package:estore/services/api_service.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // final bool isLoggedIn;

  // MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage()
      // isLoggedIn ? HomePage() : LoginPage(), // Conditionally set the home page
    );
  }
}
