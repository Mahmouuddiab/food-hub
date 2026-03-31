import 'package:flutter/material.dart';
import 'package:food_hub/core/utils/app_colors.dart';

class SubtitleText extends StatelessWidget {
  final String text;
  final double fontSize;

  const SubtitleText({
    super.key,
    required this.text,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: AppColors.gray,
      ),
    );
  }
}