import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/components/toastification_custom.dart';
import 'package:movie_app/core/enum/auth_error.dart';
import 'package:toastification/toastification.dart';

import '../../layout/profile/utils/profile_firebase_service.dart';

abstract class AuthFirebaseService {
  static Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') throw InvalidCredential();
      if (e.code == 'wrong-password') throw WrongPassword();
      if (e.code == 'too-many-requests') throw TooManyRequest();
      throw Unknown();
    } catch (error) {
      throw CustomError(error.toString());
    }
  }

  static Future<User?> signInWithGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    try {
      final googleUser = await googleSignIn.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        await ProfileFirebaseService.createUserIfNotExists(user);
      }

      return user;

    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      throw CustomError(
        'Google Sign-In failed: ${error.description ?? error.toString()}',
      );
    } on FirebaseAuthException catch (e) {
      throw CustomError('Firebase error: ${e.message}');
    } catch (error) {
      throw CustomError(error.toString());
    }
  }

  static Future<bool> signUpWithPass(
    BuildContext context,
    String name,
    String emailAddress,
    String password,
    String phone,
    String avatarPath,
  ) async {
    try {
      final FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

      final UserCredential credential = await firebaseAuthInstance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      final String? uid = credential.user?.uid;

      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': name,
          'email': emailAddress,
          'phone': phone,
          'avatar': avatarPath,
          'createdAt': FieldValue.serverTimestamp(),
        });
        ToastificationCustom.show(
          context,
          type: ToastificationType.success,
          title: "User created successfully",
        );
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
        ToastificationCustom.show(
          context,
          type: ToastificationType.error,
          title: message,
        );
        return false;
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
        ToastificationCustom.show(
          context,
          type: ToastificationType.error,
          title: message,
        );
        return false;
      } else {
        message = e.message ?? "Authentication error occurred.";
        ToastificationCustom.show(
          context,
          type: ToastificationType.error,
          title: message,
        );
        return false;
      }
    } catch (e) {
      ToastificationCustom.show(
        context,
        type: ToastificationType.error,
        title: e.toString(),
      );
      return false;
    }
  }
}
