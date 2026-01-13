import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../screens/responsive.dart';

class TempleMediaWidget<T> extends StatelessWidget {
  const TempleMediaWidget({super.key, required this.item, required this.title});
  final List<T> item;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (item.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: context.style.titleMedium!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 20, color: fontcolor),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 128,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: item.length,
            itemBuilder: (context, index) {
              final media = item[index] as dynamic;
              return Padding(
                padding: EdgeInsets.only(
                    left: 12, right: index == item.length - 1 ? 16 : 0),
                child: GestureDetector(
                  onTap: () {
                    // if(media.url.toString().isNotEmpty){
                    //   context.push('/video-player',extra: media.url);
                    // }

                    try {
                      if (media.url.toString().isNotEmpty) {
                        showGeneralDialog(
                          context: context,
                          barrierColor: Colors.black.withOpacity(0.4),
                          barrierDismissible: true,
                          barrierLabel: 'Video overlay', // ✅ Add this line
                          transitionDuration: const Duration(milliseconds: 250),
                          pageBuilder: (context, anim1, anim2) {
                            return VideoOverlayPlayer(videoUrl: media.url);
                          },
                        );
                        FirebaseManager().logEvent(
                          FirebaseEvent.videoClick,
                          parameters: {
                            'video_name':
                                LocaleService.getLocalized(media.name),
                          },
                        );
                      }
                    } catch (e, stackTrace) {
                      FirebaseManager().reportError(
                        e,
                        stackTrace,
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // SizedBox(
        //   height: 128,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: item.length,
        //     itemBuilder: (context, index) {
        //       final media = item[index] as dynamic;
        //       return Padding(
        //         padding:  EdgeInsets.only(left: 12, right: index == item.length - 1 ? 16 : 0),
        //         child: GestureDetector(
        //           onTap: (){
        //             if(media.url.toString().isNotEmpty){
        //               context.push('/video-player',extra: media.url);
        //             }

        //           },
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               ClipRRect(
        //                 borderRadius: BorderRadius.circular(10),
        //                 child: CachedNetworkImage(
        //                   imageUrl: media.image!,
        //                   height: getResponsiveImageHeight(context),
        //                   width: getRsponsiveImageWidth(context),
        //                   fit: BoxFit.cover,
        //                   errorWidget: (context, url, error) => const Icon(Icons.error, color: primaryColor,),
        //                 ),
        //               ),
        //               const SizedBox(
        //                 height: 8,
        //               ),
        //               SizedBox(
        //                 width: getRsponsiveImageWidth(context),
        //                 child: Text(
        //                   '${media.name!}',
        //                   style: context.style.titleSmall,
        //                   maxLines: 2,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
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
          // Dismiss background tap
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.transparent),
          ),

          // Animated video container
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
                    aspectRatio: 9 / 16, // 🔹 Keeps it vertical
                  ),

                  // Close button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Expand button
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
