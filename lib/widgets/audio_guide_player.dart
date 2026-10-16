import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../services/audio_guide_service.dart';

/// Reusable Audio Guide Player matching the exact CEYLON Heritage design.
///
/// Features:
/// - Real-time playback position & actual audio duration
/// - Functional Play / Pause / Resume
/// - Interactive seek bar (tap or drag)
/// - Auto-completion handling
/// - Safe lifecycle handling (stops on page exit)
class AudioGuidePlayer extends StatefulWidget {
  final String destinationName;

  const AudioGuidePlayer({super.key, required this.destinationName});

  @override
  State<AudioGuidePlayer> createState() => _AudioGuidePlayerState();
}

class _AudioGuidePlayerState extends State<AudioGuidePlayer> {
  static const Color backgroundColor = Color(0xFFF6EADA);
  static const Color darkGreen = Color(0xFF17452F);
  static const Color cardColor = Color(0xFFF0DDC3);
  static const Color accentColor = Color(0xFF9F5625);
  static const Color greyText = Color(0xFF5F625D);
  static const Color borderColor = Color(0xFFE1D2BD);
  static const Color trackColor = Color(0xFFD4C5B0);

  final AudioGuideService _audioService = AudioGuideService.instance;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  Duration _currentPosition = Duration.zero;
  Duration? _totalDuration;
  bool _isPlaying = false;
  bool _isLoading = false;

  // Local drag state for interactive seeking
  bool _isDragging = false;
  double _dragFraction = 0.0;

  @override
  void initState() {
    super.initState();
    _setupAudio();
  }

  void _setupAudio() {
    // If the active destination matches, grab initial values
    if (_audioService.currentDestination?.trim().toLowerCase() ==
        widget.destinationName.trim().toLowerCase()) {
      _currentPosition = _audioService.position;
      _totalDuration = _audioService.duration;
      _isPlaying = _audioService.isPlaying;
    }

    // Subscribe to playback position updates
    _positionSubscription = _audioService.positionStream.listen((pos) {
      if (!mounted) return;
      if (_isCurrentDestination()) {
        setState(() {
          _currentPosition = pos;
        });
      }
    });

    // Subscribe to total duration updates
    _durationSubscription = _audioService.durationStream.listen((dur) {
      if (!mounted) return;
      if (_isCurrentDestination()) {
        setState(() {
          _totalDuration = dur;
        });
      }
    });

    // Subscribe to player state (playing, buffering, completed)
    _playerStateSubscription = _audioService.playerStateStream.listen((state) {
      if (!mounted) return;
      if (_isCurrentDestination()) {
        setState(() {
          _isPlaying = state.playing;
          _isLoading =
              state.processingState == ProcessingState.buffering ||
              state.processingState == ProcessingState.loading;
        });
      } else {
        if (_isPlaying) {
          setState(() {
            _isPlaying = false;
          });
        }
      }
    });

    // Preload audio metadata (duration) in background without auto-playing
    _audioService.prepareAudio(widget.destinationName, autoPlay: false).then((
      _,
    ) {
      if (mounted && _isCurrentDestination()) {
        setState(() {
          _totalDuration = _audioService.duration;
        });
      }
    });
  }

  bool _isCurrentDestination() {
    return _audioService.currentDestination?.trim().toLowerCase() ==
        widget.destinationName.trim().toLowerCase();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();

    // Prevent background audio playback when leaving this destination page
    _audioService.stopIfLeaving(widget.destinationName);

    super.dispose();
  }

  String _formatDuration(Duration? duration) {
    if (duration == null || duration < Duration.zero) {
      return '0:00';
    }
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _handlePlayPause() async {
    await _audioService.togglePlayPause(widget.destinationName);
    if (!mounted) return;

    if (_audioService.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_audioService.errorMessage!),
          backgroundColor: accentColor,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _seekToFraction(double fraction) {
    final effectiveDuration = _totalDuration ?? Duration.zero;
    if (effectiveDuration > Duration.zero) {
      final targetMs =
          (effectiveDuration.inMilliseconds * fraction.clamp(0.0, 1.0)).round();
      final target = Duration(milliseconds: targetMs);
      setState(() {
        _currentPosition = target;
      });
      _audioService.seek(target);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNarratedByBandara =
        widget.destinationName.trim().toLowerCase() == 'anuradhapura' ||
        widget.destinationName.trim().toLowerCase() == 'dambulla';

    final effectiveDuration = _totalDuration;
    final effectivePosition = _isDragging
        ? Duration(
            milliseconds:
                ((effectiveDuration?.inMilliseconds ?? 0) * _dragFraction)
                    .round(),
          )
        : _currentPosition;

    final progressFraction =
        (effectiveDuration != null && effectiveDuration.inMilliseconds > 0)
        ? (effectivePosition.inMilliseconds / effectiveDuration.inMilliseconds)
              .clamp(0.0, 1.0)
        : 0.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.headphones_outlined,
                  color: darkGreen,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Audio Guide',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isNarratedByBandara
                          ? 'Narrated by Dr. Sensaka Bandara'
                          : 'Narrated by Heritage Walks',
                      style: GoogleFonts.inter(fontSize: 11, color: greyText),
                    ),
                  ],
                ),
              ),
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: darkGreen,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  key: const Key('audio_guide_play_button'),
                  padding: EdgeInsets.zero,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: backgroundColor,
                          ),
                        )
                      : Icon(
                          _isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: backgroundColor,
                          size: 28,
                        ),
                  onPressed: _handlePlayPause,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                _formatDuration(effectivePosition),
                style: GoogleFonts.inter(fontSize: 9, color: greyText),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final totalWidth = constraints.maxWidth;
                    final fillWidth = (totalWidth * progressFraction).clamp(
                      0.0,
                      totalWidth,
                    );

                    return GestureDetector(
                      key: const Key('audio_guide_seek_bar'),
                      behavior: HitTestBehavior.opaque,
                      onTapDown: (details) {
                        if (totalWidth > 0) {
                          final fraction =
                              (details.localPosition.dx / totalWidth).clamp(
                                0.0,
                                1.0,
                              );
                          _seekToFraction(fraction);
                        }
                      },
                      onHorizontalDragStart: (details) {
                        setState(() {
                          _isDragging = true;
                          _dragFraction =
                              (details.localPosition.dx / totalWidth).clamp(
                                0.0,
                                1.0,
                              );
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        if (totalWidth > 0) {
                          setState(() {
                            _dragFraction =
                                (details.localPosition.dx / totalWidth).clamp(
                                  0.0,
                                  1.0,
                                );
                          });
                        }
                      },
                      onHorizontalDragEnd: (details) {
                        _seekToFraction(_dragFraction);
                        setState(() {
                          _isDragging = false;
                        });
                      },
                      onHorizontalDragCancel: () {
                        setState(() {
                          _isDragging = false;
                        });
                      },
                      child: Container(
                        height:
                            20, // Comfortable touch area while keeping 3px bar
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              height: 3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: trackColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Container(
                              width: fillWidth,
                              height: 3,
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Text(
                effectiveDuration != null
                    ? _formatDuration(effectiveDuration)
                    : '0:00',
                style: GoogleFonts.inter(fontSize: 9, color: greyText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
