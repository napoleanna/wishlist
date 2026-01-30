import 'package:flutter/material.dart';

class AnimatedNavItem extends StatelessWidget {
  const AnimatedNavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  static const List<Color> gradientColors = [
    Color(0xFF5126AA),
    Color(0xFFc39ac5),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            height: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                    duration: const Duration(microseconds: 300),
                curve: Curves.easeInOut,
                width: isSelected ? 45 : 30,
                height: isSelected ? 45 : 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isSelected ? const LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight) 
                      : null,
                color: isSelected ? null : Colors.transparent,
                ),
            child: Center(
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: animation,
                      child: ScaleTransition(
                          scale: animation,
                          child: child,
                      ),
                     );
                    },
                child: Icon(
                  icon,
                  key: ValueKey<bool>(isSelected),
                  color: isSelected ? Colors.white : Colors.grey[500],
                  size: isSelected ? 24: 26,
                ),
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
