import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

      developer.log('Wish saved successfully: ${docRef.id}', name: 'FirestoreService');
    } catch (e) {
      developer.log('Error saving wish: $e', name: 'FirestoreService', error: e);
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
      if (kDebugMode) print('Wish deleted: $wishId');
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting wish: $e');
      }
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
      developer.log('Wish updated successfully: $wishId', name: 'FirestoreService');

    } catch (e) {
      developer.log(
        'Error updating wish: $e',
        name: 'FirestoreService',
        error: e,
      );
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

      developer.log('Wishlist created successfully: ${docRef.id}',
          name: 'FirestoreService');

      return docRef.id;
    } catch (e) {
      developer.log(
        'Error creating wishlist: $e',
        name: 'FirestoreService',
        error: e,
      );
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
      developer.log('Wishlist deleted: $wishlistId', name: 'FirestoreService');
    } catch (e) {
      developer.log(
        'Error deleting wishlist: $e',
        name: 'FirestoreService',
        error: e,
      );
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
             developer.log('Wishlist updated: $wishlistId',
                 name: 'FirestoreService');
    } catch (e) {
           developer.log(
             'Error updating wishlist: $e',
             name: 'FirestoreService',
             error: e,
           );
      rethrow;
    }
  }


  Future<String> getOrCreateWishlistByReason(
      String userId,
      String reason,
      ) async {
        final existing = await _database
            .collection('users')
            .doc(userId)
            .collection('wish_lists')
            .where('reason', isEqualTo: reason)
            .limit(1)
            .get();

        if (existing.docs.isNotEmpty) {
          return existing.docs.first.id;
        }

        final docRef = _database
            .collection('users')
            .doc(userId)
            .collection('wish_lists')
            .doc();

        final wishlist = Wishlist(
            id: docRef.id,
            userId: userId,
            title: reason,
            reason: reason,
        );

        await docRef.set(wishlist.toMap());

        return docRef.id;
  }

  Future<String> createCustomWishlist({
    required String userId,
    required String title,
  }) async {
    final docRef = _database
        .collection('users')
        .doc(userId)
        .collection('wish_lists')
        .doc();

    final wishlist = Wishlist(
      id: docRef.id,
      userId: userId,
      title: title,
      reason: '',
    );

    await docRef.set(wishlist.toMap());
    developer.log('Custom wishlist created: ${docRef.id}',
        name: 'FirestoreService');
    return docRef.id;
  }
}
