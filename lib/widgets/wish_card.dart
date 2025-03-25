import 'package:flutter/material.dart';

class WishCard extends StatelessWidget {
  final String title;
  final String date;
  final String wishesCount;

  const WishCard({
    super.key,
    required this.title,
    required this.date,
    required this.wishesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(
          wishesCount,
          style: const TextStyle(color: Colors.blueGrey, fontSize: 13),
        ),
        trailing: Text(date, style: const TextStyle(color: Colors.blueGrey, fontSize: 14)),
      ),
    );
  }
}
