import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/config/utils/routes.dart';
import 'package:foodly_backup/config/widgets/input_field.dart';
import 'package:foodly_backup/core/helper/helper.dart';
import 'package:foodly_backup/features/auth/sign_up/managers/sign_up_bloc.dart';
import 'package:foodly_backup/features/auth/sign_up/managers/sign_up_event.dart';
import 'package:foodly_backup/features/auth/sign_up/managers/sign_up_state.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SuccessState) {
          _nameController.clear();
          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();
          Navigator.pushReplacementNamed(context, RouteGenerator.signIn);
        } else if (state is ErrorState) {
          toast(state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
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
                    80.height,

                    // 🍃 Logo
                    Image.asset('assets/logo/png/Logo.png', height: 80),
                    30.height,

                    // ✨ Title
                    const Text(
                      'Join Foodly!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    8.height,

                    // Subtitle
                    const Text(
                      'Create Your Account',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    35.height,

                    // 👤 Full Name
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Full Name',
                          ),

                          const SizedBox(height: 15),

                          // 📧 Email Address
                          InputField(
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              } else if (!Helper().validateEmail(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          15.height,
                          InputField(
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.visiblePassword,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Password',
                            obscureText: !isPasswordVisible,
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
                              } else if (!Helper().validatePassword(value)) {
                                return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                              }
                              return null;
                            },
                          ),
                          15.height,

                          // 🔒 Confirm Password
                          InputField(
                            controller: _confirmPasswordController,
                            textInputType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Confirm Password',
                            obscureText: !isPasswordVisible,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFFEB7A50),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              } else if (!Helper().validatePassword(value)) {
                                return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 🔘 Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            // Split user's name into first, middle, and last names
                            List<String> name = _nameController.text
                                .trim()
                                .split(' ');
                            debugPrint(name.first);
                            debugPrint(name[1]);
                            debugPrint(name.last);

                            // Save user data to SharedPreferences
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString('first_name', name.first);
                            prefs.setString('middle_name', name[1]);
                            prefs.setString('last_name', name.last);

                            if(context.mounted){
                              context.read<SignUpBloc>().add(
                                OnSignUp(
                                  _emailController.text,
                                  _passwordController.text,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 🔁 Sign In Redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteGenerator.signIn,
                            );
                          },
                          child: const Text(
                            'Sign In',
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
        );
      },
    );
  }
}
