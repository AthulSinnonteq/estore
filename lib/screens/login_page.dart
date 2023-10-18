import 'package:estore/screens/home.dart';
import 'package:estore/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Flag to track API call loading
  bool isPasswordVisible = false;

  // final apiService = ApiService('https://reqres.in/');
  final ApiService apiService = ApiService(); // Create an instance of the ApiService
  Future<void> login() async {
    setState(() {
      isLoading = true; // Show loader
    });
    // final username = usernameController.text;
    // final password = passwordController.text;

    final username = 'eve.holt@reqres.in';
    final password = 'cityslicka';

    // final response = await http.post(
    //   Uri.parse('https://reqres.in/api/login'), // Replace with your API endpoint
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, dynamic>{
    //     'email': username,
    //     'password': password,
    //   }),
    // );

    // if (response.statusCode == 200) {
    //   // Authentication successful, handle the response here.
    //   final responseData = json.decode(response.body);
    //   print('Login successful: $responseData');
    //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
    //   // Navigate to a new page upon successful login using pushAndRemoveUntil
   
    // // Navigator.pushAndRemoveUntil(
    // //   context,
    // //   MaterialPageRoute(builder: (context) => HomePage()), // Replace with your new page/widget
    // //   (route) => false, // This will remove all existing routes from the navigation stack
    // // );

    // } else {
    //   // Authentication failed, handle errors or other status codes.
    //   print('Login failed: ${response.reasonPhrase}');

    // }

  try {
      final response = await apiService.login(username, password);
      print('Login successful: $response');
      // Save the login state
    await apiService.saveLoginState();
      // Handle the response here
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      //   (route) => false,
      // );

    } catch (e) {
      print('Login failed: $e');
    }

    setState(() {
      isLoading = false; // Show loader
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login >>', style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/logo.jpg')), // Your logo or image
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  }, icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off))
                ),
                obscureText: !isPasswordVisible,
                // obscureText: true,

              ),
            ),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
            if(isLoading)
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}