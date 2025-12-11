import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  var favoriteIds = <String>[].obs;
  var isLoading = false.obs;

  String? get uid => _auth.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    if (uid != null) {
      loadFavorites();
    }
  }

  Future<void> loadFavorites() async {
    if (uid == null) return;
    isLoading.value = true;

    final doc = await _db.collection('users').doc(uid).get();
    favoriteIds.value = List<String>.from(doc.data()?['favorites'] ?? []);

    isLoading.value = false;
  }

  Future<void> toggleFavorite(String eventId) async {
    if (favoriteIds.contains(eventId)) {
      favoriteIds.remove(eventId);
    } else {
      favoriteIds.add(eventId);
    }

    await _db.collection('users').doc(uid).update({'favorites': favoriteIds});
  }

  bool isFavorite(String id) {
    return favoriteIds.contains(id);
  }
}
