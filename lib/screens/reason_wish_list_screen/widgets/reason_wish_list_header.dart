import 'package:material_ui/material_ui.dart';

class ReasonWishListHeader extends StatelessWidget {
  final String title;
  final int wishCount;

  const ReasonWishListHeader({
    super.key,
    required this.title,
    required this.wishCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        8,
      ),
      child: Row(
        children: [
          _buildBackButton(context),

          Expanded(
            child: Column(
              children: [
                Text(
                  'Wishes for $title',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF604580),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$wishCount '
                      '${wishCount == 1 ? 'wish' : 'wishes'}',
                  style: const TextStyle(
                    color: Color(0xFF9A82B8),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 44,
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8E6BBE)
                .withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 20,
        ),
        color: const Color(0xFF76539F),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}