import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:yatrify/core/services/bajana_audio_service.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final player = BhajanAudioService.instance.player;

    return ValueListenableBuilder<bool>(
      valueListenable: BhajanAudioService.instance.showMiniPlayer,
      builder: (context, visible, _) {
        if (!visible) return const SizedBox.shrink();

        return StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state == null ||
                state.currentSource == null ||
                state.sequence.isEmpty) {
              return const SizedBox.shrink();
            }

            final mediaItem = state.currentSource!.tag as MediaItem;

            return _MiniPlayerContent(
              mediaItem: mediaItem,
              player: player,
            );
          },
        );
      },
    );
  }
}

class _MiniPlayerContent extends StatelessWidget {
  final MediaItem mediaItem;
  final AudioPlayer player;

  const _MiniPlayerContent({
    required this.mediaItem,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) async {
        final velocity = details.primaryVelocity ?? 0;

        // Swipe down → close
        if (velocity > 300) {
          await BhajanAudioService.instance.stopAndClear();
        }

        // Swipe up → open full player
        if (velocity < -300) {
          context.push('/audio-player');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        height: 70,
        padding: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
            )
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ListTile(
                onTap: () {
                  context.push('/audio-player');
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    mediaItem.artUri.toString(),
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  LocaleService.getLocalized(
                    Map<String, String>.from(
                        mediaItem.extras?['nameMap'] ?? {}),
                  ),
                  style: context.style.titleSmall!.copyWith(color: whiteColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<PlayerState>(
                      stream: player.playerStateStream,
                      builder: (context, snapshot) {
                        final playing = snapshot.data?.playing ?? false;

                        return IconButton(
                          icon: Icon(
                            playing ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 26,
                          ),
                          onPressed: () {
                            playing ? player.pause() : player.play();
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () async {
                        await BhajanAudioService.instance.stopAndClear();
                      },
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<Duration>(
              stream: player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final total = player.duration ?? Duration.zero;

                final progress = total.inMilliseconds == 0
                    ? 0.0
                    : position.inMilliseconds / total.inMilliseconds;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4,),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(8),
                    child: SizedBox(
                      width: double.infinity,
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 2,
                        backgroundColor: Colors.white30,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(whiteColor),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
