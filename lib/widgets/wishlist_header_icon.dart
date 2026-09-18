import 'package:material_ui/material_ui.dart';

class WishlistIcon extends StatelessWidget {
  const WishlistIcon({
    super.key,
    required this.primaryColor,
  });

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [

          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE7DEFF),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(
                    alpha: 0.18,
                  ),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.list_alt_rounded,
              size: 42,
              color: primaryColor,
            ),
          ),

          Positioned(
            top: 2,
            left: 4,
            child: Icon(
              Icons.auto_awesome,
              size: 14,
              color: primaryColor.withValues(
                alpha: 0.7,
              ),
            ),
          ),

          Positioned(
            top: 14,
            right: 0,
            child: Icon(
              Icons.auto_awesome,
              size: 10,
              color: primaryColor.withValues(
                alpha: 0.55,
              ),
            ),
          ),

          Positioned(
            bottom: 8,
            left: -4,
            child: Icon(
              Icons.auto_awesome,
              size: 9,
              color: primaryColor.withValues(
                alpha: 0.55,
              ),
            ),
          ),

          Positioned(
            bottom: 4,
            right: 2,
            child: Icon(
              Icons.auto_awesome,
              size: 12,
              color: primaryColor.withValues(
                alpha: 0.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}