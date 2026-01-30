import 'package:flutter/material.dart';
import 'widgets/loading_spinner.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8F4FB),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingSpinner(),
            SizedBox(height: 40),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF7E57C2),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}