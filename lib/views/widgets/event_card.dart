import 'package:cf_ta/controllers/favourite_controller.dart';
import 'package:cf_ta/models/event_model.dart';
import 'package:cf_ta/services/currency_format.dart';
import 'package:cf_ta/theme/app_colors.dart';
import 'package:cf_ta/views/widgets/genre_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onTap;
  final favC = Get.find<FavoriteController>();

  EventCard({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Hero(
                tag: 'event-${event.id}',
                child: Image.network(
                  event.banner,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) =>
                          Container(height: 180, color: AppColors.surfaceSoft, child: const Icon(Icons.image_not_supported, color: AppColors.textSecondary)),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE + FAVORITE
                  Row(
                    children: [
                      Expanded(child: Text(event.title, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800))),
                      Obx(() {
                        final isFav = favC.isFavorite(event.id);
                        return IconButton(
                          splashRadius: 20,
                          icon: Icon(isFav ? Icons.bookmark : Icons.bookmark_add_outlined, color: isFav ? AppColors.paid : AppColors.textSecondary),
                          onPressed: () {
                            favC.toggleFavorite(event.id);
                          },
                        );
                      }),
                    ],
                  ),

                  // LOCATION & DATE
                  Row(
                    children: [
                      const Icon(Iconsax.location, size: 14, color: Color(0xFFF19EBE)),
                      const SizedBox(width: 4),
                      Text(event.location, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
                      const SizedBox(width: 8),
                      const Icon(Icons.calendar_today, size: 14, color: Color(0xFF86F3F1)),
                      const SizedBox(width: 4),
                      Text(event.date, style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),

                  SizedBox(height: 8),

                  Divider(
                    color: AppColors.textSecondary,
                    height: 20,
                    thickness: 0.5,
                    
                  ),

                  SizedBox(height: 12),

                  // TAGS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GenreChip(label: event.genre, color: AppColors.primary,), _TagChip(label: CurrencyFormat.rupiah(event.price)),
                    ],
                  ),

                  SizedBox(height: 8,)
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
    );
  }
}
