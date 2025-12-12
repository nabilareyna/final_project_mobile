import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final _db = FirebaseDatabase.instance.ref(); // root reference RTDB
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

    final userRef = _db.child('users').child(uid!).child('favorites');
    final snapshot = await userRef.get();

    if (snapshot.exists) {
      // bisa kosong, pastikan cast ke List<String>
      final List<dynamic> rawList = snapshot.value as List<dynamic>? ?? [];
      favoriteIds.value = rawList.map((e) => e.toString()).toList();
    } else {
      favoriteIds.value = [];
    }

    isLoading.value = false;
  }

  Future<void> toggleFavorite(String eventId) async {
    if (uid == null) return;

    final userRef = _db.child('users').child(uid!).child('favorites');

    // ambil list terbaru dari server untuk safety
    final snapshot = await userRef.get();
    List<dynamic> currentList = snapshot.exists
        ? List<dynamic>.from(snapshot.value as List<dynamic>)
        : [];

    if (currentList.contains(eventId)) {
      currentList.remove(eventId);
    } else {
      currentList.add(eventId);
    }

    await userRef.set(currentList); // update list di RTDB
    favoriteIds.value = currentList.map((e) => e.toString()).toList();
  }

  bool isFavorite(String id) {
    return favoriteIds.contains(id);
  }
}
