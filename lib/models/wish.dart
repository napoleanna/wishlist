import 'package:cloud_firestore/cloud_firestore.dart';

class Wish {
  final String id;
  final String userId;
  final String title;
  final String listId;
  final String? reason;
  final String? link;
  final String? notes;
  final DateTime? date;
  final bool rememberDate;

  Wish({
    required this.id,
    required this.userId,
    required this.title,
    required this.listId,
    this.reason,
    this.link,
    this.notes,
    this.date,
    this.rememberDate = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'listId': listId,
      'reason': reason,
      'link': link,
      'notes': notes,
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'rememberDate': rememberDate,
    };
  }

  factory Wish.fromMap(String id, Map<String, dynamic> map) {
    return Wish(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      listId: map['listId'] ?? '',
      reason: map['reason'],
      link: map['link'],
      notes: map['notes'],
      date: map['date'] != null ? (map['date'] as Timestamp).toDate() : null,
      rememberDate: map['rememberDate'] ?? false,
    );
  }


  Wish copyWith({
    String? id,
    String? userId,
    String? title,
    String? listId,
    String? reason,
    String? link,
    String? notes,
    DateTime? date,
    bool? rememberDate,
    bool clearDate = false,
  }) {
    return Wish(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      listId: listId ?? this.listId,
      reason: reason ?? this.reason,
      link: link ?? this.link,
      notes: notes ?? this.notes,
      date: clearDate ? null : (date ?? this.date),
      rememberDate: rememberDate ?? this.rememberDate,
    );
  }

}
