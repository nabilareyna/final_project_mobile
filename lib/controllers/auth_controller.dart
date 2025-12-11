import 'package:cf_ta/controllers/favourite_controller.dart';
import 'package:cf_ta/models/user_model.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _rtdb = FirebaseDatabase.instance.ref();

  RxBool userReady = false.obs;
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  UserModel? get currentUser => userModel.value;
  bool get isLoggedIn => _auth.currentUser != null;

  @override
  void onInit() {
    super.onInit();

    // listen to auth state
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _loadUserModel();
      } else {
        userModel.value = null;
        userReady.value = true;
      }
    });
  }

  Future<void> _loadUserModel() async {
    userReady.value = false;

    final user = _auth.currentUser;

    if (user == null) {
      userModel.value = null;
      userReady.value = true;
      return;
    }

    final snap = await _rtdb.child("users/${user.uid}").get();
    print("RTDB USER SNAP: ${snap.value}");

    if (snap.exists && snap.value != null) {
      final data = Map<String, dynamic>.from((snap.value as Map<Object?, Object?>).map((key, value) => MapEntry(key.toString(), value)));

      userModel.value = UserModel.fromJson(user.uid, data);
    } else {
      // fallback
      final newUser = UserModel(uid: user.uid, email: user.email ?? '', name: '', favorites: []);

      await _rtdb.child("users/${user.uid}").set(newUser.toJson());
      userModel.value = newUser;
    }

    userReady.value = true;
  }

  // REGISTER
  Future<void> register(String name, String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    final uid = cred.user!.uid;

    await _rtdb.child("users/$uid").set({"uid": uid, "name": name, "email": email, "favorites": []});

    _loadUserModel();
  }

  // LOGIN
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    await _loadUserModel();
    Get.put(FavoriteController(), permanent: true);
  }

  // LOGOUT
  Future<void> logout() async {
    userModel.value = null;
    Get.delete<FavoriteController>();
    await _auth.signOut();
  }
}
