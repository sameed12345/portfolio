import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';
import '../widgets/animated_counter.dart';
import '../widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final hPad = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 100),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.bgPrimary,
            AppColors.bgSecondary,
            AppColors.bgPrimary
          ],
        ),
      ),
      child: Column(
        children: [
          const SectionTitle(
            label: 'About Me',
            title: 'Who Am I?',
            subtitle:
                'Passionate Flutter developer crafting exceptional mobile experiences',
          ),
          const SizedBox(height: 72),
          isMobile
              ? _buildMobileContent(context)
              : _buildDesktopContent(context),
          const SizedBox(height: 80),
          _buildStatsRow(context),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  Expanded(flex: 5, child: _buildImageCard()),
        const SizedBox(width: 60),
        Expanded(flex: 6, child: _buildTextContent()),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      children: [
        //  _buildImageCard(),

        _buildTextContent(),
      ],
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.aboutBio, style: AppTextStyles.bodyLarge)
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideX(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        Text(
          'I believe in writing clean, maintainable code and building apps that users love. '
          'My journey spans from crafting pixel-perfect UIs to architecting robust backend '
          'integrations — always with performance and user experience at the forefront.',
          style: AppTextStyles.bodyLarge,
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 600.ms)
            .slideX(begin: 0.3, end: 0),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final stats = [
      (2, '+', 'Years Experience'),
      (3, '+', 'Projects\nCompleted'),
      (6, '+', 'Technologies'),
      (100, '%', 'Client Satisfaction'),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: isMobile
          ? GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.0,
              children: stats
                  .map((s) =>
                      AnimatedCounter(target: s.$1, suffix: s.$2, label: s.$3))
                  .toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: stats
                  .map((s) => Expanded(
                        child: AnimatedCounter(
                            target: s.$1, suffix: s.$2, label: s.$3),
                      ))
                  .toList(),
            ),
    );
  }
}

// class _DotPatternPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = AppColors.accent.withOpacity(0.08);
//     const gap = 24.0;
//     for (double x = gap; x < size.width; x += gap) {
//       for (double y = gap; y < size.height; y += gap) {
//         canvas.drawCircle(Offset(x, y), 1.5, paint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(_) => false;
// }
