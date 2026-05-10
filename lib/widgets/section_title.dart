import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;

  const SectionTitle({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.labelLarge.copyWith(
              fontSize: 11,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 100.ms, duration: 500.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 16),

        // Main title with gradient
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.accentGradient.createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            title,
            style: AppTextStyles.displaySmall,
            textAlign: TextAlign.center,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),

        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0),
        ],

        const SizedBox(height: 8),
        // Decorative underline
        Container(
          margin: const EdgeInsets.only(top: 12),
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate().fadeIn(delay: 400.ms).scaleX(begin: 0, end: 1),
      ],
    );
  }
}
