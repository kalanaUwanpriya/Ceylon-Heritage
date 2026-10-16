import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// Centralized audio service for Ceylon Heritage audio guides.
///
/// Ensures:
/// - Single active AudioPlayer across the app (no overlapping audio)
/// - Correct mapping to local MP3 assets
/// - Robust play/pause/resume/seek handling
/// - Safe lifecycle handling (stops when leaving page or switching destination)
class AudioGuideService {
  AudioGuideService._internal() {
    _initPlayer();
  }

  static final AudioGuideService _instance = AudioGuideService._internal();
  static AudioGuideService get instance => _instance;

  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _playerStateSubscription;

  String? _currentAssetPath;
  String? _currentDestination;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isActionLocked = false;

  /// Required Audio Mapping according to specification
  static const Map<String, String> destinationAudioMap = {
    'anuradhapura': 'assets/Sound/Anuradhapura.mp3',
    'dambulla': 'assets/Sound/Dambulla.mp3',
    'down south': 'assets/Sound/DownSouth.mp3',
    'jaffna': 'assets/Sound/Jaffna.mp3',
    'kandy': 'assets/Sound/Kandy.mp3',
    'polonnaruwa': 'assets/Sound/Pollonnaruwa.mp3',
  };

  /// Returns the asset path for a destination, or null if unmapped.
  static String? getAudioPathForDestination(String destinationName) {
    return destinationAudioMap[destinationName.trim().toLowerCase()];
  }

  void _initPlayer() {
    // Listen for completion to automatically reset position and stop
    _playerStateSubscription = _player.playerStateStream.listen(
      (state) {
        if (state.processingState == ProcessingState.completed) {
          _onPlaybackCompleted();
        }
      },
      onError: (err) {
        debugPrint('AudioGuideService playerStateStream error: $err');
        _errorMessage = 'Playback error: $err';
      },
    );
  }

  void _onPlaybackCompleted() {
    // When audio finishes, pause and rewind to start
    _player.pause().catchError((e) {});
    _player.seek(Duration.zero).catchError((e) {});
  }

  // Getters
  AudioPlayer get player => _player;
  String? get currentAssetPath => _currentAssetPath;
  String? get currentDestination => _currentDestination;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  Duration get position => _player.position;
  Duration? get duration => _player.duration;
  bool get isPlaying => _player.playing;

  /// Prepares audio for [destinationName] without starting playback.
  /// If [autoPlay] is true, starts playback immediately upon loading.
  Future<void> prepareAudio(
    String destinationName, {
    bool autoPlay = false,
  }) async {
    final assetPath = getAudioPathForDestination(destinationName);
    if (assetPath == null) {
      _errorMessage = 'Audio guide not found for $destinationName';
      return;
    }

    // If the same asset is already loaded and ready
    if (_currentAssetPath == assetPath && _player.audioSource != null) {
      if (autoPlay && !_player.playing) {
        await play();
      }
      return;
    }

    if (_isActionLocked) return;
    _isActionLocked = true;
    _isLoading = true;
    _errorMessage = null;

    try {
      // Stop any existing playback first to avoid simultaneous audio
      if (_player.playing) {
        await _player.stop();
      }

      _currentAssetPath = assetPath;
      _currentDestination = destinationName;

      await _player.setAsset(assetPath);
      _isLoading = false;

      if (autoPlay) {
        await play();
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Unable to load audio guide: $e';
      debugPrint('AudioGuideService prepareAudio error: $e');
    } finally {
      _isActionLocked = false;
    }
  }

  /// Toggle play / pause safely for [destinationName]
  Future<void> togglePlayPause(String destinationName) async {
    if (_isActionLocked) return;

    final assetPath = getAudioPathForDestination(destinationName);
    if (assetPath == null) {
      _errorMessage = 'Audio guide not found for $destinationName';
      return;
    }

    // If different destination or not loaded yet, prepare and play
    if (_currentAssetPath != assetPath || _player.audioSource == null) {
      await prepareAudio(destinationName, autoPlay: true);
      return;
    }

    _isActionLocked = true;
    try {
      if (_player.playing) {
        await pause();
      } else {
        // If completed or at end, seek to 0 before starting
        if (_player.processingState == ProcessingState.completed ||
            (_player.duration != null &&
                _player.position >= _player.duration!)) {
          await _player.seek(Duration.zero);
        }
        await play();
      }
    } catch (e) {
      debugPrint('AudioGuideService togglePlayPause error: $e');
      _errorMessage = 'Playback error: $e';
    } finally {
      _isActionLocked = false;
    }
  }

  Future<void> play() async {
    try {
      _errorMessage = null;
      if (_player.processingState == ProcessingState.completed) {
        await _player.seek(Duration.zero);
      }
      await _player.play();
    } catch (e) {
      _errorMessage = 'Playback error: $e';
      debugPrint('AudioGuideService play error: $e');
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('AudioGuideService pause error: $e');
    }
  }

  Future<void> seek(Duration targetPosition) async {
    try {
      await _player.seek(targetPosition);
    } catch (e) {
      debugPrint('AudioGuideService seek error: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
      await _player.seek(Duration.zero);
    } catch (e) {
      debugPrint('AudioGuideService stop error: $e');
    }
  }

  /// Stops audio if the leaving page corresponds to the currently active audio.
  Future<void> stopIfLeaving(String destinationName) async {
    if (_currentDestination != null &&
        _currentDestination!.trim().toLowerCase() ==
            destinationName.trim().toLowerCase()) {
      await stop();
    }
  }

  void dispose() {
    _playerStateSubscription?.cancel();
    _player.dispose();
  }
}
