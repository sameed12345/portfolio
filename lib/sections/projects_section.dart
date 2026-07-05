import 'dart:async';

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
    final isMobile = Responsive.isMobile(context);
    final size = MediaQuery.of(context).size;

    // Responsive dialog bounds
    final double dialogWidth = isMobile ? size.width * 0.92 : 850;
    final double dialogHeight = isMobile ? size.height * 0.85 : 550;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isMobile ? 12 : 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: dialogWidth,
          maxHeight: dialogHeight,
        ),
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
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Header
              _buildHeader(context),
              // Content
              Expanded(
                child: isMobile
                    ? _buildMobileContent(context)
                    : _buildDesktopContent(context),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: project.accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.play_circle_rounded,
              color: project.accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title, style: AppTextStyles.titleLarge),
                Text(
                  'Demo Preview',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.textSecondary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Responsive video container constraint
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.42,
              ),
              child: _VideoPlayerWidget(
                path: project.videoPath,
                accentColor: project.accentColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Technologies
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: project.technologies
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: project.accentColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: project.accentColor.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        t,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: project.accentColor,
                          fontSize: 11,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            project.description,
            style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Player Column
          Expanded(
            flex: 2,
            child: Center(
              child: _VideoPlayerWidget(
                path: project.videoPath,
                accentColor: project.accentColor,
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Details Column
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Technologies
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: project.accentColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: project.accentColor.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              t,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: project.accentColor,
                                fontSize: 12,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                // Description (scrollable text area)
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      project.description,
                      style: AppTextStyles.bodyMedium.copyWith(
                        height: 1.6,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////
class _VideoPlayerWidget extends StatefulWidget {
  final String path;
  final Color accentColor;

  const _VideoPlayerWidget({
    required this.path,
    required this.accentColor,
  });

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  Timer? _hideTimer;

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
        _controller.setLooping(true);
      });

    _controller.addListener(_videoListener);
    _startHideTimer();
  }

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    if (_controller.value.isPlaying) {
      _hideTimer = Timer(const Duration(milliseconds: 2500), () {
        if (mounted && _controller.value.isPlaying) {
          setState(() {
            _showControls = false;
          });
        }
      });
    }
  }

  void _toggleControlsVisibility() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _startHideTimer();
      }
    });
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showControls = true;
        _hideTimer?.cancel();
      } else {
        _controller.play();
        _startHideTimer();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      if (_controller.value.volume == 0) {
        _controller.setVolume(1.0);
      } else {
        _controller.setVolume(0.0);
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool showControlsBar = constraints.maxWidth >= 220;

        return MouseRegion(
          onHover: (_) {
            if (!_showControls) {
              setState(() {
                _showControls = true;
              });
            }
            _startHideTimer();
          },
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: _toggleControlsVisibility,
                      child: VideoPlayer(_controller),
                    ),
                    // Dark tint when controls are shown
                    IgnorePointer(
                      ignoring: true,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color:
                            _showControls ? Colors.black38 : Colors.transparent,
                      ),
                    ),
                    // Center play/pause overlay
                    AnimatedOpacity(
                      opacity: _showControls ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: IgnorePointer(
                        ignoring: !_showControls,
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause_circle_filled_rounded
                                : Icons.play_circle_filled_rounded,
                            size: constraints.maxWidth < 180 ? 48 : 64,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          onPressed: _togglePlay,
                        ),
                      ),
                    ),
                    // Bottom control panel bar (above progress indicator)
                    if (showControlsBar)
                      Positioned(
                        bottom: 6,
                        left: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          opacity: _showControls ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: IgnorePointer(
                            ignoring: !_showControls,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                //horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black87,
                                    Colors.black45,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      _controller.value.isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                    ),
                                    color: Colors.white,
                                    iconSize: 20,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: _togglePlay,
                                  ),
                                  // const SizedBox(width: 8),
                                  Text(
                                    '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  // const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Video Progress Indicator (placed at the absolute bottom edge, always visible & interactive)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          playedColor: widget.accentColor,
                          bufferedColor: Colors.white24,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
    // Simple circle fallback for hex pattern
    canvas.drawCircle(center, r * 0.5, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
