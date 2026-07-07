import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class BhajanAudioService {
  BhajanAudioService._() {
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        showMiniPlayer.value = false;
      }
    });
  }

  static final BhajanAudioService instance = BhajanAudioService._();

  final AudioPlayer player = AudioPlayer();

  final ValueNotifier<bool> showMiniPlayer = ValueNotifier(false);

  Future<void> loadPlaylist({
    required List<dynamic> bhajans,
    required int startIndex,
  }) async {
    if (bhajans.isEmpty) return;

    showMiniPlayer.value = true;

    final playlist = ConcatenatingAudioSource(
      children: bhajans.map((e) {
              return LockCachingAudioSource(
          Uri.parse(e.url),
          tag: MediaItem(
            //id: e.id?.toString() ?? e.url,
            id: e.url,
            album: "Bhajans",
            title: e.name?['en'] ?? "Bhajan",
           // artist: "Yatrify",
            artUri: Uri.parse(e.image),
            extras: {
              "nameMap": e.name,
            },
          ),
        );
      }).toList(),
    
    );
    

    await player.setAudioSource(
      playlist,
      initialIndex: startIndex,
    );

    await player.play();
  }

  Future<void> stopAndClear() async {
    await player.pause(); // stops playback
    showMiniPlayer.value = false; // hides mini player
  }
}
