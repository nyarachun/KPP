import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle title(double size) => TextStyle(
        fontFamily: 'Playfair Display',
        fontSize: size,
        height: 1.1,
        color: AppColors.text,
      );

  static TextStyle body(
    double size, {
    Color color = AppColors.muted,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(fontFamily: 'Inter', fontSize: size, color: color, fontWeight: weight);

  static TextStyle eyebrow(double size) => TextStyle(
        fontFamily: 'Inter',
        fontSize: size,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: AppColors.primary,
      );
}
