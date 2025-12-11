import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import '../services/api.dart';

class EventController extends GetxController {
  var events = <EventModel>[].obs;
  var allEvents = <EventModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading.value = true;

    try {
      final url = Uri.parse("${Api.baseUrl}/events.json");
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final raw = jsonDecode(res.body);

        final list =
            (raw as Map<String, dynamic>).entries.map((e) {
              final map = Map<String, dynamic>.from(e.value);
              map["id"] = e.key;

              return EventModel.fromJson(map);
            }).toList();

        allEvents.value = list;
        events.value = list;
        print("FETCHED EVENTS = ${list.length}");
        print(list.map((e) => e.title).toList());
      } else {
        Get.snackbar("Error", "Failed to load events (REST error)");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load events: $e");
    }

    isLoading.value = false;
  }

  void searchEvent(String query) {
    if (query.isEmpty) {
      events.value = allEvents;
      return;
    }

    final q = query.toLowerCase();

    events.value =
        allEvents.where((event) {
          return event.title.toLowerCase().contains(q) || event.location.toLowerCase().contains(q) || event.genre.toLowerCase().contains(q);
        }).toList();
  }
}
