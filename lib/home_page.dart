import 'package:flutter/material.dart';
import 'package:portfolio/sections/footer_section.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/constants/app_colors.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/resume_section.dart';
import 'sections/skills_section.dart';
import 'widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // One key per section: Home, About, Skills, Experience, Projects, Resume, Contact
  final List<GlobalKey> _sectionKeys = List.generate(7, (_) => GlobalKey());

  final List<String> _navLabels = [
    'Home',
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Resume',
    'Contact',
  ];

  void _scrollTo(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          // ── Scrollable content ──────────────────────────────────────────
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                // Extra top padding to clear sticky nav
                const SizedBox(height: 60),

                // 1. Hero
                KeyedSubtree(
                  key: _sectionKeys[0],
                  child: HeroSection(
                    onContactTap: () => _scrollTo(6),
                  ),
                ),

                // 2. About
                KeyedSubtree(
                  key: _sectionKeys[1],
                  child: const AboutSection(),
                ),

                // 3. Skills
                KeyedSubtree(
                  key: _sectionKeys[2],
                  child: const SkillsSection(),
                ),

                // 4. Experience
                KeyedSubtree(
                  key: _sectionKeys[3],
                  child: const ExperienceSection(),
                ),

                // 5. Projects
                KeyedSubtree(
                  key: _sectionKeys[4],
                  child: const ProjectsSection(),
                ),

                // 6. Resume
                KeyedSubtree(
                  key: _sectionKeys[5],
                  child: const ResumeSection(),
                ),

                // 7. Contact
                KeyedSubtree(
                  key: _sectionKeys[6],
                  child: const ContactSection(),
                ),

                // 8. Footer
                FooterSection(
                  navLabels: _navLabels,
                  navCallbacks: List.generate(
                    _navLabels.length,
                    (i) => () => _scrollTo(i),
                  ),
                ),
              ],
            ),
          ),

          // ── Sticky Navbar overlay ───────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}

class _WhatsAppFab extends StatefulWidget {
  @override
  State<_WhatsAppFab> createState() => _WhatsAppFabState();
}

class _WhatsAppFabState extends State<_WhatsAppFab>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse('https://wa.me/923000000000');
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
        onTap: _openWhatsApp,
        child: AnimatedBuilder(
          animation: _pulseAnim,
          builder: (_, child) => Transform.scale(
            scale: _hovered ? 1.1 : _pulseAnim.value,
            child: child,
          ),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF25D366),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF25D366).withOpacity(0.5),
                  blurRadius: _hovered ? 24 : 16,
                  spreadRadius: _hovered ? 4 : 2,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.chat_bubble_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
