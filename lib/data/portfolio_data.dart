import 'package:flutter/material.dart';

class SkillModel {
  final String category;
  final IconData icon;
  final List<SkillItem> skills;

  const SkillModel({
    required this.category,
    required this.icon,
    required this.skills,
  });
}

class SkillItem {
  final String name;
  final double level; // 0.0 – 1.0

  const SkillItem({required this.name, required this.level});
}

class ExperienceModel {
  final String company;
  final String role;
  final String period;
  final String description;
  final List<String> highlights;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    required this.highlights,
  });
}

class ProjectModel {
  final String videoPath;
  final String title;
  final String description;
  final List<String> technologies;
  final String? videoUrl;
  final Color accentColor;

  const ProjectModel({
    required this.videoPath,
    required this.title,
    required this.description,
    required this.technologies,
    this.videoUrl,
    required this.accentColor,
  });
}

class PortfolioData {
  static const List<SkillModel> skills = [
    SkillModel(
      category: 'Flutter & Dart',
      icon: Icons.flutter_dash,
      skills: [
        SkillItem(name: 'Flutter', level: 0.95),
        SkillItem(name: 'Dart', level: 0.92),
        SkillItem(name: 'Widget Composition', level: 0.90),
        SkillItem(name: 'Custom Animations', level: 0.85),
      ],
    ),
    SkillModel(
      category: 'Firebase & Supabase',
      icon: Icons.cloud,
      skills: [
        SkillItem(name: 'Firebase Auth', level: 0.90),
        SkillItem(name: 'Firestore', level: 0.88),
        SkillItem(name: 'Supabase', level: 0.80),
        SkillItem(name: 'Cloud Functions', level: 0.75),
      ],
    ),
    SkillModel(
      category: 'REST APIs',
      icon: Icons.api,
      skills: [
        SkillItem(name: 'HTTP / Dio', level: 0.92),
        SkillItem(name: 'JSON Parsing', level: 0.95),
        SkillItem(name: 'OAuth 2.0', level: 0.78),
        SkillItem(name: 'WebSockets', level: 0.70),
      ],
    ),
    SkillModel(
      category: 'State Management',
      icon: Icons.sync_alt,
      skills: [
        SkillItem(name: 'Provider', level: 0.90),
        SkillItem(name: 'Riverpod', level: 0.85),
        SkillItem(name: 'BLoC / Cubit', level: 0.82),
        SkillItem(name: 'GetX', level: 0.80),
      ],
    ),
    SkillModel(
      category: 'UI/UX Design',
      icon: Icons.design_services,
      skills: [
        SkillItem(name: 'Figma', level: 0.75),
        SkillItem(name: 'Responsive Design', level: 0.92),
        SkillItem(name: 'Animations', level: 0.88),
        SkillItem(name: 'Material Design', level: 0.95),
      ],
    ),
    SkillModel(
      category: 'Git & DevOps',
      icon: Icons.code,
      skills: [
        SkillItem(name: 'Git / GitHub', level: 0.90),
        SkillItem(name: 'CI/CD', level: 0.70),
        SkillItem(name: 'Play Store Deploy', level: 0.85),
        SkillItem(name: 'App Store Deploy', level: 0.75),
      ],
    ),
  ];

  static const List<ExperienceModel> experience = [
    ExperienceModel(
      company: 'AKODES IT Solution',
      role: 'Senior Flutter Developer',
      period: '2025 – Present',
      description:
          'Leading Flutter development for enterprise mobile applications, mentoring junior developers, and architecting scalable solutions.',
      highlights: [
        'Architected multi-module Flutter applications',
        'Led a team of 3 Flutter developers',
        'Integrated complex REST APIs & real-time features',
        'Improved app performance by 40%',
      ],
    ),
    ExperienceModel(
      company: '7 Skies Solution',
      role: 'Junior Flutter Developer',
      period: '2024 – 2025',
      description:
          'Developed and maintained multiple cross-platform mobile applications using Flutter and Dart, with Firebase integration.',
      highlights: [
        'Built 5+ production Flutter apps',
        'Integrated Firebase Auth, Firestore & Storage',
        'Implemented clean architecture patterns',
        'Contributed to UI/UX design decisions',
      ],
    ),
  ];

  static final List<ProjectModel> projects = [
    const ProjectModel(
      videoPath: 'assets/videos/stonk.mp4',
      title: 'Stonkit',
      description:
          'Stonkit is a real-time stock information and analytics app that helps users explore and understand financial market data with ease. It provides instant access to company details such as sector, market capitalization, exchange, asset type, and business descriptions through continuously updated API-driven data. The app features interactive historical price charts, key financial indicators, performance comparisons, dividend insights, and advanced filtering options for smarter market analysis.',
      // description:
      //     'A full-featured shopping app with product catalog, cart management, Stripe payments, and real-time order tracking.',
      technologies: ['Flutter', 'RestAPIs', 'AI Model', 'FL Chart', 'Provider'],
      accentColor: Color(0xFF2979FF),
    ),
    const ProjectModel(
      title: 'AI Nutrition & Diet App',
      description:
          'The AI-Powered Nutrition & Diet Assistant App is a smart mobile application that helps users track meals, monitor nutrition, and achieve health goals through AI-driven automation. Users can log meals by uploading food photos for AI-based calorie and food detection or by manually entering details for accuracy. The app offers personalized meal plans, nutrition analytics, AI recommendations, and community features for sharing recipes and meals,secure real-time data management powered by Firebase.The app creates a complete digital nutrition ecosystem focused on healthier eating and long-term wellness.',
      technologies: ['Flutter', 'Firebase', 'AI Model', 'Provider'],
      accentColor: Color(0xFF08FF00),
      videoPath: 'assets/videos/nut.mp4',
    ),
    // const ProjectModel(
    //   title: 'Social Media App',
    //   description:
    //       'Instagram-like social platform with photo sharing, real-time chat, stories, and content discovery feed.',
    //   technologies: ['Flutter', 'Firebase', 'Cloud Functions', 'BLoC'],
    //   accentColor: Color(0xFF7C4DFF),
    // ),
    // const ProjectModel(
    //   title: 'Finance Tracker',
    //   description:
    //       'Personal finance management app with expense tracking, budget planning, analytics charts, and PDF reports.',
    //   technologies: ['Flutter', 'Hive', 'FL Chart', 'Riverpod'],
    //   accentColor: Color(0xFF00BFA5),
    // ),
    // const ProjectModel(
    //   title: 'Healthcare App',
    //   description:
    //       'Telemedicine platform connecting patients with doctors via video consultation, appointment booking, and prescriptions.',
    //   technologies: ['Flutter', 'Supabase', 'Agora', 'REST API'],
    //   accentColor: Color(0xFFFF6D00),
    // ),
    // const ProjectModel(
    //   title: 'Task Manager Pro',
    //   description:
    //       'Collaborative project management app with Kanban boards, team assignments, deadline reminders, and progress analytics.',
    //   technologies: ['Flutter', 'Firebase', 'GetX', 'Notifications'],
    //   accentColor: Color(0xFFE91E63),
    // ),
  ];
}
