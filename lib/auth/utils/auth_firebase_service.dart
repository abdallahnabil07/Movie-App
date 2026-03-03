import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService {
  static Future<void> signUpWithPass(
    BuildContext context,
    String name,
    String emailAddress,
    String password,
    String phone,
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
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User created successfully")),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = e.message ?? "Authentication error occurred.";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
