import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'https://reqres.in/api'; // Replace with your API endpoint
// Save the login state
  Future<void> saveLoginState() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLoggedIn', true);
  }

  // Check the login state
  Future<bool> isUserLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLoggedIn') ?? false;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to log in'); // You can customize error handling as needed
    }
  }

    Future<Map<String, dynamic>> getUserData(int count) async {
    final response = await http.get(
      Uri.parse('https://randomuser.me/api/?results=$count'), // Use JSONPlaceholder as an example
    );

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);
      if (users.isNotEmpty) {
        final user = users[0] as Map<String, dynamic>;
        // if (user.) {
          return user;
        // }
      }
      throw Exception('FAILED');
    } else {
      throw Exception('API failed: ${response.reasonPhrase}');
    }
  }

}

