import 'package:expense_tracker/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  Future<bool> signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (context.mounted) {
        // Create the user first
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);

        final userId = userCredential.user!.uid;

        // Store user details in Firestore
        await users.doc(userId).set({
          'uid': userId,
          'username': name,
          'email': email,
        });
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        if (e.code == 'weak-password') {
          warningSnackBar('Password should be at least 6 characters', context);
        } else if (e.code == 'email-already-in-use') {
          warningSnackBar(
            'The account already exists for that email.',
            context,
          );
        }
      }
      return false;
    } catch (e) {
      if (context.mounted) failedSnackBar(e.toString(), context);
      return false;
    }
  }

  Future<bool> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      if (context.mounted) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) failedSnackBar(e.toString(), context);
      return false;
    } catch (e) {
      if (context.mounted) failedSnackBar(e.toString(), context);
      return false;
    }
  }
}
