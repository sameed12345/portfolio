import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 100),
      color: AppColors.bgPrimary,
      child: Column(
        children: [
          const SectionTitle(
            label: 'Experience',
            title: 'Work History',
            subtitle: 'My professional journey in Flutter development',
          ),
          const SizedBox(height: 72),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Column(
              children: PortfolioData.experience
                  .asMap()
                  .entries
                  .map((e) => _TimelineItem(
                        model: e.value,
                        index: e.key,
                        isLast: e.key == PortfolioData.experience.length - 1,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final ExperienceModel model;
  final int index;
  final bool isLast;

  const _TimelineItem({
    required this.model,
    required this.index,
    required this.isLast,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _visible = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return VisibilityDetector(
      key: Key('exp_${widget.index}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.25 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _visible ? 1 : 0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 600),
          offset: _visible ? Offset.zero : const Offset(0, 0.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline column
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    // Dot
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.5),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    if (!widget.isLast)
                      Container(
                        width: 2,
                        height: 280,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.accent.withOpacity(0.6),
                              AppColors.accent.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Card
              Expanded(
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hovered = true),
                  onExit: (_) => setState(() => _hovered = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.only(bottom: widget.isLast ? 0 : 40),
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: _hovered ? AppColors.cardGradient : null,
                      color: _hovered ? null : AppColors.bgCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _hovered
                            ? AppColors.accent.withOpacity(0.5)
                            : AppColors.border,
                        width: _hovered ? 1.5 : 1,
                      ),
                      boxShadow: _hovered
                          ? [
                              BoxShadow(
                                color: AppColors.accent.withOpacity(0.12),
                                blurRadius: 30,
                                offset: const Offset(0, 8),
                              )
                            ]
                          : [],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Period badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: AppColors.accentGradient,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            widget.model.period,
                            style: AppTextStyles.labelLarge.copyWith(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Role
                        Text(
                          widget.model.role,
                          style: AppTextStyles.headlineMedium,
                        ),

                        const SizedBox(height: 6),

                        // Company
                        Row(
                          children: [
                            const Icon(Icons.business_rounded,
                                size: 16, color: AppColors.accent),
                            const SizedBox(width: 6),
                            Text(
                              widget.model.company,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Text(
                          widget.model.description,
                          style: AppTextStyles.bodyLarge,
                        ),

                        const SizedBox(height: 20),

                        // Highlights
                        // Wrap(
                        //   spacing: 8,
                        //   runSpacing: 8,
                        //   children: widget.model.highlights
                        //       .map(
                        //         (h) => Container(
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: 12, vertical: 6),
                        //           decoration: BoxDecoration(
                        //             color: AppColors.bgGlass,
                        //             borderRadius: BorderRadius.circular(6),
                        //             border: Border.all(color: AppColors.border),
                        //           ),
                        //           child: Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               const Icon(Icons.check_circle_rounded,
                        //                   size: 13,
                        //                   color: AppColors.accentCyan),
                        //               const SizedBox(width: 6),
                        //               Text(
                        //                 h,
                        //                 style:
                        //                     AppTextStyles.bodyMedium.copyWith(
                        //                   fontSize: 12,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //       .toList(),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
