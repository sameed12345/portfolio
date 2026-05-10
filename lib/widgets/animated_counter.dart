import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class AnimatedCounter extends StatefulWidget {
  final int target;
  final String suffix;
  final String label;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.target,
    required this.suffix,
    required this.label,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_started) {
      _started = true;
      Future.delayed(300.ms, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('counter_${widget.label}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3) _startAnimation();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final value = (_animation.value * widget.target).round();
          return Column(
            children: [
              // Number display
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.accentGradient.createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: Text(
                  '$value${widget.suffix}',
                  style: AppTextStyles.displayMedium.copyWith(
                    fontSize: 52,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      )
          .animate()
          .fadeIn(delay: 200.ms, duration: 600.ms)
          .slideY(begin: 0.3, end: 0),
    );
  }
}
