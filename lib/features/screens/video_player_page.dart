import 'package:bookstay/features/widgets/redirect_widget.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerPage({super.key, required this.videoUrl});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

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

  Future<bool> _waitForRedirect() async {
    await Future.delayed(const Duration(seconds: 2));
    return true; // after 2s, signal ready
  }

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return FutureBuilder<bool>(
      future: _waitForRedirect(),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState != ConnectionState.done;

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: isLoading ? Colors.white : Colors.black,
            foregroundColor: isLoading ? Colors.black : Colors.white,
            elevation: 0,
          ),
          body: isLoading
              ? RedirectWidget(icon: Icons.video_library, title: label.openingBrowser, subtitle: label.redirectingToVideo,)
              : YoutubePlayerBuilder(
                  player: YoutubePlayer(controller: _controller),
                  builder: (context, player) => Center(child: player),
                ),
        );
      },
    );
  }
}
