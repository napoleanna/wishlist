import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../models/wish.dart';

class FriendWishCard extends StatelessWidget {
  final Wish wish;

  const FriendWishCard({
    super.key,
    required this.wish,
  });

  Future<void> _launchURL(BuildContext context) async {
    if (wish.link != null && wish.link!.isNotEmpty) {
      final uri = Uri.parse(wish.link!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to open link')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(wish.title ?? '',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (wish.reason != null && wish.reason!.isNotEmpty)
              Text('🎉 Reason: ${wish.reason}'),
            if (wish.notes != null && wish.notes!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('📝 Notes: ${wish.notes}'),
              ),
            if (wish.date != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '📅 ${DateFormat('dd.MM.yyyy').format(wish.date!)}',
                ),
              ),
            if (wish.link != null && wish.link!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton.icon(
                  onPressed: () => _launchURL(context),
                  icon: const Icon(Icons.link),
                  label: const Text('Open link'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[100],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
