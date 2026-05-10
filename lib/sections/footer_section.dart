import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';

class FooterSection extends StatelessWidget {
  final List<String> navLabels;
  final List<VoidCallback> navCallbacks;

  const FooterSection({
    super.key,
    required this.navLabels,
    required this.navCallbacks,
  });

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // Could not launch url
    }
  }

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.bgPrimary,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          // Main footer content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 60),
            child: isMobile
                ? _buildMobileFooter(context)
                : _buildDesktopFooter(context),
          ),

          // Bottom bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: isMobile
                ? const Column(
                    children: [
                      //_buildCopyright(),
                      SizedBox(height: 12),
                      //  _buildMadeWith(),
                    ],
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // _buildCopyright(),

                      // _buildMadeWith()
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand column
        Expanded(flex: 4, child: _buildBrandColumn()),
        const SizedBox(width: 60),
        // Quick links
        Expanded(flex: 3, child: _buildQuickLinks()),
        const SizedBox(width: 40),
        // Contact info
        Expanded(flex: 4, child: _buildContactColumn()),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBrandColumn(centered: true),
        const SizedBox(height: 40),
        _buildQuickLinks(centered: true),
        const SizedBox(height: 40),
        _buildContactColumn(centered: true),
      ],
    );
  }

  Widget _buildBrandColumn({bool centered = false}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Logo
        ShaderMask(
          shaderCallback: (b) => AppColors.accentGradient.createShader(b),
          blendMode: BlendMode.srcIn,
          child: Text(
            'S.H',
            style: AppTextStyles.displaySmall.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
        ).animate().fadeIn(delay: 100.ms),

        const SizedBox(height: 12),

        Text(
          'Flutter Developer',
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.accent),
        ).animate().fadeIn(delay: 150.ms),

        const SizedBox(height: 16),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            'Building beautiful, high-performance mobile experiences with Flutter & Dart.',
            style: AppTextStyles.bodyMedium,
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ).animate().fadeIn(delay: 200.ms),

        const SizedBox(height: 28),

        // Social icons
        _buildSocialIcons(centered),
      ],
    );
  }

  Widget _buildSocialIcons(bool centered) {
    final socials = [
      (FontAwesomeIcons.linkedin, AppStrings.linkedin, AppColors.accent),
      (FontAwesomeIcons.whatsapp, AppStrings.whatsapp, const Color(0xFF25D366)),
      (FontAwesomeIcons.github, AppStrings.github, AppColors.textSecondary),
      (
        FontAwesomeIcons.envelope,
        'mailto:${AppStrings.email}',
        AppColors.accentCyan
      ),
    ];

    final row = Row(
      mainAxisSize: centered ? MainAxisSize.min : MainAxisSize.min,
      children: socials
          .asMap()
          .entries
          .map(
            (e) => _SocialIcon(
              icon: e.value.$1,
              url: e.value.$2,
              color: e.value.$3,
              delay: e.key * 80,
            ),
          )
          .toList(),
    );

    return centered ? Center(child: row) : row;
  }

  Widget _buildQuickLinks({bool centered = false}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 4),
        Container(
          width: 36,
          height: 2,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(2),
          ),
          margin: EdgeInsets.only(
            bottom: 20,
            left: centered ? 0 : 0,
          ),
        ).animate().fadeIn(delay: 250.ms).scaleX(begin: 0, end: 1),
        ...navLabels.asMap().entries.map(
              (e) => _FooterLink(
                label: e.value,
                onTap: navCallbacks[e.key],
                delay: 300 + e.key * 60,
              ),
            ),
      ],
    );
  }

  Widget _buildContactColumn({bool centered = false}) {
    // (icon, displayText, url or null)
    final items = [
      (Icons.phone_rounded, AppStrings.phone, 'tel:${AppStrings.phone}'),
      (Icons.email_rounded, AppStrings.email, 'mailto:${AppStrings.email}'),
      (Icons.location_on_rounded, 'Multan, Pakistan', null),
      (Icons.access_time_rounded, 'Available Mon–Sat', null),
    ];

    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Get In Touch',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 4),
        Container(
          width: 36,
          height: 2,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate().fadeIn(delay: 250.ms).scaleX(begin: 0, end: 1),
        ...items.asMap().entries.map(
          (e) {
            final url = e.value.$3;
            final row = Row(
              mainAxisSize: centered ? MainAxisSize.min : MainAxisSize.max,
              children: [
                Icon(e.value.$1, size: 15, color: AppColors.accent),
                const SizedBox(width: 10),
                Text(e.value.$2, style: AppTextStyles.bodyMedium),
              ],
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: url != null
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _launch(url),
                        child: row,
                      ),
                    )
                  : row,
            )
                .animate()
                .fadeIn(delay: Duration(milliseconds: 300 + e.key * 70))
                .slideX(begin: 0.1, end: 0);
          },
        ),
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      AppStrings.copyright,
      style: AppTextStyles.bodyMedium.copyWith(
        fontSize: 12,
        color: AppColors.textMuted,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMadeWith() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '#083072 ',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
        const Icon(Icons.favorite_rounded, size: 13, color: Colors.redAccent),
        // Text(
        //       ' using Flutter',
        //   style: AppTextStyles.bodyMedium.copyWith(
        //     fontSize: 12,
        //     color: AppColors.textMuted,
        //   ),
        // ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final Color color;
  final int delay;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.color,
    required this.delay,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  Future<void> _open() async {
    final uri = Uri.parse(widget.url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // Could not launch url
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _open,
        child: AnimatedContainer(
          duration: 200.ms,
          margin: const EdgeInsets.only(right: 10),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _hovered ? widget.color.withOpacity(0.2) : AppColors.bgCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  _hovered ? widget.color.withOpacity(0.6) : AppColors.border,
            ),
          ),
          child: Center(
            child: FaIcon(
              widget.icon,
              size: 16,
              color: _hovered ? widget.color : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: widget.delay))
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final int delay;

  const _FooterLink({
    required this.label,
    required this.onTap,
    required this.delay,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AnimatedDefaultTextStyle(
            duration: 200.ms,
            style: AppTextStyles.bodyMedium.copyWith(
              color: _hovered ? AppColors.accent : AppColors.textSecondary,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: 200.ms,
                  width: _hovered ? 14 : 0,
                  height: 2,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(widget.label),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: widget.delay))
        .slideX(begin: -0.1, end: 0);
  }
}
