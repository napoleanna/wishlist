import 'package:flutter/material.dart';
import '../../../widgets/animated_nav_item.dart';


class HomeBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const HomeBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomAppBar(
      elevation: 0,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.zero,
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isDark ? Theme.of(context).cardTheme.color : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: isDark
              ? Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1)
              : null,
          boxShadow: isDark ? [] : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(0, Icons.list_alt_rounded),
            _item(1, Icons.people_outline_rounded),
            _item(2, Icons.add),
            _item(3, Icons.person_outline),
          ],
        ),
      ),
    );
  }

  Widget _item(int index, IconData icon) {
    return AnimatedNavItem(
      icon: icon,
      isSelected: selectedIndex == index,
      onTap: () => onItemSelected(index),
    );
  }
}