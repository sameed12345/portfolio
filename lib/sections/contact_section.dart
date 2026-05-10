import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';
import '../widgets/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // Could not launch url
    }
  }

  // Future<void> _sendMessage() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   setState(() => _sending = true);
  //   await Future.delayed(1500.ms);
  //   if (mounted) {
  //     setState(() => _sending = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Row(
  //           children: [
  //             const Icon(Icons.check_circle_rounded, color: Colors.white),
  //             const SizedBox(width: 10),
  //             Text('Message sent! I\'ll get back to you soon.',
  //                 style:
  //                     AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
  //           ],
  //         ),
  //         backgroundColor: AppColors.accent,
  //         behavior: SnackBarBehavior.floating,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //       ),
  //     );
  //     _nameCtrl.clear();
  //     _emailCtrl.clear();
  //     _msgCtrl.clear();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 100),
      color: AppColors.bgSecondary,
      child: Column(
        children: [
          const SectionTitle(
            label: 'Contact',
            title: 'Get In Touch',
            subtitle: 'Let\'s build something amazing together',
          ),
          const SizedBox(height: 64),
          isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildInfoPanel()),
        const SizedBox(width: 40),
        // Expanded(flex: 6, child: _buildForm()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildInfoPanel(),
        const SizedBox(height: 40),
        // _buildForm(),
      ],
    );
  }

  Widget _buildInfoPanel() {
    final contacts = [
      (
        Icons.phone_rounded,
        'Phone',
        AppStrings.phone,
        'tel:+923115398769', // digits-only for tel: scheme
      ),
      (
        Icons.email_rounded,
        'Email',
        AppStrings.email,
        'mailto:${AppStrings.email}'
      ),
      (
        FontAwesomeIcons.linkedin,
        'LinkedIn',
        'sameed-hassan-505081376',
        AppStrings.linkedin
      ),
      (FontAwesomeIcons.github, 'GitHub', 'sameedhassan', AppStrings.github),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Work\nTogether',
          style: AppTextStyles.displaySmall.copyWith(height: 1.25),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.3, end: 0),

        const SizedBox(height: 16),

        Text(
          'Have a project in mind? Looking for a Flutter developer? '
          'Feel free to reach out — I\'m always open to discussing new opportunities.',
          style: AppTextStyles.bodyLarge,
        ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.3, end: 0),

        const SizedBox(height: 36),

        // Contact cards
        ...contacts.asMap().entries.map(
              (e) => _ContactCard(
                icon: e.value.$1,
                label: e.value.$2,
                value: e.value.$3,
                url: e.value.$4,
                index: e.key,
              ),
            ),

        const SizedBox(height: 32),

        // WhatsApp CTA
        _WhatsAppButton(onTap: () => _launch(AppStrings.whatsapp)),
      ],
    );
  }

  // Widget _buildForm() {
  //   return Container(
  //     padding: const EdgeInsets.all(32),
  //     decoration: BoxDecoration(
  //       gradient: AppColors.cardGradient,
  //       borderRadius: BorderRadius.circular(24),
  //       border: Border.all(color: AppColors.border),
  //     ),
  //     child: Form(
  //       key: _formKey,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Send a Message', style: AppTextStyles.headlineMedium)
  //               .animate()
  //               .fadeIn(delay: 200.ms)
  //               .slideX(begin: 0.3, end: 0),
  //           const SizedBox(height: 8),
  //           Text('I typically reply within 24 hours',
  //                   style: AppTextStyles.bodyMedium)
  //               .animate()
  //               .fadeIn(delay: 280.ms),
  //           const SizedBox(height: 28),
  //           _buildField('Your Name', Icons.person_rounded, _nameCtrl,
  //                   validator: (v) =>
  //                       v!.isEmpty ? 'Please enter your name' : null)
  //               .animate()
  //               .fadeIn(delay: 350.ms)
  //               .slideY(begin: 0.2, end: 0),
  //           const SizedBox(height: 16),
  //           _buildField('Email Address', Icons.email_rounded, _emailCtrl,
  //                   validator: (v) =>
  //                       !v!.contains('@') ? 'Enter a valid email' : null)
  //               .animate()
  //               .fadeIn(delay: 420.ms)
  //               .slideY(begin: 0.2, end: 0),
  //           const SizedBox(height: 16),
  //           _buildField('Your Message', Icons.message_rounded, _msgCtrl,
  //                   maxLines: 5,
  //                   validator: (v) =>
  //                       v!.length < 10 ? 'Message too short' : null)
  //               .animate()
  //               .fadeIn(delay: 490.ms)
  //               .slideY(begin: 0.2, end: 0),
  //           const SizedBox(height: 28),
  //           SizedBox(
  //             width: double.infinity,
  //             child: GestureDetector(
  //               onTap: _sending ? null : _sendMessage,
  //               child: AnimatedContainer(
  //                 duration: 250.ms,
  //                 padding: const EdgeInsets.symmetric(vertical: 16),
  //                 decoration: BoxDecoration(
  //                   gradient: AppColors.accentGradient,
  //                   borderRadius: BorderRadius.circular(14),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: AppColors.accent.withOpacity(0.35),
  //                       blurRadius: 20,
  //                       offset: const Offset(0, 6),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Center(
  //                   child: _sending
  //                       ? const SizedBox(
  //                           width: 22,
  //                           height: 22,
  //                           child: CircularProgressIndicator(
  //                               color: Colors.white, strokeWidth: 2),
  //                         )
  //                       : Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             const Icon(Icons.send_rounded,
  //                                 color: Colors.white, size: 18),
  //                             const SizedBox(width: 10),
  //                             Text('Send Message',
  //                                 style: AppTextStyles.titleMedium.copyWith(
  //                                     color: Colors.white,
  //                                     fontWeight: FontWeight.w700)),
  //                           ],
  //                         ),
  //                 ),
  //               ),
  //             ),
  //           ).animate().fadeIn(delay: 560.ms).slideY(begin: 0.2, end: 0),
  //         ],
  //       ),
  //     ),
  //   ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.3, end: 0);
  // }

  Widget _buildField(
    String hint,
    IconData icon,
    TextEditingController ctrl, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      validator: validator,
      style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyMedium,
        prefixIcon: maxLines == 1
            ? Icon(icon, color: AppColors.textMuted, size: 20)
            : null,
        filled: true,
        fillColor: AppColors.bgPrimary,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final dynamic icon;
  final String label;
  final String value;
  final String url;
  final int index;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.index,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  Future<void> _open() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withOpacity(0.08)
                : AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.5)
                  : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: widget.icon is IconData
                      ? Icon(widget.icon as IconData,
                          color: Colors.white, size: 20)
                      : FaIcon(widget.icon as IconData,
                          color: Colors.white, size: 18),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.label,
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textMuted, fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(widget.value, style: AppTextStyles.titleMedium),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: _hovered ? AppColors.accent : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
            delay: Duration(milliseconds: 350 + widget.index * 120),
            duration: 500.ms)
        .slideX(begin: -0.2, end: 0);
  }
}

class _WhatsAppButton extends StatefulWidget {
  final VoidCallback onTap;
  const _WhatsAppButton({required this.onTap});

  @override
  State<_WhatsAppButton> createState() => _WhatsAppButtonState();
}

class _WhatsAppButtonState extends State<_WhatsAppButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: 250.ms,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF25D366)
                : const Color(0xFF25D366).withOpacity(0.12),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: const Color(0xFF25D366).withOpacity(_hovered ? 1 : 0.4),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF25D366).withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.whatsapp,
                color: _hovered ? Colors.white : const Color(0xFF25D366),
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Chat on WhatsApp',
                style: AppTextStyles.labelLarge.copyWith(
                  color: _hovered ? Colors.white : const Color(0xFF25D366),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0);
  }
}
