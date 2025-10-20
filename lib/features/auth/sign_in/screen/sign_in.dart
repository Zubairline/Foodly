import 'package:flutter/material.dart';
import 'package:foodly_backup/core/routes.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                // 🌿 Logo
                Image.asset(
                  'assets/logo/png/Logo.png',
                  // Replace with your own logo image
                  height: 80,
                ),
                const SizedBox(height: 30),

                // 🖋 Title
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                // 🗝 Subtitle
                const Text(
                  'Sign in to Your Account',
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                const SizedBox(height: 35),

                // 📧 Email Field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: const TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // 🔒 Password Field
                TextField(
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.black45),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
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
                  ),
                ),
                const SizedBox(height: 12),

                // ❓ Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteGenerator.forgotPassword),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // 🔘 Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      RouteGenerator.initialRoute,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // 🧭 Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have your account? "),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RouteGenerator.signUp),
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
    );
  }
}
