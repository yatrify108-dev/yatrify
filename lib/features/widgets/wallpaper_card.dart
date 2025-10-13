import 'package:bookstay/core/models/temple.dart';
import 'package:bookstay/features/screens/responsive.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WallpaperCard extends StatelessWidget {
  const WallpaperCard(
      {super.key, required this.wallpapers, required this.title});

  final List<Wallpapers> wallpapers;
  final String title;

  @override
  Widget build(BuildContext context) {
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
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: wallpapers.length,
            itemBuilder: (context, index) {
              final wallpapersData = wallpapers[index];
              return GestureDetector(
                onTap: () {
                  context.push('/walpaper-page', extra: wallpapersData);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 12, right: index == wallpapers.length - 1 ? 16 : 0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: CachedNetworkImage(
                        imageUrl: wallpapersData.image,
                        height: 160,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: primaryColor,
                        ),
                      ),),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
