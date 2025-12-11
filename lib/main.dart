import 'package:cf_ta/controllers/auth_controller.dart';
import 'package:cf_ta/controllers/event_controller.dart';
import 'package:cf_ta/controllers/favourite_controller.dart';
import 'package:cf_ta/theme/app_theme.dart';
import 'package:cf_ta/views/auth/login_page.dart';
import 'package:cf_ta/views/root/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "AIzaSyDZym0AEBxGUSaC75Rs2dizYkv8Tl7U0gk",
    appId: "1:348250104822:android:35b37a52c5d456d77eddd7",
    messagingSenderId: "348250104822",
    projectId: "concertflow-ta",
    databaseURL: "https://concertflow-ta-default-rtdb.asia-southeast1.firebasedatabase.app",
  ),
);


  Get.put(AuthController(), permanent: true);
  Get.put(EventController(), permanent: true); // ⬅️ PENTING
  Get.put(FavoriteController(), permanent: true);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, theme: AppTheme.darkTheme, home: AuthGate());
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // masih cek status login
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // user belum login
        if (!snapshot.hasData) {
          return LoginPage();
        }

        // user login → tunggu Firestore userModel
        return Obx(() {
          if (!authC.userReady.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // userModel udah ke-load dan siap
          return const RootPage();
        });
      },
    );
  }
}


