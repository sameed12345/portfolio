import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isScrolled = false;
  int _activeIndex = 0;
  bool _mobileMenuOpen = false;

  final List<String> _navItems = [
    'Home',
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Resume',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 30;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToSection(int index) {
    if (index < widget.sectionKeys.length) {
      final ctx = widget.sectionKeys[index].currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    }
    setState(() {
      _activeIndex = index;
      _mobileMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
        vertical: _isScrolled ? 12 : 18,
      ),
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.bgPrimary.withOpacity(0.95)
            : Colors.transparent,
        border: _isScrolled
            ? Border(
                bottom: BorderSide(
                  color: AppColors.border,
                  width: 1,
                ),
              )
            : null,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  // color: Colors.green,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: isMobile ? _buildMobileNav() : _buildDesktopNav(),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.5, end: 0);
  }

  Widget _buildDesktopNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        Row(
          children: List.generate(_navItems.length, (i) => _buildNavItem(i)),
        ),
        _buildHireMeButton(),
      ],
    );
  }

  Widget _buildMobileNav() {
    return Column(
      children: [
        // SizedBox(
        //   height: 10,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(),
            IconButton(
              icon: AnimatedSwitcher(
                duration: 300.ms,
                child: Icon(
                  _mobileMenuOpen ? Icons.close : Icons.menu,
                  key: ValueKey(_mobileMenuOpen),
                  color: AppColors.textPrimary,
                  size: 26,
                ),
              ),
              onPressed: () =>
                  setState(() => _mobileMenuOpen = !_mobileMenuOpen),
            ),
          ],
        ),
        AnimatedSize(
          duration: 300.ms,
          curve: Curves.easeInOut,
          child: _mobileMenuOpen
              ? Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      ...List.generate(
                        _navItems.length,
                        (i) => _buildMobileNavItem(i),
                      ),
                      const SizedBox(height: 12),
                      _buildHireMeButton(),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.accentGradient.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(
        'S.H',
        style: AppTextStyles.headlineLarge.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isActive = _activeIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _scrollToSection(index),
        child: AnimatedContainer(
          duration: 200.ms,
          margin: const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.accent.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isActive
                ? Border.all(color: AppColors.accent.withOpacity(0.4))
                : null,
          ),
          child: Text(
            _navItems[index],
            style: AppTextStyles.labelLarge.copyWith(
              color: isActive ? AppColors.accent : AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(int index) {
    final isActive = _activeIndex == index;
    return GestureDetector(
      onTap: () => _scrollToSection(index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color:
              isActive ? AppColors.accent.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _navItems[index],
          style: AppTextStyles.labelLarge.copyWith(
            color: isActive ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildHireMeButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _scrollToSection(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'Hire Me',
            style: AppTextStyles.labelLarge.copyWith(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
