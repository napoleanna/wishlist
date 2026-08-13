
import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class ReasonTile extends StatefulWidget {
  final String reason;
  final String imagePath;
  final VoidCallback onTap;

  const ReasonTile({
    super.key,
    required this.reason,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<ReasonTile> createState() => _ReasonTileState();
}

class _ReasonTileState extends State<ReasonTile> with SingleTickerProviderStateMixin{
  double _scale = 1.0;

  void _onTapDown( TapDownDetails details) {
    setState(() {
      _scale = 0.9;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark
        ? Theme.of(context).colorScheme.primary
        : const Color(0xFF6D17AA);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: isDark ? 2 : 6,
        shadowColor: isDark ? Colors.black.withValues(alpha: 0.5) : Colors.black38,
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Opacity(
                 opacity: isDark ? 0.4 : 0.6,
                 child: Image.asset(
                     widget.imagePath,
                     fit: BoxFit.cover,
                   errorBuilder: (context, error, stackTrace) => Container(
                     color: isDark ? Colors.white10 : Colors.grey[300],
                    ),
                   ),
                  ),
                ),
              ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    isDark ? Colors.black54 : Colors.white24,
                  ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              widget.reason,
               style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
                shadows: [
                  Shadow(
                   offset: const Offset(0, 1),
                   blurRadius: 4,
                   color: isDark ? Colors.black : Colors.black26,
                  ),
                ],
              ),
               textAlign: TextAlign.center,
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
               ),
               ),

          ),
        ],
       ),
      ),
      ),
    );
  }


}