import 'package:yatrify/core/models/home_stay.dart';
import 'package:yatrify/features/widgets/availability_badge.dart';
import 'package:yatrify/features/widgets/bottom_curve_clipper.dart';
import 'package:yatrify/features/widgets/custom_marquee.dart';
import 'package:yatrify/features/widgets/pg_image_carousel.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../constant/const_string.dart';
import 'facilities_badge.dart';

class HomeStayMobileCard extends StatelessWidget {
  const HomeStayMobileCard(
      {super.key, required this.homeStayDetails, this.isCompact = false});

  final HomeStayDetails homeStayDetails;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    String formatDistance(double? km) {
      if (km == null) return '';

      final meters = km * 1000;

      if (meters < 1000) {
        return '${meters.round()} m';
      }

      return '${km.toStringAsFixed(1)} km';
    }

    String getAvailabilityText(String status) {
      switch (status) {
        case 'available':
          return 'Available';

        case 'few_left':
          return 'Few Rooms Left';

        case 'unavailable':
          return 'Currently Unavailable';

        default:
          return '';
      }
    }

    return Card(
      color: whiteColor,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HomeStayImageCarousel(
            images: (isCompact)
                ? [homeStayDetails.roomImage.first]
                : homeStayDetails.roomImage,
            customClipper: isCompact ? null : BottomCurveClipper(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            showIndicator: isCompact ? false : true,
            height: isCompact ? 200 : 240,
            indicatorAlignment: Alignment.bottomLeft,
            // topOverlay: GenderBadge(gender: homeStayDetails.gender),
            bottomOverlay:
                isCompact || (homeStayDetails.ratings?.isEmpty ?? true)
                    ? null
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: CustomMarquee(rate: homeStayDetails.ratings!),
                      ),
          ),
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
                        homeStayDetails.address.first.homeStayName,
                        style: context.style.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text("Starts from")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(homeStayDetails.address.first.roadName),
                    Text(
                      '${ConstString.rupees}${homeStayDetails.priceDetails.formatedLowestPrice}',
                      style: context.style.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (!isCompact) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (homeStayDetails.distanceKm != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${formatDistance(homeStayDetails.distanceKm)} from temple',
                              style: context.style.bodySmall,
                            ),
                          ],
                        ),
                      AvailabilityBadge(
                        status: homeStayDetails.availabilityStatus,
                      ),
                    ],
                  ),
                ],
                if (!isCompact &&
                    homeStayDetails.facilities != null &&
                    homeStayDetails.facilities!.isNotEmpty) ...[
                  const SizedBox(
                    height: 16,
                  ),
                  FacilitiesBadge(facilities: homeStayDetails.facilities!)
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
