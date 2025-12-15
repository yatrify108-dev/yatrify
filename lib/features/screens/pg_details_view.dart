import 'package:yatrify/core/models/pg.dart';
import 'package:yatrify/features/widgets/app_button.dart';
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

class PgDetailsView extends StatelessWidget {
  const PgDetailsView({super.key, required this.pgDetails});

  final PgDetails pgDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text(pgDetails.address.first.pgName,style: context.style.titleMedium!.copyWith(fontSize: 20),),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, size: 20,),
          ),
        ],
      ),
      bottomNavigationBar:
          Responsive.isMobile(context) ? _buildBottomBar(context) : null,
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
                  const SizedBox(height: 8,),
                  Divider(
                      color: context.scheme.outlineVariant.withOpacity(0.2),
                      thickness: 6,),
                  _buildContentSection(context),
                  _buildNearbySection(context),
                ],
              ),
            ),

            /// RIGHT SIDE: Only for Desktop
            if (Responsive.isDesktop(context)) ...[
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      
                        Text('Explore Nearby Places', style: context.style.titleLarge,),
                        const SizedBox(height: 16,),
                      const Expanded(child:  HoverToExpand()),
                    ],
                  )
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  /// -------------------- Pg Carousel --------------------
  Widget _buildPgImages(BuildContext context) {
    return PgImageCarousel(
      indicatorAlignment: Alignment.bottomCenter,
      height: 300,
      images: pgDetails.roomImage,
      autoPlay: true,
      topOverlay: Row(
        children: [
          GenderBadge(gender: pgDetails.gender),
          const SizedBox(width: 4),
          RatingBadge(rate: pgDetails.ratings!)
        ],
      ),
      onImageTap: (index) {
        context.push('/full-image-view', extra: {
          'images': pgDetails.roomImage,
          'initialIndex': index,
          'pgName': pgDetails.address.first.pgName,
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
                pgDetails.address.first.pgName,
                style: context.style.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GoogleDirectionBadge(
                lat: pgDetails.address.first.lat,
                long: pgDetails.address.first.long,
              ),
            ],
          ),
          Text(pgDetails.address.first.roadName,
              style: context.style.titleSmall),
          const SizedBox(height: 4),
          Divider(color: context.scheme.outlineVariant.withOpacity(0.4),),
           const SizedBox(height: 4),
          Text(pgDetails.address.first.fullAddress),
        ],
      ),
    );
  }

  /// -------------------- Main Sections (Pricing, Amenities...) --------------------
  Widget _buildContentSection(BuildContext context) {
    final label = context.labels;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(label.pricing, style: context.style.titleMedium),
        const SizedBox(height: 12),
        CustomConatiner(
          child: PricingBadge(priceDetails: pgDetails.priceDetails),
        ),
        if (pgDetails.facilities?.isNotEmpty ?? false)
          _buildSection(
            context: context,
            title: label.amenities,
            child: FacilitiesBadge(facilities: pgDetails.facilities!),
          ),
        if (pgDetails.services?.isNotEmpty ?? false)
          _buildSection(
            context: context,
            title: label.services,
            child: FacilitiesBadge(services: pgDetails.services!),
          ),
        if (pgDetails.note?.isNotEmpty ?? false) ...[
          const SizedBox(height: 16),
          _buildNoteSection(),
        ],
        if (pgDetails.aboutPG.isNotEmpty) ...[
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              context.push('/about', extra: {
                'about': pgDetails.aboutPG,
                'pgName': pgDetails.address.first.pgName,
              });
            },
            child: CustomConatiner(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${label.about} ${pgDetails.address.first.pgName}',
                      style: context.style.titleSmall),
                  Icon(Icons.arrow_forward_ios,
                      size: 18, color: context.scheme.outline)
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// -------------------- Explore Nearby --------------------
  Widget _buildNearbySection(BuildContext context) {
    final label = context.labels;

    if (pgDetails.exploreNearBy?.isEmpty ?? true) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(label.exploreNearyBy, style: context.style.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: pgDetails.exploreNearBy!.length,
            itemBuilder: (context, index) {
              final nearbyPg = pgDetails.exploreNearBy![index];
              return SizedBox(
                width: MediaQuery.of(context).size.width * (Responsive.isMobile(context)? 0.7: Responsive.isTablet(context)? 0.4 : 0.26),
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                    context.push('/pg-details', extra: nearbyPg);
                  },
                  child: PgMobileCard(pgDetails: nearbyPg, isCompact: true),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 16),
          ),
        ),
      ],
    );
  }

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
              color: primaryColorL.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.perm_device_information_outlined,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(pgDetails.note!)),
        ],
      ),
    );
  }

  /// -------------------- Bottom Bar (Mobile only) --------------------
  Widget _buildBottomBar(BuildContext context) {
    final label = context.labels;
    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri url = Uri(scheme: 'tel', path: phoneNumber);
      if(await canLaunchUrl(url)) {
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
                label: label.call,
                onPressed: () {
                  makePhoneCall(pgDetails.address.first.phoneNo);
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
