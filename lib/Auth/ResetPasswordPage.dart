import 'package:flutter/material.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Reset Password'),
      //   backgroundColor: Colors.deepPurple,
      // ),
      
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
                'Reset Password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
             
              const SizedBox(height: 20),

              const Text(
                'Enter your email address to receive a password reset link.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 20),

              // Reset Password Button
              ElevatedButton(
                onPressed: () {
                  // Handle reset password logic here
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Send Reset Link', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
