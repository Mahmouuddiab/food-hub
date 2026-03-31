import 'package:flutter/material.dart';
import 'package:food_hub/core/utils/app_colors.dart';

class BottomText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;

  const BottomText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(normalText, style: TextStyle(color: AppColors.gray)),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}