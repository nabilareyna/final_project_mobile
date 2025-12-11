import 'package:cf_ta/models/event_model.dart';
import 'package:cf_ta/models/order_model.dart';
import 'package:cf_ta/services/currency_format.dart';
import 'package:cf_ta/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class TicketCard extends StatelessWidget {
  final EventModel event;
  final OrderModel order;

  const TicketCard({super.key, required this.event, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2835), // card background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF38354a), // border color
          width: 1,
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          // TOP SECTION - Order Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3d3a48).withOpacity(0.5), // muted background
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text(order.id.substring(0, 6), style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFFF2F2F2))),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: _getPaymentStatusColor(order.status).withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getPaymentStatusIcon(order.status),
                      const SizedBox(width: 6),
                      Text(
                        _getPaymentStatusLabel(order.status),
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: _getPaymentStatusColor(order.status)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // MIDDLE SECTION - Event Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFFF2F2F2)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Iconsax.location, size: 14, color: const Color(0xFFF19EBE)),
                    const SizedBox(width: 4),
                    Text(event.location, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
                    const SizedBox(width: 12),
                    Icon(Icons.calendar_today, size: 14, color: const Color(0xFF86F3F1)),
                    const SizedBox(width: 4),
                    Text(event.date, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time, size: 14, color: const Color(0xFF86F3F1)),
                    const SizedBox(width: 4),
                    Text(event.time, style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tickets', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(order.qty.toString(), style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFFF2F2F2))),
                            SizedBox(width: 8,),
                            Text("Tickets", style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Total Price', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        Text(
                          CurrencyFormat.rupiah(order.totalPrice),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFf0a3d9), // pastel pink
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // DASHED DIVIDER
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF38354a),
              border: Border(top: BorderSide(color: const Color(0xFF38354a), width: 1, style: BorderStyle.solid)),
            ),
          ),

          // BOTTOM SECTION - Order Status and Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(color: _getOrderStatusColor(order.status).withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          _getOrderStatusLabel(order.status),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: _getOrderStatusColor(order.status)),
                        ),
                      ),
                    ),
                    if (order.status == 'paid') const SizedBox(width: 12),
                    if (order.status == 'paid')
                      ElevatedButton.icon(
                        onPressed: () {
                          // Download ticket action
                        },
                        icon: const Icon(Icons.download, size: 16, color: AppColors.surface,),
                        label: Text('Download', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.surface)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFc89fff), // pastel purple
                          foregroundColor: const Color(0xFF1c1f2e),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPaymentStatusColor(String status) {
    switch (status) {
      case 'paid':
        return const Color(0xFFd4e8a5); // pastel yellow
      case 'pending':
        return const Color(0xFFf0a3d9); // pastel pink
      case 'cancelled':
        return const Color(0xFFff6b6b); // soft red
      default:
        return const Color(0xFF3d3a48);
    }
  }

  String _getPaymentStatusLabel(String status) {
    switch (status) {
      case 'paid':
        return 'Paid';
      case 'pending':
        return 'Pending';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  Widget _getPaymentStatusIcon(String status) {
    IconData icon;
    Color color = _getPaymentStatusColor(status);

    switch (status) {
      case 'paid':
        icon = Icons.check_circle;
        break;
      case 'pending':
        icon = Icons.schedule;
        break;
      case 'cancelled':
        icon = Icons.cancel;
        break;
      default:
        icon = Icons.help;
    }

    return Icon(icon, size: 16, color: color);
  }

  Color _getOrderStatusColor(String status) {
    switch (status) {
      case 'paid':
        return const Color(0xFF7dd3c0); // pastel cyan (adjusted)
      case 'pending':
        return const Color(0xFFf0a3d9); // pastel pink
      case 'cancelled':
        return const Color(0xFFff6b6b); // soft red
      default:
        return const Color(0xFF3d3a48);
    }
  }

  String _getOrderStatusLabel(String status) {
    switch (status) {
      case 'paid':
        return '✓ Confirmed';
      case 'pending':
        return '⏳ Pending';
      case 'cancelled':
        return '✕ Cancelled';
      default:
        return 'Unknown';
    }
  }
}
