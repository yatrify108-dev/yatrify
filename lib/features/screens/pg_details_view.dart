import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:yatrify/core/models/home_stay.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/features/widgets/app_button.dart';
import 'package:yatrify/features/widgets/availability_badge.dart';
import 'package:yatrify/features/widgets/custom_conatiner.dart';
import 'package:yatrify/features/widgets/facilities_badge.dart';
import 'package:yatrify/features/widgets/gender_badge.dart';
import 'package:yatrify/features/widgets/pg_image_carousel.dart';
import 'package:yatrify/features/widgets/pg_mobile_card.dart';
import 'package:yatrify/features/widgets/rating_badge.dart';
import 'package:yatrify/features/screens/responsive.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/google_direction_badge.dart';
import '../widgets/hover_to_expand.dart';
import '../widgets/pricing_badge.dart';
import 'package:readmore/readmore.dart';

class HomeStayDetailsView extends StatelessWidget {
  const HomeStayDetailsView({super.key, required this.homeStayDetails});

  final HomeStayDetails homeStayDetails;

  @override
  Widget build(BuildContext context) {
    bool isUnavailable = homeStayDetails.availabilityStatus == 'unavailable';

    void _shareHomeStay(BuildContext context) async {
      final address = homeStayDetails.address.first;

      final String homeStayName = address.homeStayName;
      final String roadName = address.roadName;

      String priceText = '';

      if (homeStayDetails.priceDetails != null &&
          homeStayDetails.priceDetails.isNotEmpty) {
        final firstPrice = homeStayDetails.priceDetails.first;
        priceText = '🏷️ Price: ₹${firstPrice.price}\n';
      }

      final String playStoreLink = Platform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=com.yatrify.store'
          : 'https://apps.apple.com/app/idYOUR_APP_ID';

      final String shareText = '''
🏠 $homeStayName

📍 Location: $roadName
$priceText
🔎 Discover this stay on Yatrify:
$playStoreLink

✨ Find and book more amazing stays on Yatrify!
''';

      final params = ShareParams(
        text: shareText,
        subject: 'Check out $homeStayName on Yatrify',
      );

      await SharePlus.instance.share(params);
    }

    String buttonText;
    if (homeStayDetails.availabilityStatus == 'few_left') {
      buttonText = 'Call Owner (Few Rooms Left)';
    } else if (isUnavailable) {
      buttonText = 'Currently Unavailable';
    } else {
      buttonText = 'Call Owner';
    }
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text(
          homeStayDetails.address.first.homeStayName,
          style: context.style.titleMedium!.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _shareHomeStay(context);
            },
            icon: const Icon(
              Icons.share,
              size: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isUnavailable
          ? const SizedBox.shrink()
          : _buildBottomBar(context, buttonText, isUnavailable),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getResponsiveHorizontalPadding(context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT SIDE: Main content
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  _buildPgImages(context),
                  _buildPgAddressInfo(context),
                  const SizedBox(
                    height: 8,
                  ),
                  Divider(
                    color: context.scheme.outlineVariant.withOpacity(0.2),
                    thickness: 6,
                  ),
                  _buildContentSection(context),
                  // _buildNearbySection(context),
                ],
              ),
            ),

