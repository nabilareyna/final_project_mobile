import 'package:cf_ta/models/artist_model.dart';
import 'package:cf_ta/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistDetailPage extends StatelessWidget {
  final ArtistModel artist;
  const ArtistDetailPage({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F16),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          artist.name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // ================= ARTIST IMAGE / AVATAR =================
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: artist.image != null && artist.image!.isNotEmpty
                  ? Image.network(
                      artist.image!,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return _fallbackAvatar();
                      },
                    )
                  : _fallbackAvatar(),
            ),

            const SizedBox(height: 20),

            // ================= NAME =================
            Text(
              artist.name,
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            // ================= GENRE TAG =================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                artist.genre,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ================= ABOUT ARTIST =================
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About Artist",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "This artist performs ${artist.genre} music and has contributed to various gigs and live shows.",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ================= FALLBACK AVATAR =================
  Widget _fallbackAvatar() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFDAA6FF), Color(0xFF7BC7FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          artist.name.isNotEmpty ? artist.name[0].toUpperCase() : "?",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
