import 'package:cloud_firestore/cloud_firestore.dart';

class Wishlist {
  final String id;
  final String userId;
  final String title;
  final String? image;
  final String reason;
  final bool enableReservations;
  final DateTime createdAt;

  Wishlist({
    required this.id,
    required this.userId,
    required this.title,
    this.image,
    this.reason = '',
    this.enableReservations = false,
    DateTime? createdAt,
}) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
   return {
     'userId' : userId,
     'title' : title,
     'image' : image,
     'reason': reason,
     'enableReservations' : enableReservations,
     'createdAt' : Timestamp.fromDate(createdAt),
   };
 }

 factory Wishlist.fromMap(String id, Map<String, dynamic> map) {
    return Wishlist(
        id: id,
        userId: map['userId'] ?? '',
        title: map['title'] ?? '',
        reason: map['reason'] ?? '',
        image: map['image'],
        enableReservations: map['enableReservations'] ?? false,
        createdAt: map['createdAt'] != null
            ? (map['createdAt'] as Timestamp).toDate()
            : DateTime.now(),
    );
 }

 Wishlist copyWith({
    String? id,
    String? userId,
    String? title,
    String? image,
    String? reason,
    bool? enableReservations,
    DateTime? createdAt,
}) {
    return Wishlist(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        reason: reason ?? this.reason,
        image: image ?? this.image,
        enableReservations: enableReservations ?? this.enableReservations,
        createdAt: createdAt ?? this.createdAt,
    );
 }

}