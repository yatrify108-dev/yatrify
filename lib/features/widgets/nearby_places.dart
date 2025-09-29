import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/responsive.dart';

class NearByPlacesCard<T> extends StatelessWidget {
  const NearByPlacesCard({super.key, required this.item, required this.title});
  final List<T> item;
  final String title;

// class TempleMediaWidget extends StatelessWidget {
//   const TempleMediaWidget(
//       {super.key,
//       required this.name,
//       required this.title,
//       required this.image,
//       this.url,
//       required this.index,
//       required this.length,});
//   final String name;
//   final String image;
//   final String? url;
//   final String title;
//   final int index;
//   final int length;

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
                padding:  EdgeInsets.only(left: 12, right: index == item.length - 1 ? 16 : 0),
                child: GestureDetector(
                  onTap: (){
                   context.push('/nearby-places-view',extra: media);

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: media.images.first!,
                          height: getResponsiveImageHeight(context),
                          width: getRsponsiveImageWidth(context),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Icon(Icons.error, color: primaryColor,),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: getRsponsiveImageWidth(context),
                        child: Text(
                          '${media.name!}',
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
