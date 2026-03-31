import 'package:flutter/material.dart';
import 'package:food_hub/core/utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator; // ✅ NEW

  const AppTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
    required this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.validator, // ✅ NEW
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.gray),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: TextFormField( // ✅ changed
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator, // ✅ attach validator
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hint,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
          errorStyle: const TextStyle(height: 0), // optional (hide default spacing)
        ),
      ),
    );
  }
}