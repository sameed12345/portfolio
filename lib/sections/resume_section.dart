import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';
import '../widgets/section_title.dart';

class ResumeSection extends StatefulWidget {
  const ResumeSection({super.key});

  @override
  State<ResumeSection> createState() => _ResumeSectionState();
}

class _ResumeSectionState extends State<ResumeSection> {
  bool _hovered = false;

  Future<void> _downloadCV() async {
    final uri = Uri.parse(AppStrings.cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 100),
      color: AppColors.bgPrimary,
      child: Column(
        children: [
          const SectionTitle(
            label: 'Resume',
            title: 'Download CV',
            subtitle: 'Get a complete overview of my skills and experience',
          ),
          const SizedBox(height: 64),

          // Main CV card
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 780),
            child: Container(
              padding: EdgeInsets.all(isMobile ? 32 : 56),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.borderGlow, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Icon
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.4),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.description_rounded,
                      color: Colors.white,
                      size: 44,
                    ),
                  ).animate().fadeIn(delay: 200.ms).scale(
                      begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),

                  const SizedBox(height: 28),

                  Text(
                    AppStrings.name,
                    style: AppTextStyles.headlineLarge,
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 8),

                  ShaderMask(
                    shaderCallback: (b) =>
                        AppColors.accentGradient.createShader(b),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      'Senior Flutter Developer',
                      style: AppTextStyles.titleLarge,
                    ),
                  ).animate().fadeIn(delay: 380.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 20),

                  Text(
                    '2+ years of experience building cross-platform mobile applications '
                    'with Flutter, Dart, Firebase, and Supabase.',
                    style: AppTextStyles.bodyLarge,
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 460.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 36),

                  // Key highlights row
                  isMobile
                      ? Column(
                          children: _buildHighlights(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildHighlights()
                              .map((w) => Expanded(child: w))
                              .toList(),
                        ),

                  const SizedBox(height: 40),

                  // Download button
                  MouseRegion(
                    onEnter: (_) => setState(() => _hovered = true),
                    onExit: (_) => setState(() => _hovered = false),
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _downloadCV,
                      child: AnimatedContainer(
                        duration: 250.ms,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 18),
                        decoration: BoxDecoration(
                          gradient: AppColors.accentGradient,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent
                                  .withOpacity(_hovered ? 0.6 : 0.35),
                              blurRadius: _hovered ? 32 : 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedRotation(
                              turns: _hovered ? 0.1 : 0,
                              duration: 250.ms,
                              child: const Icon(Icons.download_rounded,
                                  color: Colors.white, size: 22),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Download Resume',
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 16),
                  //
                  // Text(
                  //   'PDF Format • Updated May 2025',
                  //   style: AppTextStyles.bodyMedium.copyWith(
                  //     color: AppColors.textMuted,
                  //     fontSize: 12,
                  //   ),
                  // ).animate().fadeIn(delay: 700.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHighlights() {
    final items = [
      (Icons.work_rounded, '2+', 'Years Experience'),
      (Icons.apps_rounded, '3+', 'Projects Done'),
      (Icons.star_rounded, '100%', 'Satisfaction'),
    ];
    return items
        .asMap()
        .entries
        .map(
          (e) => Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.bgGlass,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Icon(e.value.$1, color: AppColors.accent, size: 24),
                const SizedBox(height: 8),
                ShaderMask(
                  shaderCallback: (b) =>
                      AppColors.accentGradient.createShader(b),
                  blendMode: BlendMode.srcIn,
                  child: Text(e.value.$2,
                      style: AppTextStyles.headlineMedium
                          .copyWith(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(height: 4),
                Text(e.value.$3,
                    style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                    textAlign: TextAlign.center),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: (500 + e.key * 100).ms)
              .slideY(begin: 0.2, end: 0),
        )
        .toList();
  }
}