            /// RIGHT SIDE: Only for Desktop
            // if (Responsive.isDesktop(context)) ...[
            //   const SizedBox(width: 16),
            //   Expanded(
            //     flex: 3,
            //     child: Container(
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            //         height: double.infinity,
            //         decoration: BoxDecoration(
            //           color: kBackgroundColor,
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         child: Column(
            //           children: [
            //             Text(
            //               'Explore Nearby Places',
            //               style: context.style.titleLarge,
            //             ),
            //             const SizedBox(
            //               height: 16,
            //             ),
            //             const Expanded(child: HoverToExpand()),
            //           ],
            //         )),
            //   )
            // ],
          ],
        ),
      ),
    );
  }

  /// -------------------- Pg Carousel --------------------
  Widget _buildPgImages(BuildContext context) {
    return HomeStayImageCarousel(
      indicatorAlignment: Alignment.bottomCenter,
      height: 300,
      images: homeStayDetails.roomImage,
      autoPlay: true,
      topOverlay: Row(
        children: [
          // GenderBadge(gender: homeStayDetails.gender),
          // const SizedBox(width: 4),
          RatingBadge(rate: homeStayDetails.ratings!)
        ],
      ),
      onImageTap: (index) {
        context.push('/full-image-view', extra: {
          'images': homeStayDetails.roomImage,
          'initialIndex': index,
          'homeStayName': homeStayDetails.address.first.homeStayName,
        });
      },
    );
  }

  /// -------------------- Pg Info --------------------
  Widget _buildPgAddressInfo(BuildContext context) {
    //  final label = context.labels;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                homeStayDetails.address.first.homeStayName,
                style: context.style.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GoogleDirectionBadge(
                lat: homeStayDetails.address.first.lat,
                long: homeStayDetails.address.first.long,
              ),
            ],
          ),
          Text(homeStayDetails.address.first.roadName,
              style: context.style.titleSmall),
          const SizedBox(height: 4),
          Divider(
            color: context.scheme.outlineVariant.withOpacity(0.4),
          ),
          const SizedBox(height: 4),
          Text(homeStayDetails.address.first.fullAddress),
        ],
      ),
    );
  }

  /// -------------------- Main Sections (Pricing, Amenities...) --------------------
  Widget _buildContentSection(BuildContext context) {
    //final label = context.labels;
    String formatDistance(double? km) {
      if (km == null) return '';

      final meters = km * 1000;

      if (meters < 1000) {
        return '${meters.round()} m';
      }

      return '${km.toStringAsFixed(1)} km';
    }

    // String getAvailabilityText(String status) {
    //   switch (status) {
    //     case 'available':
    //       return 'Available';

    //     case 'few_left':
    //       return 'Few Rooms Left';

    //     case 'unavailable':
    //       return 'Currently Unavailable';

    //     default:
    //       return '';
    //   }
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${formatDistance(homeStayDetails.distanceKm)} from temple',
                    style: context.style.titleSmall,
                  ),
                ],
              ),
            // Text(
            //   getAvailabilityText(
            //     homeStayDetails.availabilityStatus,
            //   ),
            //   //
            //   style: context.style.titleSmall!.copyWith(
            //     color: homeStayDetails.availabilityStatus == 'unavailable'
            //         ? Colors.red
            //         : Colors.green,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            AvailabilityBadge(
              status: homeStayDetails.availabilityStatus,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text("Pricing", style: context.style.titleMedium),
        const SizedBox(height: 12),
        CustomConatiner(
          child: PricingBadge(priceDetails: homeStayDetails.priceDetails),
        ),
        if (homeStayDetails.facilities?.isNotEmpty ?? false)
          _buildSection(
            context: context,
            title: "Amenities",
            child: FacilitiesBadge(facilities: homeStayDetails.facilities!),
          ),
        if (homeStayDetails.services?.isNotEmpty ?? false)
          _buildSection(
            context: context,
            title: "Services",
            child: FacilitiesBadge(services: homeStayDetails.services!),
          ),
        if (homeStayDetails.note?.isNotEmpty ?? false) ...[
          const SizedBox(height: 16),
          _buildNoteSection(),
        ],
        if (homeStayDetails.aboutHomeStay.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            '${"About"} ${homeStayDetails.address.first.homeStayName}',
            style: context.style.titleMedium,
          ),
          const SizedBox(height: 8),
          CustomConatiner(
            padding: const EdgeInsets.all(16),
            child: ReadMoreText(
              homeStayDetails.aboutHomeStay,
              trimLines: 3,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Read More',
              trimExpandedText: ' Read Less',
              style: context.style.bodyMedium?.copyWith(
                height: 1.5,
                color: fontcolor,
              ),
              moreStyle: context.style.titleSmall?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
              lessStyle: context.style.titleSmall?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     context.push('/about', extra: {
          //       'about': homeStayDetails.aboutHomeStay,
          //       'homeStayName': homeStayDetails.address.first.homeStayName,
          //     });
          //   },
          //   child: CustomConatiner(
          //     padding: const EdgeInsets.all(16),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //             '${label.about} ${homeStayDetails.address.first.homeStayName}',
          //             style: context.style.titleSmall),
          //         Icon(Icons.arrow_forward_ios,
          //             size: 18, color: context.scheme.outline)
          //       ],
          //     ),
          //   ),
          // ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  // /// -------------------- Explore Nearby --------------------
  // Widget _buildNearbySection(BuildContext context) {
  //   final label = context.labels;

  //   if (homeStayDetails.exploreNearBy?.isEmpty ?? true) return const SizedBox();

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const SizedBox(height: 16),
  //       Text(label.exploreNearyBy, style: context.style.titleMedium),
  //       const SizedBox(height: 12),
  //       SizedBox(
  //         height: 300,
  //         child: ListView.separated(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: homeStayDetails.exploreNearBy!.length,
  //           itemBuilder: (context, index) {
  //             final nearbyPg = homeStayDetails.exploreNearBy![index];
  //             return SizedBox(
  //               width: MediaQuery.of(context).size.width *
  //                   (Responsive.isMobile(context)
  //                       ? 0.7
  //                       : Responsive.isTablet(context)
  //                           ? 0.4
  //                           : 0.26),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   context.pop();
  //                   context.push('/home-stay-details', extra: nearbyPg);
  //                 },
  //                 child: HomeStayMobileCard(
  //                     homeStayDetails: nearbyPg, isCompact: true),
  //               ),
  //             );
  //           },
  //           separatorBuilder: (_, __) => const SizedBox(width: 16),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  /// -------------------- Section Wrapper --------------------
  Widget _buildSection({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title, style: context.style.titleMedium),
        const SizedBox(height: 12),
        CustomConatiner(child: child),
      ],
    );
  }

  /// -------------------- Note --------------------
  Widget _buildNoteSection() {
    return CustomConatiner(
      color: primaryColorM.withOpacity(0.6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.perm_device_information_outlined,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(homeStayDetails.note!)),
        ],
      ),
    );
  }

  /// -------------------- Bottom Bar (Mobile only) --------------------
  Widget _buildBottomBar(
      BuildContext context, String buttonText, bool isUnavailable) {
    //final label = context.labels;
    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri url = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: context.scheme.outlineVariant.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom + 16,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: AppButton(
          label: buttonText,
          onPressed: () {
            FirebaseManager().logStayCallClicked(
              hotelName: homeStayDetails.address.first.homeStayName,
              hotelContactNumber: homeStayDetails.address.first.phoneNo,
            );
            makePhoneCall(homeStayDetails.address.first.phoneNo);
          },
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: AppButton(
        //         label: label.reserveNow,
        //         onPressed: () {},
        //         type: AppButtonType.oulined,
        //       ),
        //     ),
        //     const SizedBox(width: 12),
        //     Expanded(
        //       child: AppButton(
        //         label: label.scheduleVisit,
        //         onPressed: () {},
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
