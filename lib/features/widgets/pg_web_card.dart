import 'package:yatrify/core/models/home_stay.dart';
import 'package:yatrify/features/widgets/app_button.dart';
import 'package:yatrify/features/widgets/facilities_badge.dart';
import 'package:yatrify/features/widgets/gender_badge.dart';
import 'package:yatrify/features/widgets/hover_zoom_image.dart';
import 'package:yatrify/features/widgets/web_galary_overlay.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PgWebCard extends StatelessWidget {
  const PgWebCard({super.key, required this.homeStayDetails});

  final HomeStayDetails homeStayDetails;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    void openMap() async{
      final Uri googleMapUrl = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=${homeStayDetails.address.first.lat},${homeStayDetails.address.first.long}');
      if(await canLaunchUrl(googleMapUrl)){
        await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
      }else{
        throw 'Could not launch $googleMapUrl';
      }
    }

    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri url = Uri(scheme: 'tel', path: phoneNumber);
      if(await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
    }

    return Card(
      color: whiteColor,
      margin: const EdgeInsets.only(bottom: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.8),
                    builder: (context) => WebGalaryOverlay(
                      images: homeStayDetails.roomImage,
                      initialIndex: 0,
                      pgName: homeStayDetails.address.first.homeStayName,
                    ),
                  );
                },
                child: HoverZoomImage(
                  imageUrl: homeStayDetails.roomImage.first,
                ),
              ),
              // ClipRRect(
              //   borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(12),
              //       bottomLeft: Radius.circular(12)),
              //   child: Image.network(
              //     homeStayDetails.roomImage.first,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          homeStayDetails.address.first.homeStayName,
                          style: context.style.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                       // GenderBadge(gender: homeStayDetails.gender)
                      ],
                    ),
                    Text(homeStayDetails.address.first.roadName),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: (){
                        openMap();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.directions_outlined,
                            color: primaryColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            label.viewDirections,
                            style: context.style.titleSmall!.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (homeStayDetails.facilities != null &&
                        homeStayDetails.facilities!.isNotEmpty) ...[
                      const SizedBox(
                        height: 16,
                      ),
                      FacilitiesBadge(facilities: homeStayDetails.facilities!),
                    ],
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      label.startsFrom,
                      style: context.style.bodySmall!
                          .copyWith(color: context.scheme.outline),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${homeStayDetails.priceDetails.formatedLowestPrice}',
                          style: context.style.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        AppButton(
                            label: label.call,
                            onPressed: () {
                              makePhoneCall(homeStayDetails.address.first.phoneNo);
                            },
                          ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: AppButton(
                    //         label: label.reserveNow,
                    //         onPressed: () {},
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 12,
                    //     ),
                    //     Expanded(
                    //       child: AppButton(
                    //         label: label.requestACallBack,
                    //         onPressed: () {},
                    //         type: AppButtonType.oulined,
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
