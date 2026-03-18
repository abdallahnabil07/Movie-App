import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/core/enum/auth_error.dart';

abstract class ProfileFirebaseService {
  static Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatarPath,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw CustomError("User not logged in");
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'name': name,
            'phone': phone,
            'avatar': avatarPath,
            'updatedAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  static Future<void> deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw CustomError("User not logged in");
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();

      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw CustomError(e.message ?? "Delete failed");
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  static Future<Map<String, dynamic>> getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw CustomError("User not logged in");
      }

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        throw CustomError("User data not found");
      }

      final data = doc.data()!;
      return {
        'name': data['name'] ?? '',
        'phone': data['phone'] ?? '',
        'avatar': data['avatar'] ?? '',
      };
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  static Future<void> createUserIfNotExists(User user) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set({
        'name': user.displayName ?? '',
        'phone': user.phoneNumber ?? '',
        'avatar': user.photoURL ?? '',
        'email': user.email ?? '',
        'id': user.uid,
      });
    }
  }

  static Future<List<Map<String, dynamic>>> getWatchList() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw CustomError("User not logged in");

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) return [];

      final data = doc.data()!;
      final list = (data['watchList'] as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList() ??
          [];

      return list;
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  static Future<void> updateWatchList(List<Map<String, dynamic>> watchList) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw CustomError("User not logged in");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'watchList': watchList}, SetOptions(merge: true));
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  // ✅ جلب قائمة الهيستوري
  static Future<List<Map<String, dynamic>>> getHistory() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw CustomError("User not logged in");

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) return [];

      final data = doc.data()!;
      final list = (data['history'] as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList() ??
          [];

      return list;
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  // ✅ تحديث قائمة الهيستوري
  static Future<void> updateHistory(List<Map<String, dynamic>> historyList) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw CustomError("User not logged in");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'history': historyList}, SetOptions(merge: true));
    } catch (e) {
      throw CustomError(e.toString());
    }
  }
}
