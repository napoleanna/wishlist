import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishlist/models/wish_list.dart';
import '../models/wish.dart';

class FirestoreService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<void> saveWish(Wish wish) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    print("Saving wish for user: $userId");

    final docRef = _database
        .collection('users')
        .doc(userId)
        .collection('wishes')
        .doc();
    final wishWithId = wish.copyWith(id: docRef.id);
    await docRef.set(wishWithId.toMap());
  }


  Stream<List<Wish>> getWishesByUser(String userId) {
    return _database
        .collection('users')
        .doc(userId)
        .collection('wishes')
        .snapshots()
        .map((snapshot) => snapshot.docs
          .map((doc) => Wish.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList())
        .asBroadcastStream();
  }

  Stream<List<Wish>> getWishesByListId(String userId, String listId) {
    return _database
        .collection('users')
        .doc(userId)
        .collection('wishes')
        .where('listId', isEqualTo: listId)
        .snapshots()
        .map((snapshot) => snapshot.docs
          .map((doc) => Wish.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList());
  }

  Future<void> deleteWish(String userId, String wishId) async {
    try {
      await _database
          .collection('users')
          .doc(userId)
          .collection('wishes')
          .doc(wishId)
          .delete();
      print('Wish deleted: $wishId');
    } catch (e) {
      print('Error deleting wish: $e');
    }
  }

  Future<void> updateWish(String userId, String wishId, Wish updatedWish) async {
    try {
      await _database
          .collection('users')
          .doc(userId)
          .collection('wishes')
          .doc(wishId)
          .update(updatedWish.toMap());
      print('Wish updated: $wishId');
    } catch (e) {
      print('Error updating wish: $e');
    }
  }



  Future<String> addWishlist(Wishlist wishlist) async {
    final docRef = _database
        .collection('users')
        .doc(wishlist.userId)
        .collection('wish_lists')
        .doc();
    final wishlistWithId = wishlist.copyWith(id: docRef.id);
    await docRef.set(wishlistWithId.toMap());
    return docRef.id;
  }

  Stream<List<Wishlist>> getWishlistsByUser(String userId) {
    return _database
        .collection('users')
        .doc(userId)
        .collection('wish_lists')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((d) =>
            Wishlist.fromMap(d.id, d.data() as Map<String, dynamic>))
            .toList())
        .asBroadcastStream();
  }


  Future<void> deleteWishlist(String userId, String wishlistId) async {
    try {
      await _database
          .collection('users')
          .doc(userId)
          .collection('wish_lists')
          .doc(wishlistId)
          .delete();
      print('Wishlist deleted: $wishlistId');
    } catch (e) {
      print('Error deleting wishlist: $e');
    }
  }

  Future<void> updateWishlist(String userId, String wishlistId, Wishlist update)
  async {
    try {
      await _database
          .collection('users')
          .doc(userId)
          .collection('wish_lists')
          .doc(wishlistId).update(update.toMap());
      print('Wishlist updated: $wishlistId');
    } catch (e) {
      print('Error updating wishlist: $e');
    }
  }

}
