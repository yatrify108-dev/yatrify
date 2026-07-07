import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yatrify/core/services/bajana_audio_service.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final _audioPlayer = BhajanAudioService.instance.player;

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, buffered, duration) => PositionData(
          position,
          buffered,
          duration ?? Duration.zero,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(label.bhajans),
        backgroundColor: Colors.transparent,
        foregroundColor: whiteColor,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF144771), Color(0xFF071A2C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// CURRENT SONG UI
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;

                if (state == null ||
                    state.currentSource == null ||
                    state.sequence.isEmpty) {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(
                        "No Bhajan Playing",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }

                final mediaItem = state.currentSource!.tag as MediaItem;

                final nameMap =
                    (mediaItem.extras?['nameMap'] as Map?)?.cast<String, String>();

                final displayTitle = nameMap != null
                    ? LocaleService.getLocalized(nameMap)
                    : mediaItem.title;

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: mediaItem.artUri.toString(),
                        height: 280,
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      displayTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            /// PROGRESS BAR
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null || data.duration == Duration.zero) {
                  //return const LinearProgressIndicator();
                                    return Column(
                    children: [
                      const LinearProgressIndicator(),
                      const SizedBox(height: 8),
                      Text(
                        label.loadingAudio,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  );
                }

                return ProgressBar(
                  progress: data.position,
                  buffered: data.bufferedPosition,
                  total: data.duration,
                  onSeek: _audioPlayer.seek,
                  baseBarColor: Colors.white24,
                  progressBarColor: Colors.white,
                  thumbColor: Colors.white,
                  timeLabelTextStyle:
                      const TextStyle(color: Colors.white),
                );
              },
            ),

            const SizedBox(height: 20),

            /// CONTROLS
            StreamBuilder<PlayerState>(
              stream: _audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playing = snapshot.data?.playing ?? false;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 60,
                      color: Colors.white,
                      icon: const Icon(Icons.skip_previous),
                      onPressed: _audioPlayer.seekToPrevious,
                    ),
                    IconButton(
                      iconSize: 80,
                      color: Colors.white,
                      icon: Icon(
                        playing ? Icons.pause_circle : Icons.play_circle,
                      ),
                      onPressed: () {
                        playing
                            ? _audioPlayer.pause()
                            : _audioPlayer.play();
                      },
                    ),
                    IconButton(
                      iconSize: 60,
                      color: Colors.white,
                      icon: const Icon(Icons.skip_next),
                      onPressed: _audioPlayer.seekToNext,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
