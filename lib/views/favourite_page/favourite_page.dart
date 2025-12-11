import 'package:cf_ta/controllers/event_controller.dart';
import 'package:cf_ta/controllers/favourite_controller.dart';
import 'package:cf_ta/views/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritePage extends StatelessWidget {
  final favC = Get.find<FavoriteController>();
  final eventC = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Events")),
      body: Obx(() {
        if (favC.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final favorites = eventC.allEvents
            .where((e) => favC.favoriteIds.contains(e.id))
            .toList();

        if (favorites.isEmpty) {
          return const Center(child: Text("No saved events"));
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: favorites.map((event) {
            return EventCard(event: event);
          }).toList(),
        );
      }),
    );
  }
}
