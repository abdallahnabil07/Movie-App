import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/enum/auth_error.dart';

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







}
