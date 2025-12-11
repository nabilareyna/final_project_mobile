import 'package:cf_ta/controllers/auth_controller.dart';
import 'package:cf_ta/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/event_controller.dart';
import '../widgets/ticket_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TicketPage extends StatelessWidget {
  final orderC = Get.put(OrderController());
  final eventC = Get.find<EventController>();

  TicketPage({super.key}) {
    final uid = Get.find<AuthController>().currentUser?.uid ?? "";
    orderC.loadUserOrders(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HEADER
              Text("My Tickets",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ))
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: -0.2),

              const SizedBox(height: 6),

              Text("Your purchased event tickets",
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondary,
                  ))
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 80.ms)
                  .slideY(begin: -0.2),

              const SizedBox(height: 24),

              // LIST
              Expanded(
                child: Obx(() {
                  if (orderC.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (orderC.orders.isEmpty) {
                    return const Center(child: Text("No tickets yet"));
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: orderC.orders.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final order = orderC.orders[index];

                      // FIND EVENT (REST)
                      final event = eventC.allEvents.firstWhereOrNull(
                        (e) => e.id == order.eventId,
                      );

                      if (event == null) return const SizedBox.shrink();

                      return TicketCard(event: event, order: order)
                          .animate()
                          .fadeIn(
                            duration: 400.ms,
                            delay: (index * 100).ms,
                          )
                          .slideY(begin: 0.2);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

