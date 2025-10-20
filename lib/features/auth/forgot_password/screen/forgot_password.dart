// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:foodly_backup/config/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.example.com/forgot-password'), // Replace with actual backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Password reset email sent. Check your inbox.')),
          );
          Navigator.pop(context);
        } // Optionally navigate back
      } else {
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.body}')),
          );
        }
      }
    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password'),),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Forgot Password?",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("Enter your email to reset your password.",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 30),
                CustomTextField(label: "Email Address", controller: emailController),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _resetPassword,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Reset Password"),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back to Sign In"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
