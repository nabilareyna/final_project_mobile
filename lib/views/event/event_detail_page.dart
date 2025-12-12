import 'dart:ui';
import 'package:cf_ta/controllers/artist_controller.dart';
import 'package:cf_ta/controllers/order_controller.dart';
import 'package:cf_ta/models/event_model.dart';
import 'package:cf_ta/services/currency_format.dart';
import 'package:cf_ta/theme/app_colors.dart';
import 'package:cf_ta/views/artist/artist_detail_page.dart';
import 'package:cf_ta/views/home/home_page.dart';
import 'package:cf_ta/views/root/root_page.dart';
import 'package:cf_ta/views/widgets/artist_card.dart';
import 'package:cf_ta/views/widgets/genre_chip.dart';
import 'package:cf_ta/views/widgets/info_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final artistC = Get.put(ArtistController());
  final orderC = Get.put(OrderController());

  int qty = 1;

  @override
  void initState() {
    super.initState();
    artistC.fetchArtists(widget.event.lineup);
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return Scaffold(
      body: Obx(() {
        if (artistC.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 330, width: double.infinity, child: buildPoster()),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE
                        Text(widget.event.title, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),

                        const SizedBox(height: 6),
                        // GENRES
                        GenreChip(label: widget.event.genre, color: AppColors.primary),
                        const SizedBox(height: 16),

                        // META
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoItem(icon: Icons.calendar_today, iconColor: Color(0xFFD680FF), label: "Date", value: widget.event.date),
                            const SizedBox(height: 20),

                            InfoItem(icon: Icons.location_on, iconColor: Color(0xFF60D5FF), label: "Location", value: widget.event.location),
                            const SizedBox(height: 20),

                            InfoItem(
                              icon: Icons.confirmation_number,
                              iconColor: Color(0xFFFFA4D0),
                              label: "Price",
                              value: CurrencyFormat.rupiah(widget.event.price),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        // DESCRIPTION
                        Text(widget.event.description, style: GoogleFonts.poppins(height: 1.6, color: AppColors.textPrimary)),

                        const SizedBox(height: 20),

                        // LINEUP
                        Row(
                          children: [
                            Icon(Icons.people_alt_outlined, color: AppColors.secondary, size: 24),
                            const SizedBox(width: 8),
                            Text("Artist Lineup", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800)),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Column(
                          children:
                              artistC.artists.map((artist) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ArtistDetailPage(artist: artist));
                                  },
                                  child: ArtistCard(name: artist.name),
                                );
                              }).toList(),
                        ),

                        const SizedBox(height: 16),

                        // QUANTITY
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Quantity", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed:
                                      qty > 1
                                          ? () {
                                            setState(() {
                                              qty--;
                                            });
                                          }
                                          : null,
                                ),
                                Text(qty.toString(), style: GoogleFonts.poppins(fontSize: 18)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      qty++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Total: ${CurrencyFormat.rupiah(widget.event.price * qty)}",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM CTA
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: ElevatedButton(
                onPressed: () async {
                  final ok = await orderC.createOrder(eventId: event.id, qty: qty, price: event.price);

                  if (ok) {
                    Get.snackbar(
                      "Success",
                      "Your ticket has been booked 🎉",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.green.shade400.withOpacity(0.2),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(16),
                      borderRadius: 12,
                    );
                    await Future.delayed(const Duration(milliseconds: 1500));
                    Get.to(RootPage());
                  } else {
                    Get.snackbar(
                      "Failed",
                      "Could not complete your order",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red.withOpacity(0.2),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(16),
                      borderRadius: 12,
                    );
                  }
                },
                child: Text("Book Ticket", style: GoogleFonts.poppins()),
              ),
            ),

            // BACK BUTTON
            Positioned(
              top: 40,
              left: 16,
              child: CircleAvatar(
                backgroundColor: AppColors.background.withOpacity(0.6),
                child: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () => Get.back()),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildPoster() {
    return Stack(
      children: [
        Positioned.fill(child: Image.network(widget.event.banner, fit: BoxFit.cover, color: Colors.black.withOpacity(0.4), colorBlendMode: BlendMode.darken)),

        Positioned.fill(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30), child: Container(color: Colors.black.withOpacity(0.2)))),
        Hero(
          tag: 'event-${widget.event.id}',
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              height: 300,
              child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(widget.event.banner, fit: BoxFit.fitHeight)),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 120,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.0)],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
