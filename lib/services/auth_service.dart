// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a user object based on FirebaseUser
  User? _userFromFirebaseUser(User? user) {
    return user;
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = _userFromFirebaseUser(result.user);
      return user;
    } catch (error) {
      print("Error signing in: $error");
      return null;
    }
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = _userFromFirebaseUser(result.user);
      return user;
    } catch (error) {
      print("Error registering: $error");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print("Error signing out: $error");
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _userFromFirebaseUser(_auth.currentUser);
  }
}
