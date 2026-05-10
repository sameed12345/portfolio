import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/responsive.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = Responsive.horizontalPadding(context);
    final cols = Responsive.projectGridColumns(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 100),
      color: AppColors.bgSecondary,
      child: Column(
        children: [
          const SectionTitle(
            label: 'Projects',
            title: 'My Work',
            subtitle: 'A showcase of Flutter apps I have built',
          ),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - (cols - 1) * 24) / cols;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: PortfolioData.projects
                    .asMap()
                    .entries
                    .map((e) => SizedBox(
                          width: itemWidth,
                          child: _ProjectCard(model: e.value, index: e.key),
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

class _ProjectCard extends StatefulWidget {
  final ProjectModel model;
  final int index;
  const _ProjectCard({required this.model, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  void _showDemoModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => _DemoModal(project: widget.model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showDemoModal(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: _hovered
              ? (Matrix4.identity()..translate(0.0, -6.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered
                  ? widget.model.accentColor.withOpacity(0.6)
                  : AppColors.border,
              width: _hovered ? 1.5 : 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.model.accentColor.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              _buildThumbnail(),
              // Content
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model.title, style: AppTextStyles.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      widget.model.description,
                      style: AppTextStyles.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.model.technologies
                          .map((t) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: widget.model.accentColor
                                      .withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: widget.model.accentColor
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  t,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 11,
                                    color: widget.model.accentColor,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    // Watch Demo button
                    Row(
                      children: [
                        Expanded(
                          child: AnimatedContainer(
                            duration: 200.ms,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              gradient: _hovered
                                  ? LinearGradient(colors: [
                                      widget.model.accentColor,
                                      widget.model.accentColor.withOpacity(0.7),
                                    ])
                                  : null,
                              color: _hovered
                                  ? null
                                  : widget.model.accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    widget.model.accentColor.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_circle_rounded,
                                  color: _hovered
                                      ? Colors.white
                                      : widget.model.accentColor,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'View Demo',
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: _hovered
                                        ? Colors.white
                                        : widget.model.accentColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
            delay: Duration(milliseconds: 200 + widget.index * 100),
            duration: 600.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildThumbnail() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.model.accentColor.withOpacity(0.3),
            AppColors.bgCard,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Pattern
          Positioned.fill(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: CustomPaint(
                painter: _HexPainter(color: widget.model.accentColor),
              ),
            ),
          ),
          // Play button overlay
          Center(
            child: AnimatedContainer(
              duration: 250.ms,
              width: _hovered ? 72 : 60,
              height: _hovered ? 72 : 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.model.accentColor.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: widget.model.accentColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(Icons.play_arrow_rounded,
                  color: Colors.white, size: 32),
            ),
          ),
          // App name label
          Positioned(
            bottom: 12,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.model.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoModal extends StatelessWidget {
  final ProjectModel project;
  const _DemoModal({required this.project});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 560),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: project.accentColor.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: project.accentColor.withOpacity(0.2),
                blurRadius: 40,
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 16, 0),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: project.accentColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.play_circle_rounded,
                          color: project.accentColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(project.title, style: AppTextStyles.titleLarge),
                          Text('Demo Preview',
                              style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: AppColors.textSecondary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Video placeholder
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _VideoPlayerWidget(
                      path: project.videoPath,
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: AppColors.bgPrimary,
              //         borderRadius: BorderRadius.circular(16),
              //         border: Border.all(color: AppColors.border),
              //       ),
              //       child: Center(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Container(
              //               width: 80,
              //               height: 80,
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 gradient: LinearGradient(colors: [
              //                   project.accentColor,
              //                   project.accentColor.withOpacity(0.6),
              //                 ]),
              //               ),
              //               child: const Icon(Icons.play_arrow_rounded,
              //                   color: Colors.white, size: 44),
              //             ),
              //             const SizedBox(height: 20),
              //             Text('Demo Video Coming Soon',
              //                 style: AppTextStyles.titleMedium),
              //             const SizedBox(height: 8),
              //             Text(
              //               'Upload your screen recording to assets/videos/',
              //               style: AppTextStyles.bodyMedium.copyWith(
              //                   color: AppColors.textMuted, fontSize: 13),
              //               textAlign: TextAlign.center,
              //             ),
              //             const SizedBox(height: 24),
              //             Wrap(
              //               spacing: 8,
              //               runSpacing: 8,
              //               alignment: WrapAlignment.center,
              //               children: project.technologies
              //                   .map((t) => Container(
              //                         padding: const EdgeInsets.symmetric(
              //                             horizontal: 12, vertical: 6),
              //                         decoration: BoxDecoration(
              //                           color: project.accentColor
              //                               .withOpacity(0.12),
              //                           borderRadius: BorderRadius.circular(6),
              //                           border: Border.all(
              //                               color: project.accentColor
              //                                   .withOpacity(0.3)),
              //                         ),
              //                         child: Text(t,
              //                             style:
              //                                 AppTextStyles.bodyMedium.copyWith(
              //                               color: project.accentColor,
              //                               fontSize: 12,
              //                             )),
              //                       ))
              //                   .toList(),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Description
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  project.description,
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 300.ms)
            .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
      ),
    );
  }
}

/////////////////////////////////////////////
class _VideoPlayerWidget extends StatefulWidget {
  final String path;

  const _VideoPlayerWidget({
    required this.path,
  });

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.path)
      ..initialize().then((_) {
        setState(() {});
        Future.delayed(
          const Duration(milliseconds: 300),
          () => _controller.play(),
        );
        // _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
        ),
      ],
    );
  }
}

/////////////////////////////////////////
class _HexPainter extends CustomPainter {
  final Color color;
  const _HexPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const r = 28.0;
    const h = r * 0.866;
    double offsetX = 0;
    bool oddRow = false;

    for (double y = 0; y < size.height + r; y += h) {
      offsetX = oddRow ? r * 1.5 : 0;
      for (double x = offsetX; x < size.width + r; x += r * 3) {
        _drawHex(canvas, paint, Offset(x, y), r);
      }
      oddRow = !oddRow;
    }
  }

  void _drawHex(Canvas canvas, Paint paint, Offset center, double r) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * 3.14159 / 180;
      final x = center.dx + r * 0.6 * (angle == 0 ? 1 : (i == 0 ? 1 : 0.866));
      if (i == 0) {
        path.moveTo(center.dx + r * 0.6 * 1, center.dy);
      }
    }
    // Simple circle fallback for hex pattern
    canvas.drawCircle(center, r * 0.5, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
