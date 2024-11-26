import 'dart:convert';
import 'package:bloombox_mobile/Auth/RegisterPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  //  final String baseUrl = 'https://1c8b-102-217-64-115.ngrok-free.app ';
  // final String baseUrl = 'https://e236-156-0-233-57.ngrok-free.app/api';


  // ignore: non_constant_identifier_names
  Future<String?> register(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/user-register');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
     
      }),
    );

  
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['token']; // Return token if registration is successful
    } else {
      // You can log or handle the error message here
      return null; // Registration failed
    }
  }

  logout() {}
  }

  // Login a user
  // ignore: non_constant_identifier_names
  Future<String?> login(String email, String password) async {
    // ignore: prefer_typing_uninitialized_variables
    var baseUrl;
    final url = Uri.parse('$baseUrl/user-login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

       if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      
      // Save token to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      
      return token; // return token if needed
    } else {
      return null;
    }
  
  }
    // Logout a user
  Future<bool> logout() async {
    var baseUrl;
    final url = Uri.parse('$baseUrl/user-logout'); // Correctly use baseUrl
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve stored token

    if (token == null) {
      return false; 
    }

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token" 
      },
    );

    if (response.statusCode == 200) {
      return true; 
    } else {
      return false; 
    }
  }



