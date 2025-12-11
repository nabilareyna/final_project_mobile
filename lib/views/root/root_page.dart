import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cf_ta/theme/app_colors.dart';
import 'package:cf_ta/views/order/ticket_page.dart';
import 'package:cf_ta/views/profile_page/profile_page.dart';
import 'package:cf_ta/views/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../home/home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;

  final pages = [
    HomePage(),
    SearchPage(),
    TicketPage(), // ticket/favorite (nanti)
    ProfilePage(),
  ];

  final iconList = <IconData>[Iconsax.home, Iconsax.search_favorite, Iconsax.ticket, Iconsax.user];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        icons: iconList,
        backgroundColor: AppColors.surfaceSoft,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.textSecondary,
        gapLocation: GapLocation.none,
        iconSize: 26,
        splashColor: AppColors.primary.withOpacity(0.2),
      ),
    );
  }
}
