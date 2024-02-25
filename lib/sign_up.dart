import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chota_youtube/helper_functions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false; // Flag to track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Check if the entered email is valid
                  if (!isValidEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isLoading ? null : _signUp,
                child: isLoading
                    ? CircularProgressIndicator() // Show progress indicator when loading
                    : const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Regular expression for email format
    return emailRegex.hasMatch(email);
  }

  // Function to handle sign-up process
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading =
            true; // Set loading state to true when sign-up process begins
      });
      try {
        // Sign up with email and password
        final user = await Supabase.instance.client.auth.signUp(
          email: emailController.text,
          password: passwordController.text,
        );

        if (user != null) {
          emailController.clear();
          passwordController.clear();
          HelperFunctions.setIsLoggedIn(true);
          Navigator.pushNamed(context, '/home');
          print('User signed up: ${emailController.text}');
        } else {
          print('Failed to sign up.');
        }
      } catch (error) {
        print('Error during sign-up: $error');
      } finally {
        setState(() {
          isLoading =
              false; // Set loading state to false after sign-up process completes
        });
      }
    }
  }
}
