import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120),

            Text(
              "Welcome Back 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: emailC,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                try {
                  await authC.login(emailC.text, passC.text);
                } catch (e) {
                  Get.snackbar("Login Error", e.toString());
                }
              },
              child: const Text("Login"),
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () => Get.to(RegisterPage()),
                child: const Text(
                  "Belum punya akun? Register",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
