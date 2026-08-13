import 'package:material_ui/material_ui.dart';

class GiftIconHelper {
  static IconData getReasonIcon(String reason) {
    switch (reason.toLowerCase().trim()) {
      case 'birthday':
        return Icons.cake_rounded;
      case 'new year':
        return Icons.celebration_rounded;
      case 'women`s day':
      case "women's day":
        return Icons.local_florist_rounded;
      case 'christmas':
        return Icons.forest_rounded;
      case 'wedding':
        return Icons.diamond_rounded;
      case 'valentine`s day':
      case "valentine's day":
        return Icons.favorite_rounded;
      case 'just because':
        return Icons.emoji_emotions_rounded;
      case 'other occasion':
      default:
        return Icons.star_rounded;
    }
  }
}