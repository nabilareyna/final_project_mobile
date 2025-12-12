import 'package:cf_ta/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'register_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                const SizedBox(height: 80),
            
                Text(
                  "Welcome Back 👋",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                const SizedBox(height: 10),
            
                Text(
                  "Sign in to continue",
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondary,
                  ),
                ),
            
                const SizedBox(height: 40),
            
                _inputField(emailC, "Email", Icons.email_outlined),
            
                const SizedBox(height: 16),
            
                _inputField(passC, "Password", Icons.lock_outline, obscure: true),
            
                const SizedBox(height: 30),
            
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      try {
                        await authC.login(emailC.text, passC.text);
                      } catch (e) {
                        Get.snackbar("Login Error", e.toString(),
                            backgroundColor: Colors.red.withOpacity(0.4));
                      }
                    },
                    child: Text("Login", style: GoogleFonts.poppins(fontSize: 16)),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                Center(
                  child: TextButton(
                    onPressed: () => Get.to(RegisterPage()),
                    child: Text(
                      "Belum punya akun? Register",
                      style: GoogleFonts.poppins(color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white38),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
