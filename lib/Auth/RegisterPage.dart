import 'dart:convert';
import 'package:bloombox_mobile/ApiCalls.dart';
import 'package:bloombox_mobile/Auth/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController password_confirmationController = TextEditingController();
  
  bool isLoading = false;
  String errorMessage = '';


  Future<void> register() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String passwordConfirmation = password_confirmationController.text;

    // Placeholder API endpoint for registration
    // ignore: prefer_const_declarations
    //  final String apiUrl = 'https://1c8b-102-217-64-115.ngrok-free.app /api/user-register';
     final String apiUrl = 'http://127.0.0.1:8000//api/user-register';


    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
          // 'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 201) {
        // Handle successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        // Handle error responses
        setState(() {
          errorMessage = 'Registration failed: ${response.body}';
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        errorMessage = 'An error occurred: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/BLOOM.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Register',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Prompt Text
              const Text(
                'Create a new account to get started.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Name TextField
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              // Email TextField
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // Password TextField
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
                // Password TextField
              TextField(
                controller: password_confirmationController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Register Button
              ElevatedButton(
                onPressed: isLoading ? null : register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  backgroundColor: const Color.fromARGB(255, 207, 26, 26),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Register', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              // Display error message if any
              if (errorMessage.isNotEmpty)
               Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
               
              // Navigate to Login Page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 14, 4, 160),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
