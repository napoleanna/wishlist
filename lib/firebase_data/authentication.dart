import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  Future<User?> createUserWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
          email: email, 
          password: password);
      return userCredential.user;
    } catch (e) {
      print('Error creating user: $e');
      return null;
    }
  }

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(
          email: email,
          password: password);
      return userCredential.user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}