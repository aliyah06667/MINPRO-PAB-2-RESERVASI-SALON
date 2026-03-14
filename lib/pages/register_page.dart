import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool obscurePassword = true;
  bool isDarkMode = false;

  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  Future register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Cek kosong
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email and password cannot be empty"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validasi password minimal 8 karakter
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 8 characters"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      setState(() => loading = true);

      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account successfully created"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        // fallback jika user null
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to create account"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fieldColor = isDarkMode ? Colors.grey[850] : const Color(0xFFF2F2F2);

    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  isDarkMode
                      ? "assets/image/login_bg_dark.png"
                      : "assets/image/login_bg.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// FADE BACKGROUND
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(isDarkMode ? 0.7 : 0.4),
                  Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),

          /// NAVBAR
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: isDarkMode
                    ? const LinearGradient(
                        colors: [
                          Colors.black,
                          Color.fromARGB(255, 54, 52, 52),
                          Colors.black,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const LinearGradient(
                        colors: [
                          Color(0xFFFFA4CD),
                          Color(0xFFFFCCE0),
                          Color(0xFFFFE3F5),
                          Color(0xFFFFCCE0),
                          Color(0xFFFFA4CD),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
              ),
            ),
          ),

          /// DARK MODE BUTTON
          Positioned(
            right: 20,
            top: 15,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFFF48FB1) : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),

          /// REGISTER CARD
          Center(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: 340,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color.fromARGB(
                                255,
                                89,
                                89,
                                89,
                              ).withOpacity(0.65)
                            : Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 25,
                            spreadRadius: 1,
                            color: const Color(0xFFF48FB1).withOpacity(0.4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.spa,
                            size: 60,
                            color: Color(0xFFD81B60),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "CREATE ACCOUNT",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? const Color(0xFFFFC1E3)
                                  : const Color(0xFFD81B60),
                            ),
                          ),
                          const SizedBox(height: 25),

                          /// EMAIL
                          TextField(
                            controller: emailController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: textColor.withOpacity(.7),
                              ),
                              prefixIcon: const Icon(Icons.mail_outline),
                              filled: true,
                              fillColor: fieldColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD81B60),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          /// PASSWORD
                          TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: textColor.withOpacity(.7),
                              ),
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: fieldColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD81B60),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          /// REGISTER BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: loading ? null : register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF48FB1),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "REGISTER",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(color: textColor),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Color(0xFFD81B60),
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
            ),
          ),
        ],
      ),
    );
  }
}
