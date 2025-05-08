import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WishCard extends StatelessWidget {
  final String title;
  final String? reason;
  final String? link;
  final String? notes;
  final String? date;

  const WishCard({
    super.key,
    required this.title,
    this.reason,
    this.link,
    this.notes,
    this.date,
  });

  void _launchURL(BuildContext context) async {
    if (link != null && link!.isNotEmpty) {
      final uri = Uri.parse(link!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
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
            Text(title,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (reason != null && reason!.isNotEmpty)
              Text('🎉 Reason: $reason'),
            if (notes != null && notes!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('📝 Notes: $notes'),
              ),
            if (link != null && link!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton.icon(
                  onPressed: () => _launchURL(context),
                  icon: const Icon(Icons.link),
                  label: const Text('Open link'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                  ),
                ),
              ),
            if (date != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  date!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
