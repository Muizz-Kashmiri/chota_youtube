import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chota_youtube/helper_functions.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  print('Button pressed');
                  // Show circular progress indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );

                  // Sign in with email and password
                  final user = await supabase.auth.signInWithPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // Close the dialog
                  Navigator.pop(context);

                  // Handle user login here
                  if (user != null) {
                    HelperFunctions.setIsLoggedIn(true);
                    Navigator.pushNamed(context, '/home');
                    emailController.clear();
                    passwordController.clear();
                    print('User signed in: ${emailController.text}');
                  } else {
                    // Handle sign-in failure
                    print('Failed to sign in.');
                  }
                } catch (e) {
                  print('Error during sign-in: $e');
                  // Close the dialog
                  Navigator.pop(context);

                  // Show error message on screen
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Sign In Error'),
                        content: const Text(
                            'Invalid email or password. Please try again.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Not signed in, sign up now'),
            ),
          ],
        ),
      ),
    );
  }
}
