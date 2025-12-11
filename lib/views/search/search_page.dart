import 'package:cf_ta/theme/app_colors.dart';
import 'package:cf_ta/views/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/event_controller.dart';
import '../event/event_detail_page.dart';

class SearchPage extends StatelessWidget {
  final eventC = Get.find<EventController>();
  final searchC = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Text(
                "Search",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Find events by title, genre, or location",
                style: GoogleFonts.poppins(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              // SEARCH FIELD
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: searchC,
                  onChanged: eventC.searchEvent,
                  style: GoogleFonts.poppins(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: "Search events...",
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // RESULT
              Expanded(
                child: Obx(() {
                  if (eventC.events.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "No events found",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Try a different keyword",
                          style: GoogleFonts.poppins(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: eventC.events.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final event = eventC.events[index];

                      return EventCard(
                        event: event,
                        onTap: () {
                          Get.to(
                            () => EventDetailPage(event: event),
                          );
                        },
                      )
                          .animate()
                          .fadeIn(
                            delay: (index * 80).ms,
                          )
                          .slideY(begin: 0.2);
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
