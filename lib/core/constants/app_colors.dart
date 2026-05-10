import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds
  static const Color bgPrimary = Color(0xFF050B18);
  static const Color bgSecondary = Color(0xFF0A1628);
  static const Color bgCard = Color(0xFF0D1B2E);
  static const Color bgGlass = Color(0x0DFFFFFF);

  // Accents
  static const Color accent = Color(0xFF2979FF);
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color accentGlow = Color(0x552979FF);
  static const Color accentCyanGlow = Color(0x3300E5FF);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8FA3BF);
  static const Color textMuted = Color(0xFF4A6380);

  // Border
  static const Color border = Color(0xFF162033);
  static const Color borderGlow = Color(0x662979FF);

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF050B18), Color(0xFF0A1628), Color(0xFF050B18)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF2979FF), Color(0xFF00E5FF)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x1A2979FF), Color(0x0500E5FF)],
  );
}
