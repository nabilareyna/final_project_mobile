import 'dart:convert';
import 'package:cf_ta/controllers/auth_controller.dart';
import 'package:cf_ta/models/order_model.dart';
import 'package:cf_ta/services/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;
  var isLoading = false.obs;

  Future<bool> createOrder({required String eventId, required int qty, required int price}) async {
    try {
      final url = Uri.parse("${Api.baseUrl}/orders.json");
      final total = qty * price;

      final data = {
        "eventId": eventId,
        "qty": qty,
        "price": price,
        "totalPrice": total,
        "status": "pending",
        "userId": Get.find<AuthController>().currentUser!.uid,
        "createdAt": DateTime.now().toIso8601String(),
      };

      final res = await http.post(url, body: jsonEncode(data));

      return res.statusCode == 200; // ⬅️ TRUE kalau sukses
    } catch (e) {
      return false;
    }
  }

  Future<void> loadUserOrders(String uid) async {
    isLoading.value = true;

    final url = Uri.parse("${Api.baseUrl}/orders.json");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final body = res.body.trim();

      if (body == "null" || body.isEmpty) {
        orders.value = [];
      } else {
        final raw = jsonDecode(body) as Map<dynamic, dynamic>;
        orders.value = raw.entries.map((e) => OrderModel.fromJson(e.key, e.value)).where((o) => o.userId == uid).toList().reversed.toList();
      }
    }

    isLoading.value = false;
  }
}
