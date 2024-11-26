import 'dart:convert';
import 'package:bloombox_mobile/Auth/RegisterPage.dart';
import 'package:bloombox_mobile/Auth/ResetPasswordPage.dart';
import 'package:bloombox_mobile/HomePage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String emailError = '';
  String passwordError = '';

  Future<void> login() async {
    setState(() {
      isLoading = true;
      emailError = '';
      passwordError = '';
    });

      final String email = emailController.text;
    final String password = passwordController.text;
    Future<String> getDeviceName() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model ?? 'Unknown Android Device';
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name ?? 'Unknown iOS Device';
    }
    return 'Unknown Device';
  }

    final String deviceName = await getDeviceName();

    // const String apiUrl = 'http://172.16.40.170:8000/api/login';

    try {
      final response = await http.post(
    // Uri.parse('https://e236-156-0-233-57.ngrok-free.app/api/login'),
    Uri.parse( 'http://127.0.0.1:8000/api/login'),
    
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode({
      'email': emailController.text,
      'password': passwordController.text,
      //  'device_name': deviceName,
    }),
  );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final token = responseData['token'];

        // Save token to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print('Token saved: ${prefs.getString('token')}');

        // Navigate to HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        final responseData = jsonDecode(response.body);
        setState(() {
          // Handle error messages below respective inputs
          if (responseData.containsKey('email')) {
            emailError = responseData['email'][0];
          }
          if (responseData.containsKey('password')) {
            passwordError = responseData['password'][0];
          }
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        emailError = 'An error occurred: $error';
        passwordError = 'An error occurred: $error';
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
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'If you already have an account, please enter your login information.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Email TextField
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email),
                  errorText: emailError.isNotEmpty ? emailError : null,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // Password TextField
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  errorText: passwordError.isNotEmpty ? passwordError : null,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  backgroundColor: const Color.fromARGB(255, 207, 26, 26),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              // Social Media Login Options
              const Text('Or continue with', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              // Google Login Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Google login logic here
                    },
                    icon: const Icon(Icons.g_mobiledata, color: Color.fromARGB(255, 4, 154, 92)),
                    label: const Text('Google', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      backgroundColor: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Facebook Login Button
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Facebook login logic here
                },
                icon: const Icon(Icons.facebook, color: Color.fromARGB(255, 5, 38, 183)),
                label: const Text(' Facebook', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  backgroundColor: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              // Reset Password Link
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PasswordResetPage()),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
              // Navigate to Register Page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      'Sign up',
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
