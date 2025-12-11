import 'package:cf_ta/theme/app_colors.dart';
import 'package:cf_ta/views/favourite_page/favourite_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  final authC = Get.find<AuthController>();
  String getInitial(String email) {
    if (email.isEmpty) return "U";
    return email[0].toUpperCase();
  }

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          final user = authC.currentUser;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Row(
                  children: [
                    // PROFILE AVATAR
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Color(0xFFDAA6FF), Color(0xFF7BC7FF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      ),
                      child: Center(
                        child: Text(getInitial(user?.email ?? ""), style: GoogleFonts.poppins(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.email ?? "email@example.com",
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1, // opsional biar clean
                          ),

                          Text("User Profile", style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // MENUS
                _ProfileMenu(icon: Icons.bookmark_border, title: "Saved Events", onTap: () => Get.to(() => FavouritePage())),
                _ProfileMenu(icon: Icons.notifications_none, title: "Notifications"),
                _ProfileMenu(icon: Icons.share_outlined, title: "Share Profile"),
                _ProfileMenu(icon: Icons.settings_outlined, title: "Settings"),

                const Spacer(),

                // LOGOUT
                GestureDetector(
                  onTap: () async {
                    await authC.logout();
                    Get.offAllNamed('/');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(color: Colors.red.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Colors.redAccent),
                        const SizedBox(width: 8),
                        Text("Logout", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _ProfileMenu({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: Colors.white70),
            ),

            const SizedBox(width: 14),

            Text(title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 15)),

            const Spacer(),

            Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}
