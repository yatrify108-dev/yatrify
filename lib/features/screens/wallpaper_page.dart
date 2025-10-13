import 'dart:typed_data';
import 'package:bookstay/core/models/temple.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';

class WallpaperPage extends StatelessWidget {
  const WallpaperPage({super.key, required this.wallpapers});
  final Wallpapers wallpapers;

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
      }finally{
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
              imageUrl: wallpapers.image,
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
                      final text =
                          '${wallpapers.shareTitle}\n ${wallpapers.shareDescription} \n ${wallpapers.image}';
                      final params = ShareParams(
                        text: text,
                        title: wallpapers.shareTitle,
                      );
                      await SharePlus.instance.share(params);
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
                        onPressed:() async {
                         if(!downloading){
                           downloadImage(wallpapers.image, wallpapers.shareTitle);
                         }
                        },
                        label: Text(downloading ? 'Downloading...':label.download),
                        icon: downloading ?const  SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: primaryColor,
                          ),
                        ):const Icon(
                          Icons.file_download_outlined,
                          color: primaryColor,
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
