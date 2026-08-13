import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/features/screens/parking_map_page.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.services,
    required this.calender,
    required this.webLogo,
    required this.yatriServices,
  });

  final List<Services> services;
  final YatriServices yatriServices;
  final Map<String, List<String>>? calender;
  final String webLogo;

  @override
  Widget build(BuildContext context) {
    final bool isParkingService = yatriServices.id.toLowerCase() == 'parking';

    if (isParkingService) {
      return ValueListenableBuilder<bool>(
        valueListenable: ParkingController.isSaved,
        builder: (context, isSaved, _) {
          return _buildCardContent(
            context,
            isParkingService: true,
            isSaved: isSaved,
          );
        },
      );
    }

    return _buildCardContent(context, isParkingService: false, isSaved: false);
  }

  // Future<void> openGoogleMap(double lat, double lng) async {
  //   final url =
  //       "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving";

  //   await launchUrl(
  //     Uri.parse(url),
  //     mode: LaunchMode.externalApplication,
  //   );
  // }

  // Future<bool?> _showClearLocationDialog(BuildContext context) {
  //   final label = context.labels;
  //   return showDialog<bool>(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         elevation: 10,
  //         backgroundColor: Colors.white,
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(16),
  //                 decoration: BoxDecoration(
  //                   color: Colors.red.shade50,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: Icon(
  //                   Icons.delete_outline_rounded,
  //                   size: 32,
  //                   color: Colors.red.shade600,
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               Text(
  //                 label.clearSavedLocation,
  //                 style: GoogleFonts.inter(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                   color: const Color(0xFF2D3748),
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               const SizedBox(height: 8),
  //               Text(
  //                 label.areYouSureYouWantToRemove,
  //                 style: GoogleFonts.inter(
  //                   fontSize: 13,
  //                   color: Colors.grey.shade600,
  //                   height: 1.4,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               const SizedBox(height: 24),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: OutlinedButton(
  //                       onPressed: () => Navigator.of(context).pop(false),
  //                       style: OutlinedButton.styleFrom(
  //                         padding: const EdgeInsets.symmetric(vertical: 12),
  //                         side: BorderSide(color: Colors.grey.shade300),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //                       ),
  //                       child: Text(
  //                         label.cancel,
  //                         style: GoogleFonts.inter(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.grey.shade700,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 12),
  //                   Expanded(
  //                     child: ElevatedButton(
  //                       onPressed: () => Navigator.of(context).pop(true),
  //                       style: ElevatedButton.styleFrom(
  //                         padding: const EdgeInsets.symmetric(vertical: 12),
  //                         backgroundColor: Colors.red.shade600,
  //                         elevation: 0,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //                       ),
  //                       child: Text(
  //                         label.clear,
  //                         style: GoogleFonts.inter(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildCardContent(
    BuildContext context, {
    required bool isParkingService,
    required bool isSaved,
  }) {
    final label = context.labels;

    final String titleText = isParkingService
        ? (isSaved
            ? label.trackLocation
            : LocaleService.getLocalized(yatriServices.name))
        : LocaleService.getLocalized(yatriServices.name);

    return GestureDetector(
      onTap: () async {
        // if (isParkingService) {
        //   if (isSaved) {
        //     final data = await ParkingController.get();
        //     if (data != null && data['lat'] != null && data['lng'] != null) {
        //       openGoogleMap(data['lat']!, data['lng']!);
        //     }
        //   } else {
        //     await context.push('/parking-map');
        //     await ParkingController.init();
        //   }
        // } 
        // else {
          switch (yatriServices.id.toLowerCase()) {
            case 'bookstay':
             FirebaseManager().logBookStayClicked();
              context.push('/book-stay-home');
              break;
            case 'sevainfo':
              context.push(
                '/seva-info',
                extra: {
                  'service': services,
                  'calendar': calender,
                  'webLogo': webLogo,
                  'showSevaInfoNote': yatriServices.showSevaInfoNote,
                  'sevaInfoNoteText': yatriServices.sevaInfoNoteText,
                },
              );
              break;
            case 'kumaraparvathatrek':
              if (yatriServices.services != null &&
                  yatriServices.services!.isNotEmpty) {
                context.push(
                  '/service-details',
                  extra: {
                    'service': yatriServices.services![0],
                    'calendar': calender,
                    'webLogo': webLogo,
                  },
                );
              }
              break;

            default:
              if (yatriServices.services != null &&
                  yatriServices.services!.isNotEmpty) {
                context.push(
                  '/service-details',
                  extra: {
                    'service': yatriServices.services![0],
                    'calendar': calender,
                    'webLogo': webLogo,
                  },
                );
              }
         // }
        }

        FirebaseManager().logEvent(
          FirebaseEvent.buttonClick,
          parameters: {'button_name': '${yatriServices.name}_service'},
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(16),
              border: (isParkingService && isSaved)
                  ? Border.all(color: primaryColor, width: 1.5)
                  : Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Icon Header
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgColor,
                  ),
                  child: (isParkingService && isSaved)
                      ? const Icon(
                          Icons.location_on,
                          size: 20,
                          color: primaryColor,
                        )
                      : (yatriServices.icon.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: yatriServices.icon,
                              height: 20,
                              width: 20,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                size: 18,
                                color: primaryColor,
                              ),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/icon/service_icon.png',
                              height: 18,
                              width: 18,
                            )),
                ),
                const SizedBox(height: 10),

                // Title Section with ScaleDown to prevent cutoff
                SizedBox(
                  height: 36,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                        titleText,
                       // style: context.style.titleSmall!.copyWith(fontWeight: FontWeight.w700,),
                        style: GoogleFonts.inter(
                          color: fontcolor,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          height: 1.15,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                  ),
                ),

                // Subtitle / Description Text
                if (yatriServices.subName != null &&
                    yatriServices.subName!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    LocaleService.getLocalized(yatriServices.subName),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF666666),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                ],

                
              ],
            ),
          ),

          // Clear Location Button (Parking)
          // if (isParkingService && isSaved)
          //   Positioned(
          //     top: 4,
          //     right: 4,
          //     child: GestureDetector(
          //       behavior: HitTestBehavior.opaque,
          //       onTap: () async {
          //         final confirmed = await _showClearLocationDialog(context);
          //         if (confirmed == true) {
          //           await ParkingController.clear();
          //         }
          //       },
          //       child: Container(
          //         padding: const EdgeInsets.all(3),
          //         decoration: BoxDecoration(
          //           color: Colors.red.shade50,
          //           shape: BoxShape.circle,
          //         ),
          //         child: const Icon(
          //           Icons.close,
          //           size: 12,
          //           color: Colors.red,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}