import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreChip extends StatelessWidget {
  final String label;
  final Color color;
  const GenreChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(
        label, style: GoogleFonts.poppins(color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
