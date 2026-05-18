import 'package:flutter/material.dart';
import 'package:wishlist/app/theme/colors.dart';
import '../models/wish.dart';

class WishCard extends StatelessWidget {
  final Wish wish;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const WishCard({
    super.key,
    required this.wish,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? AppColors.darkSurface : Colors.white;
    final titleColor = isDark ? AppColors.darkText : AppColors.lightDeep;
    final subtitleColor = titleColor.withValues(alpha: 0.6);


    return Dismissible(
      key: ValueKey(wish.id),
      background: _buildDismissBackground(
          Alignment.centerLeft,
          const Color(0xFFC5F4FC).withValues(alpha: 0.8),
          Icons.edit_outlined,
          isDark),
      secondaryBackground: _buildDismissBackground(
          Alignment.centerRight,
          const Color(0xFFF9959F).withValues(alpha: 0.8),
          Icons.delete_outline,
          isDark),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          onDelete();
          return true;
        } else {
          onEdit();
          return false;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        height: 120,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
            color: (isDark ? Colors.black
                : const Color(0xFF5126AA)).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              Positioned(
                left: -10,
                  bottom: -10,
                  child: Opacity(
                      opacity: isDark ? 0.4 : 0.6,
                  child: Image.asset('assets/images/present.png',
                  height: 130,
                  fit: BoxFit.contain,
                   ),
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 100, right:  20, top: 15, bottom: 15 ),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              wish.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: titleColor,
                                letterSpacing: -0.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (wish.notes != null && wish.notes!.isNotEmpty)
                              Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    wish.notes!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: subtitleColor,
                                      height: 1.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ),
                          ],
                        ),
                      ),
                    const SizedBox(width: 10),
                      if (wish.reason != null && wish.reason!.isNotEmpty)
                         _buildOccasionBadge(wish.reason!, isDark),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: onEdit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOccasionBadge(String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF5126AA).withValues(alpha: 0.3)
            : const Color(0xFFEEE5FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : const Color(0xFF5126AA),
        ),
      ),
    );
  }

  Widget _buildDismissBackground(Alignment alignment, Color color, IconData icon, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }

}