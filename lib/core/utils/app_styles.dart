import 'package:flutter/material.dart';
import 'package:food_hub/core/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppFontStyles {
  // W400
  static TextStyle w400_12 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle w400_14 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle w400_16 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle w400_18 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  // W500
  static TextStyle w500_13 = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle w500_14 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle w500_16 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black
  );

  static TextStyle w500_18 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primary
  );

  static TextStyle w500_20 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  // W600
  static TextStyle w600_12 = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static TextStyle w600_18 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // W700
  static TextStyle w700_20 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
}