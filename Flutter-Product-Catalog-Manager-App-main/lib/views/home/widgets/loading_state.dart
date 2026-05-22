import 'package:assignment_9/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          Text(
            "Loading Products...",
            style: TextStyle(
              color: AppColors.fabBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Synchronizing architectural datasets",
            style: TextStyle(color: Colors.black.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }
}
