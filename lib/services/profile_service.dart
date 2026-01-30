import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishlist/models/user_profile.dart';

class ProfileService {
  final _auth = FirebaseAuth.instance;
  final _firestire = FirebaseFirestore.instance;

  Future<UserProfile?> loadProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestire.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserProfile.fromMap(doc.data()!);
  }

  Future<void> saveProfile(UserProfile profile) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestire.collection('users').doc(user.uid).set(
      profile.toMap(),
      SetOptions(merge: true),
    );
  }
}