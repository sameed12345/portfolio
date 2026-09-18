import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactTap;
  const HeroSection({super.key, required this.onContactTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<double> _bgAnimation;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    _bgAnimation =
        CurvedAnimation(parent: _bgController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  Future<void> _launchCV() async {
    final uri = Uri.parse(AppStrings.cvUrl);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final hPad = Responsive.horizontalPadding(context);

    return SizedBox(
      width: double.infinity,
      height: isMobile ? null : MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Animated gradient background
          Positioned.fill(child: _buildAnimatedBg()),

          // Grid pattern overlay
          Positioned.fill(child: _buildGridOverlay()),

          // Glowing orbs
          Positioned(
              top: -100,
              left: -100,
              child: _buildOrb(300, AppColors.accentGlow)),
          Positioned(
              bottom: -80,
              right: -80,
              child: _buildOrb(250, AppColors.accentCyanGlow)),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: isMobile
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context, isTablet),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBg() {
    return AnimatedBuilder(
      animation: _bgAnimation,
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.bgPrimary,
              Color.lerp(AppColors.bgPrimary, AppColors.bgSecondary,
                  _bgAnimation.value)!,
              AppColors.bgPrimary,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridOverlay() {
    return CustomPaint(painter: _GridPainter());
  }

  Widget _buildOrb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _buildTextContent(context)),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _buildAvatarCard()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            _buildAvatarCard(),
            const SizedBox(height: 40),
            _buildTextContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final fontSize = Responsive.heroFontSize(context);
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.accent.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentCyan,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for Work',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.accentCyan,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 600.ms)
            .slideX(begin: -0.3, end: 0),

        const SizedBox(height: 24),

        // Greeting
        Text(
          'Hello, I\'m',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideX(begin: -0.3, end: 0),

        const SizedBox(height: 8),

        // Name with gradient
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.accentGradient.createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            AppStrings.name,
            style: AppTextStyles.gradient.copyWith(fontSize: fontSize),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 700.ms)
            .slideX(begin: -0.3, end: 0),

        const SizedBox(height: 16),

        // Animated typewriter title
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Flutter Developer',
                  textStyle: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.accentCyan,
                    fontWeight: FontWeight.w600,
                  ),
                  speed: 80.ms,
                ),
                TypewriterAnimatedText(
                  'Mobile App Expert',
                  textStyle: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.accentCyan,
                    fontWeight: FontWeight.w600,
                  ),
                  speed: 80.ms,
                ),
                TypewriterAnimatedText(
                  'UI/UX Enthusiast',
                  textStyle: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.accentCyan,
                    fontWeight: FontWeight.w600,
                  ),
                  speed: 80.ms,
                ),
              ],
              repeatForever: true,
            ),
          ],
        ).animate().fadeIn(delay: 700.ms, duration: 600.ms),

        const SizedBox(height: 20),

        // Tagline
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            AppStrings.tagline,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        )
            .animate()
            .fadeIn(delay: 900.ms, duration: 600.ms)
            .slideX(begin: -0.2, end: 0),

        const SizedBox(height: 40),

        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildPrimaryButton(
              'Download CV',
              Icons.download_rounded,
              _launchCV,
            ),
            _buildOutlineButton(
              'Hire Me',
              Icons.send_rounded,
              widget.onContactTap,
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 1100.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 40),

        // Tech stack badges
        _buildTechBadges(isMobile),
      ],
    );
  }

  Widget _buildTechBadges(bool isMobile) {
    final techs = ['Flutter', 'Dart', 'Firebase', 'Supabase', 'REST APIs'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: techs
          .asMap()
          .entries
          .map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.bgGlass,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                e.value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            )
                .animate()
                .fadeIn(delay: (1200 + e.key * 80).ms, duration: 400.ms)
                .slideY(begin: 0.3, end: 0),
          )
          .toList(),
    );
  }

////////////////////////
  Widget _buildAvatarCard() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            //width: 280,
            width: 320,
            height: 320,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.accentGradient,
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
              begin: const Offset(1, 1),
              end: const Offset(1.05, 1.05),
              duration: 3.seconds,
              curve: Curves.easeInOut),

          // Inner background
          Container(
            // width: 268,
            width: 318,
            height: 318,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.bgPrimary,
            ),
          ),

          // Avatar circle
          Container(
            // width: 256,
            width: 310,
            height: 310,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.cardGradient,
              border: Border.all(
                color: AppColors.accent.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0D1B2E), Color(0xFF162033)],
                  ),
                ),
                child: Image.asset(
                  'assets/images/sam.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 600.ms, duration: 800.ms)
        .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1));
  }

  Widget _buildPrimaryButton(String label, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.45),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(String label, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppColors.accent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.accent, size: 18),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF162033).withOpacity(0.4)
      ..strokeWidth = 0.5;

    const step = 50.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
