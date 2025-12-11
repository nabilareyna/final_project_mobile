import 'dart:ui';

import 'package:cf_ta/controllers/event_controller.dart';
import 'package:cf_ta/theme/app_colors.dart';
import 'package:cf_ta/views/event/event_detail_page.dart';
import 'package:cf_ta/views/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final eventC = Get.put(EventController());
  

  @override
  Widget build(BuildContext context) {
    print("EVENT COUNT = ${eventC.allEvents.length}");

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (eventC.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ================= GLASS HEADER =================
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: 140,
                pinned: true,
                floating: true,
                automaticallyImplyLeading: false,
                

                flexibleSpace: FlexibleSpaceBar(
                  background: ClipRRect(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
                          border: Border.all(color: Colors.white.withOpacity(0.15)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome back,", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                            const SizedBox(height: 6),
                            Text("Discover Events", style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                            const SizedBox(height: 6),
                            Text("Live music & gigs near you", style: GoogleFonts.poppins(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ================= EVENT LIST =================
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final event = eventC.allEvents[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => EventDetailPage(event: event));
                      },
                      child: EventCard(event: event),
                    ).animate().fadeIn(duration: 400.ms, delay: (index * 80).ms).slideY(begin: 0.2);
                  }, childCount: eventC.allEvents.length),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
