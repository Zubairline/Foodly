import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/config/utils/colors.dart';
import 'package:foodly_backup/config/widgets/input_field.dart';
import 'package:foodly_backup/core/helper/helper.dart';
import 'package:foodly_backup/features/auth/forgot_password/managers/forgot_password_bloc.dart';
import 'package:foodly_backup/features/auth/forgot_password/managers/forgot_password_state.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text('Forgot Password')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter your email to reset your password.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  Form(
                    key: formKey,
                    child: InputField(
                      label: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      controller: emailController,
                      filled: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!Helper().validateEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navigationButton,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 2), () {});
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Reset Password",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Back to Sign In",
                        style: TextStyle(color: navigationButton),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      listener: (BuildContext context, state) {
        if (state is SuccessState) {
         toast(state.message);
        }
        if (state is ErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is LoadingState) {
          const CircularProgressIndicator();
        }
      },
    );
  }
}
