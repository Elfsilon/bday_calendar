import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() : _isLoading = false;

  UserCredential? _credential;
  UserCredential? get credential => _credential;
  set credential(UserCredential? value) {
    _credential = value;
    notifyListeners();
  }

  bool _isLoading;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? _error;
  String? get error => _error;
  set error(String? value) {
    _error = value;
    notifyListeners();
  }
}

extension AuthProviderMethods on AuthProvider {
  void login(String email, String password) async {
    try {
      isLoading = true;

      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential = userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = "No user found for that email";
      } else if (e.code == 'wrong-password') {
        error = "Wrong password provided for that user";
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  void signUp(String email, String password) async {
    try {
      isLoading = true;

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential = userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        error = "The account already exists for that email";
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  void logout() async {
    try {
      isLoading = true;
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
