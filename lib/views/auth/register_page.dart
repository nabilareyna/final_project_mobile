import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();

  RegisterPage({super.key});

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
              "Create Account ✨",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: nameC,
              decoration: const InputDecoration(hintText: "Nama"),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailC,
              decoration: const InputDecoration(hintText: "Email"),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                try {
                  await authC.register(
                    nameC.text,
                    emailC.text,
                    passC.text,
                  );
                  Get.back();
                } catch (e) {
                  Get.snackbar("Register Error", e.toString());
                }
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
