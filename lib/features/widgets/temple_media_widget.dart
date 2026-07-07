import 'package:go_router/go_router.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/bajana_audio_service.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yatrify/utils/media_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../screens/responsive.dart';

class TempleMediaWidget<T> extends StatelessWidget {
  const TempleMediaWidget(
      {super.key,
      required this.item,
      required this.title,
      this.showViewAll = false});
  final List<T> item;
  final String title;
  final bool showViewAll;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    final displayCount =
        showViewAll ? (item.length > 3 ? 3 : item.length) : item.length;
    if (item.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.style.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: fontcolor),
              ),
              if (showViewAll && item.length > 3)
                GestureDetector(
                  onTap: () {
                    context.push('/view-bhajans', extra: item);
                  },
                  child: Text(
                    label.viewAll,
                    style: context.style.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        if (title == label.bhajans)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: whiteColor,
             // shadowColor: Colors.black.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                
              ),
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(displayCount, (index) {
                  final media = item[index] as Bhajans;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading:
                            const Icon(Icons.play_circle, color: primaryColor),
                        title: Text(
                          LocaleService.getLocalized(media.name),
                          style: context.style.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: primaryColor,
                           size: 20,
                        ),
                        onTap: () {
                          final url = media.url?.toString() ?? "";

                          if (url.isEmpty) return;

                          if (MediaUtils.isVideoUrl(url)) {
                            showGeneralDialog(
                              context: context,
                              barrierColor: Colors.black.withOpacity(0.4),
                              barrierDismissible: true,
                              barrierLabel: 'Video overlay',
                              transitionDuration:
                                  const Duration(milliseconds: 250),
                              pageBuilder: (context, anim1, anim2) {
                                return VideoOverlayPlayer(videoUrl: url);
                              },
                            );
                            return;
                          }

                          if (MediaUtils.isAudioUrl(url)) {
                            final bhajanList = item.cast<Bhajans>();

                            // context.push(
                            //   '/audio-player',
                            //   extra: {
                            //     'bhajans': bhajanList,
                            //     'index': index,
                            //   },
                            // );
                            context.push('/audio-player');

                            BhajanAudioService.instance.loadPlaylist(
                              bhajans: bhajanList,
                              startIndex: index,
                            );
                          }
                        },
                      ),

                      // Divider except last item
                      // if (index != displayCount - 1) const Divider(height: 1),
                    ],
                  );
                }),
              ),
            ),
          )
        else
          SizedBox(
            height: 128,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: displayCount,
              itemBuilder: (context, index) {
                final media = item[index] as dynamic;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 12, right: index == displayCount - 1 ? 16 : 0),
                  child: GestureDetector(
                    onTap: () {
                      try {
                        final url = media.url?.toString() ?? "";

                        if (url.isEmpty) return;

                        if (MediaUtils.isVideoUrl(url)) {
                          showGeneralDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.4),
                            barrierDismissible: true,
                            barrierLabel: 'Video overlay',
                            transitionDuration:
                                const Duration(milliseconds: 250),
                            pageBuilder: (context, anim1, anim2) {
                              return VideoOverlayPlayer(videoUrl: url);
                            },
                          );
                          return;
                        }

                        // if (MediaUtils.isAudioUrl(url) && media is Bhajans) {
                        //   final bhajanList = item.cast<Bhajans>();

                        //   context.push(
                        //     '/audio-player',
                        //     extra: {
                        //       'bhajans': bhajanList,
                        //       'index': index,
                        //     },
                        //   );
                        // }
                      } catch (e, stackTrace) {
                        FirebaseManager().reportError(e, stackTrace);
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: media.image!,
                            height: getResponsiveImageHeight(context),
                            width: getRsponsiveImageWidth(context),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: getRsponsiveImageWidth(context),
                          child: Text(
                            LocaleService.getLocalized(media.name!),
                            style: context.style.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class VideoOverlayPlayer extends StatefulWidget {
  final String videoUrl;
  const VideoOverlayPlayer({super.key, required this.videoUrl});

  @override
  State<VideoOverlayPlayer> createState() => _VideoOverlayPlayerState();
}

class _VideoOverlayPlayerState extends State<VideoOverlayPlayer> {
  late YoutubePlayerController _controller;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.transparent),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isExpanded ? screen.width : screen.width * 0.9,
            height: isExpanded ? screen.height * 0.8 : 400,
            child: Material(
              color: Colors.black,
              borderRadius:
                  isExpanded ? BorderRadius.zero : BorderRadius.circular(16),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    aspectRatio: 9 / 16,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                        isExpanded ? Icons.fullscreen_exit : Icons.fullscreen,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: toggleExpand,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
