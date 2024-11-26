import 'package:bloombox_mobile/Auth/RegisterPage.dart';
import 'package:bloombox_mobile/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home:HomePage(),
      
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuthStatus();
  }

  Future<void> _navigateBasedOnAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Delay for splash screen effect
    await Future.delayed(const Duration(seconds: 3));

    // Navigate based on presence of token
    if (token != null && token.isNotEmpty) {
      // If token exists, navigate to HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // If no token, go to RegisterPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 5, 79),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/BLOOM.png', 
              height: 600.0,
              width: 400.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
