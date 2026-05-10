import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);
    final cols = Responsive.skillGridColumns(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 100),
      color: AppColors.bgSecondary,
      child: Column(
        children: [
          const SectionTitle(
            label: 'Skills',
            title: 'My Expertise',
            subtitle: 'Technologies and tools I work with professionally',
          ),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth =
                  (constraints.maxWidth - (cols - 1) * 24) / cols;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: PortfolioData.skills
                    .asMap()
                    .entries
                    .map((e) => SizedBox(
                          width: itemWidth,
                          child: _SkillCard(model: e.value, index: e.key),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillModel model;
  final int index;
  const _SkillCard({required this.model, required this.index});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _visible = false;
  late AnimationController _barController;

  @override
  void initState() {
    super.initState();
    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _barController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('skill_${widget.model.category}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_visible) {
          setState(() => _visible = true);
          Future.delayed(Duration(milliseconds: widget.index * 100), () {
            if (mounted) _barController.forward();
          });
        }
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: _hovered ? AppColors.cardGradient : null,
            color: _hovered ? null : AppColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered ? AppColors.accent.withOpacity(0.5) : AppColors.border,
              width: _hovered ? 1.5 : 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.model.icon, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      widget.model.category,
                      style: AppTextStyles.titleMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Skill bars
              ...widget.model.skills.asMap().entries.map(
                    (e) => _SkillBar(
                      item: e.value,
                      controller: _barController,
                      delay: e.key * 150,
                    ),
                  ),
            ],
          ),
        ),
      )
          .animate()
          .fadeIn(
              delay: Duration(milliseconds: 200 + widget.index * 100),
              duration: 600.ms)
          .slideY(begin: 0.3, end: 0),
    );
  }
}

class _SkillBar extends StatelessWidget {
  final SkillItem item;
  final AnimationController controller;
  final int delay;

  const _SkillBar({
    required this.item,
    required this.controller,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name, style: AppTextStyles.bodyMedium),
              Text(
                '${(item.level * 100).round()}%',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, __) {
                final progress = (controller.value - delay / 1200).clamp(0.0, 1.0);
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress * item.level,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
