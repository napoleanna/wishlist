import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishlist/models/wish_list.dart';
import '../models/wish.dart';

class FirestoreService {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveWish(Wish wish) async {
    final user = _auth.currentUser;
    
    if (user == null) {
      throw StateError('User is not authenticated.');
    }
    
    if (user.uid != wish.userId) {
      throw StateError('User ID does not match the current user.');
    }

    try {
      final docRef = _database
          .collection('users')
          .doc(wish.userId)
          .collection('wishes')
          .doc();

      final wishWithId = wish.copyWith(id: docRef.id);

      await docRef.set(wishWithId.toMap());

      print('Wish saved successfully: ${docRef.id}');
    } catch (e) {
      print('Error saving wish: $e');
      rethrow;
    }

  }


  Stream<List<Wish>> getWishesByUser(String userId) {
    return _database
        .collection('users')
        .doc(userId)
        .collection('wishes')
        .snapshots()
        .map((snapshot) => snapshot.docs
          .map((doc) => Wish.fromMap(doc.id, doc.data()))
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
          .map((doc) => Wish.fromMap(doc.id, doc.data()))
          .toList())
         .asBroadcastStream();
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
      rethrow;
    }
  }

  Future<void> updateWish(
      String userId,
      String wishId,
      Wish updatedWish,
      ) async {
    try {
      await _database
          .collection('users')
          .doc(userId)
          .collection('wishes')
          .doc(wishId)
          .update(updatedWish.toMap());
      print('Wish updated successfully: $wishId');
    } catch (e) {
      print('Error updating wish: $e');
      rethrow;
    }
  }



  Future<String> addWishlist(Wishlist wishlist) async {
    try {
      final docRef = _database
          .collection('users')
          .doc(wishlist.userId)
          .collection('wish_lists')
          .doc();

      final wishlistWithId = wishlist.copyWith(id: docRef.id);

      await docRef.set(wishlistWithId.toMap());

      print('Wishlist created successfully: ${docRef.id}');

      return docRef.id;
    } catch (e) {
      print('Error creating wishlist: $e');
      rethrow;
    }
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
            Wishlist.fromMap(d.id, d.data()))
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
      rethrow;
    }
  }

  Future<void> updateWishlist(
      String userId,
      String wishlistId,
      Wishlist update,
      ) async {
         try {
             await _database
                .collection('users')
                .doc(userId)
                .collection('wish_lists')
                .doc(wishlistId)
                .update(update.toMap());
      print('Wishlist updated: $wishlistId');
    } catch (e) {
      print('Error updating wishlist: $e');
      rethrow;
    }
  }

}
