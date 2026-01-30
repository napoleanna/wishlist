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
    return BottomAppBar(
      elevation: 10,
      color: Colors.white,
      padding: EdgeInsets.zero,
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
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