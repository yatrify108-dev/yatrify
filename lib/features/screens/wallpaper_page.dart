import 'dart:typed_data';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';

import '../firebase_manager/firebase_manager.dart';

class WallpaperPage extends StatefulWidget {
  const WallpaperPage({super.key, required this.wallpapers});
  final Wallpapers wallpapers;

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  @override
  void initState() {
    super.initState();
    FirebaseManager().setCurrentScreen('LandedOnWallpaperViewScreen');
  }

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    final isDownloading = ValueNotifier(false);

    Future<void> downloadImage(String url, String fileName) async {
      isDownloading.value = true;
      try {
        final status = await Permission.photos.request();
        final storageStatus = await Permission.storage.request();

        if (status.isGranted || storageStatus.isGranted) {
          final response = await Dio().get(
            url,
            options: Options(responseType: ResponseType.bytes),
          );
          final bytes = Uint8List.fromList(response.data);

          await PhotoManager.editor.saveImage(
            bytes,
            filename: "${fileName.replaceAll(' ', '_')}.jpg",
          );

          showTopMessage(context, 'Wallpaper downloaded successfully!',
              type: MessageType.success);
        } else {
          showTopMessage(context, "Permission denied!",
              type: MessageType.error);
        }
      } catch (e) {
        showTopMessage(context, "Error saving image: $e",
            type: MessageType.error);
      } finally {
        isDownloading.value = false;
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.wallpapers.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error, color: Colors.red, size: 50),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              style: IconButton.styleFrom(
                  backgroundColor: Colors.black54, shape: const CircleBorder()),
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 16,
            left: 16,
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: whiteColor,
                      foregroundColor: primaryColor,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      try {
                        final text =
                            '${widget.wallpapers.shareTitle}\n ${widget.wallpapers.shareDescription} \n ${widget.wallpapers.image}';
                        final params = ShareParams(
                          text: text,
                          title: widget.wallpapers.shareTitle,
                        );
                        await SharePlus.instance.share(params);
                        FirebaseManager().logEvent(FirebaseEvent.buttonClick,
                            parameters: {'button_name': 'wallpaper_share'});
                      } catch (e, stackTrace) {
                        FirebaseManager().reportError(
                          e,
                          stackTrace,
                        );
                      }
                    },
                    label: Text(label.share),
                    icon: const Icon(
                      Icons.share,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                      valueListenable: isDownloading,
                      builder: (context, downloading, child) {
                        return TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: whiteColor,
                            foregroundColor: primaryColor,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              if (!downloading) {
                                downloadImage(widget.wallpapers.image,
                                    widget.wallpapers.shareTitle);
                                FirebaseManager().logEvent(
                                  FirebaseEvent.buttonClick,
                                  parameters: {
                                    'button_name': 'wallpaper_download'
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
                          label: Text(
                              downloading ? 'Downloading...' : label.download),
                          icon: downloading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: primaryColor,
                                  ),
                                )
                              : const Icon(
                                  Icons.file_download_outlined,
                                  color: primaryColor,
                                ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
