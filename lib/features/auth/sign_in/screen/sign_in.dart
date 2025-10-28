import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/config/utils/routes.dart';
import 'package:foodly_backup/config/widgets/input_field.dart';
import 'package:foodly_backup/core/helper/helper.dart';
import 'package:foodly_backup/features/auth/sign_in/managers/sign_in_bloc.dart';
import 'package:foodly_backup/features/auth/sign_in/managers/sign_in_event.dart';
import 'package:foodly_backup/features/auth/sign_in/managers/sign_in_state.dart';
import 'package:nb_utils/nb_utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final Helper helper = Helper();
  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (BuildContext context, state) {
        if (state is SuccessState) {
          Navigator.pushReplacementNamed(context, RouteGenerator.initialRoute);
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: const Color(0xFFFAF6F3),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),

                  Image.asset('assets/logo/png/Logo.png', height: 80),
                  const SizedBox(height: 30),

                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Sign in to Your Account',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  35.height,

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField(
                          controller: _emailController,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          label: 'Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            } else if (!helper.validateEmail(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        15.height,
                        InputField(
                          controller: _passwordController,
                          obscureText: !isPasswordVisible,
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          label: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFFEB7A50),
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            } else if (!helper.validatePassword(value)) {
                              return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  12.height,

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        RouteGenerator.forgotPassword,
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  15.height,

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignInBloc>().add(
                            OnSignIn(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            ),
                          );
                          _emailController.clear();
                          _passwordController.clear();
                          setState(() {
                            isLoading = !isLoading;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white,)
                          : const Text(
                              'Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  25.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have your account? "),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, RouteGenerator.signUp),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFFEB7A50),
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
        ),
      ),
    );
  }
}
