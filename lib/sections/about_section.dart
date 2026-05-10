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

  // Widget _buildImageCard() {
  //   return Container(
  //     height: 420,
  //     decoration: BoxDecoration(
  //       gradient: AppColors.cardGradient,
  //       borderRadius: BorderRadius.circular(24),
  //       border: Border.all(color: AppColors.border),
  //     ),
  //     child: Stack(
  //       children: [
  //         Positioned.fill(
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(24),
  //             child: CustomPaint(painter: _DotPatternPainter()),
  //           ),
  //         ),
  //         Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 width: 140,
  //                 height: 140,
  //                 decoration: const BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   gradient: AppColors.accentGradient,
  //                 ),
  //                 child: const Center(
  //                   child:
  //                       Icon(Icons.flutter_dash, size: 72, color: Colors.white),
  //                 ),
  //               ),
  //               const SizedBox(height: 24),
  //               ShaderMask(
  //                 shaderCallback: (b) =>
  //                     AppColors.accentGradient.createShader(b),
  //                 blendMode: BlendMode.srcIn,
  //                 child: Text('Flutter Developer',
  //                     style: AppTextStyles.headlineMedium),
  //               ),
  //               const SizedBox(height: 8),
  //               Text('2+ Years of Excellence', style: AppTextStyles.bodyMedium),
  //               const SizedBox(height: 24),
  //               Wrap(
  //                 spacing: 8,
  //                 runSpacing: 8,
  //                 alignment: WrapAlignment.center,
  //                 children: ['Flutter', 'Firebase', 'Dart', 'Supabase']
  //                     .map((t) => Container(
  //                           padding: const EdgeInsets.symmetric(
  //                               horizontal: 12, vertical: 6),
  //                           decoration: BoxDecoration(
  //                             color: AppColors.accent.withOpacity(0.15),
  //                             borderRadius: BorderRadius.circular(50),
  //                             border: Border.all(
  //                                 color: AppColors.accent.withOpacity(0.3)),
  //                           ),
  //                           child: Text(t,
  //                               style: AppTextStyles.bodyMedium.copyWith(
  //                                   color: AppColors.accent, fontSize: 12)),
  //                         ))
  //                     .toList(),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   )
  //       .animate()
  //       .fadeIn(delay: 200.ms, duration: 700.ms)
  //       .slideX(begin: -0.3, end: 0);
  // }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('Building Digital Experiences\nThat Matter',
        //         style: AppTextStyles.headlineLarge.copyWith(height: 1.3))
        //     .animate()
        //     .fadeIn(delay: 300.ms, duration: 600.ms)
        //     .slideX(begin: 0.3, end: 0),
        // const SizedBox(height: 20),
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
        //         ...[
        //   (
        //     '🚀',
        //     'Performance-First',
        //     'Optimized apps with smooth 60fps animations'
        //   ),
        //   ('🎨', 'Design Oriented', 'Pixel-perfect UI from Figma designs'),
        //   (
        //     '🔧',
        //     'Clean Architecture',
        //     'Scalable code with BLoC, Riverpod & SOLID'
        //   ),
        // ].asMap().entries.map(
        //     (e) => _buildHighlight(e.value.$1, e.value.$2, e.value.$3, e.key)),
      ],
    );
  }

  // Widget _buildHighlight(String emoji, String title, String desc, int index) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 16),
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: AppColors.bgGlass,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: AppColors.border),
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         //  Text(emoji, style: const TextStyle(fontSize: 24)),
  //         const SizedBox(width: 14),
  //         // Expanded(
  //         //   child: Column(
  //         //     crossAxisAlignment: CrossAxisAlignment.start,
  //         //     children: [
  //         //       Text(title, style: AppTextStyles.titleMedium),
  //         //       const SizedBox(height: 4),
  //         //       Text(desc, style: AppTextStyles.bodyMedium),
  //         //     ],
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   )
  //       .animate()
  //       .fadeIn(delay: (600 + index * 120).ms, duration: 500.ms)
  //       .slideX(begin: 0.2, end: 0);
  // }

  Widget _buildStatsRow(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final stats = [
      (2, '+', 'Years Experience'),
      (15, '+', 'Projects\nCompleted'),
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
