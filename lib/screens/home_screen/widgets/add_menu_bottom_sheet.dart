import 'package:material_ui/material_ui.dart';
import 'package:wishlist/app/theme/colors.dart';
import 'package:wishlist/screens/wish_creation_screen/wish_creation_screen.dart';
import 'package:wishlist/screens/wishlist_creation_screen/wishlist_creation_screen.dart';
import 'package:wishlist/widgets/option_card.dart';

class AddMenuBottomSheet extends StatelessWidget {
  final String userId;

  const AddMenuBottomSheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pinkGradient = LinearGradient(
      colors: isDark
          ? [AppColors.pinkDarkStart, AppColors.pinkDarkEnd]
          : [AppColors.pinkLightStart, AppColors.pinkLightEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final purpleGradient = LinearGradient(
      colors: isDark
          ? [AppColors.purpleDarkStart, AppColors.purpleDarkEnd]
          : [AppColors.purpleLightStart, AppColors.purpleLightEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );


    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
     child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(isDark),
          const SizedBox(height: 30),

          OptionCard(
              gradient: pinkGradient,
              imagePath: 'assets/images/gift_box.png',
              title: 'Add a New Wish',
              subtitle: 'Create a detailed wish item',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, 
                    MaterialPageRoute(
                        builder: (_) => WishCreationScreen(userId: userId)));
                },
              ),
          const SizedBox(height: 20),
          
          OptionCard(
              gradient: purpleGradient,
              imagePath: 'assets/images/present.png',
              title: 'New Wishlist/Occasion',
              subtitle: 'Create a custom category or event',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => WishlistCreationScreen(userId: userId)));
              },
          ),
          const SizedBox(height: 20),
        ],
      ),
     ),
    );
  }

  Widget _buildHandle(bool isDark) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: isDark ? Colors.white24 : Colors.black12,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

}