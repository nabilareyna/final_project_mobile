import 'dart:convert';
import 'package:cf_ta/models/artist_model.dart';
import 'package:cf_ta/services/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ArtistController extends GetxController {
  var artists = <ArtistModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchArtists(List<String> ids) async {
    isLoading.value = true;
    artists.clear();

    for (String id in ids) {
      final url = Uri.parse("${Api.baseUrl}/artists/$id.json");
      final res = await http.get(url);

      if (res.statusCode == 200 && res.body != "null") {
        final data = jsonDecode(res.body);
        artists.add(ArtistModel.fromJson({"id": id, ...data}));
      }
    }

    isLoading.value = false;
  }
}
