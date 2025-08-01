import 'package:bookstay/core/models/pg.dart';
import 'package:bookstay/features/widgets/bottom_curve_clipper.dart';
import 'package:bookstay/features/widgets/custom_marquee.dart';
import 'package:bookstay/features/widgets/gender_badge.dart';
import 'package:bookstay/features/widgets/pg_image_carousel.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../constant/const_string.dart';
import 'facilities_badge.dart';

class PgMobileCard extends StatelessWidget {
  const PgMobileCard(
      {super.key, required this.pgDetails, this.isCompact = false});

  final PgDetails pgDetails;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return Card(
      color:  whiteColor,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          PgImageCarousel(
            images:
                (isCompact) ? [pgDetails.roomImage.first] : pgDetails.roomImage,
            customClipper: isCompact ? null : BottomCurveClipper(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            showIndicator: isCompact ? false : true,
            height: isCompact ? 200 : 240,
            indicatorAlignment: Alignment.bottomLeft,
            topOverlay: GenderBadge(gender: pgDetails.gender),
            bottomOverlay:isCompact || pgDetails.ratings!.isEmpty
                ?null: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: CustomMarquee(rate: pgDetails.ratings!),
                  )
                ,
          ),
          // CarouselSlider.builder(
          //   itemCount: widget.pgDetails.roomImage.length,
          //   options: CarouselOptions(
          //       height: 240,
          //       autoPlay: false,
          //       enlargeCenterPage: true,
          //       viewportFraction: 1.0,
          //       autoPlayInterval: const Duration(seconds: 3),
          //       onPageChanged: (index, reason) {
          //         _currentIndex.value = index;
          //       }),
          //   itemBuilder: (context, index, realIndex) {
          //     return Builder(builder: (BuildContext context) {
          //       final roomImage = widget.pgDetails.roomImage[index];
          //       return ClipRRect(
          //         borderRadius: const BorderRadius.only(
          //             topLeft: Radius.circular(12),
          //             topRight: Radius.circular(12)),
          //         child: SizedBox(
          //           height: 240,
          //           width: double.infinity,
          //           child: Stack(
          //             children: [
          //               ClipPath(
          //                 clipper: BottomCurveClipper(),
          //                 child: Image.network(
          //                   roomImage,
          //                   fit: BoxFit.cover,
          //                   width: double.infinity,
          //                   height: 240,
          //                   errorBuilder: (context, error, stackTrace) {
          //                     return const Center(
          //                       child: Icon(Icons.broken_image,
          //                           size: 48, color: Colors.grey),
          //                     );
          //                   },
          //                 ),
          //               ),
          //               if (widget.pgDetails.ratings!.isNotEmpty)
          //                 Positioned(
          //                   bottom: 0,
          //                   right: 0,
          //                   // left: 170,
          //                   //height: 40,
          //                   width: MediaQuery.of(context).size.width * 0.5,
          //                   child: CustomMarquee(
          //                     rate: widget.pgDetails.ratings.toString(),
          //                   ),
          //                 ),
          //               Positioned(
          //                 bottom: 8,
          //                 left: 12,
          //                 child: ValueListenableBuilder<int>(
          //                   valueListenable: _currentIndex,
          //                   builder: (context, current, _) {
          //                     return Row(
          //                       children: List.generate(
          //                           widget.pgDetails.roomImage.length,
          //                           (i) => Container(
          //                                 width: 6,
          //                                 height: 6,
          //                                 margin: const EdgeInsets.symmetric(
          //                                     horizontal: 2),
          //                                 decoration: BoxDecoration(
          //                                     shape: BoxShape.circle,
          //                                     color: i == current
          //                                         ? primaryColor
          //                                         : whiteColor),
          //                               )),
          //                     );
          //                   },
          //                 ),
          //               ),
          //               Positioned(
          //                   top: 8,
          //                   right: 8,
          //                   child: GenderBadge(
          //                     gender: widget.pgDetails.gender,
          //                   ))
          //             ],
          //           ),
          //         ),
          //       );
          //     });
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        pgDetails.address.first.pgName,
                        style: context.style.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(label.startsFrom)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pgDetails.address.first.roadName),
                    Text(
                      '${ConstString.rupees}${pgDetails.priceDetails.formatedLowestPrice}',
                      style: context.style.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (!isCompact && pgDetails.facilities != null &&
                    pgDetails.facilities!.isNotEmpty) ...[
                  const SizedBox(
                    height: 16,
                  ),
                  FacilitiesBadge(facilities: pgDetails.facilities!)
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
