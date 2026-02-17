import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  bool _isMusicEnabled = true;
  bool _isSfxEnabled = true;
  double _musicVolume = 0.7;
  double _sfxVolume = 1.0;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isSfxEnabled => _isSfxEnabled;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  Future<void> initialize() async {
    try {
      await FlameAudio.audioCache.loadAll([
        'music/background_music.mp3',
        'sfx/collect.mp3',
        'sfx/explosion.mp3',
        'sfx/jump.mp3',
      ]);
      print('Audio initialized successfully');
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  void playbackgroundMusic() {
    if (_isMusicEnabled) {
      try {
        FlameAudio.bgm.play('music/background_music.mp3', volume: _musicVolume);
      } catch (e) {
        print('Error playing background music: $e');
      }
    }
  }

  void stopBackgroundMusic() {
    try {
      FlameAudio.bgm.stop();
    } catch (e) {
      print('Error stopping background music: $e');
    }
  }

  void pauseBackgroundMusic() {
    try {
      FlameAudio.bgm.pause();
    } catch (e) {
      print('Error pausing background music: $e');
    }
  }

  void resumeBackgroundMusic() {
    try {
      FlameAudio.bgm.resume();
    } catch (e) {
      print('Error resuming background music: $e');
    }
  }

  void playSfx(String sfxName) {
    if (_isSfxEnabled) {
      try {
        FlameAudio.play('sfx/$sfxName.mp3', volume: _sfxVolume);
      } catch (e) {
        print('Error playing sound effect "$sfxName": $e');
      }
    }
  }

  void playSfxWithVolume(String fileName, double volume) {
    if (_isSfxEnabled) {
      try {
        FlameAudio.play('sfx/$fileName.mp3', volume: volume.clamp(0.0, 1.0));
      } catch (e) {
        print('Error playing sound effect "$fileName" with volume: $e');
      }
    }
  }

  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    try {
      FlameAudio.bgm.audioPlayer.setVolume(_musicVolume);
    } catch (e) {
      print('Error setting background music volume: $e');
    }
  }

  void setSfxVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
  }

  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    if (!_isMusicEnabled) {
      stopBackgroundMusic();
    }
  }

  void toggleSfx() {
    _isSfxEnabled = !_isSfxEnabled;
  }

  void enableMusic() {
    _isMusicEnabled = true;
    resumeBackgroundMusic();
  }

  void disableMusic() {
    _isMusicEnabled = false;
    pauseBackgroundMusic();
  }

  void enableSfx() {
    _isSfxEnabled = true;
  }

  void disableSfx() {
    _isSfxEnabled = false;
  }

  void dispose() {
    try {
      FlameAudio.bgm.stop();
    } catch (e) {
      print('Error disposing audio: $e');
    }
  }
}
