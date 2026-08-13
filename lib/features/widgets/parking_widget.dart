import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/screens/parking_map_page.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class ParkingBannerWidget extends StatelessWidget {
  const ParkingBannerWidget({super.key, required this.parkingModel});

  final ParkingModel parkingModel;

  @override
  Widget build(BuildContext context) {
    Future<void> openGoogleMap(double lat, double lng) async {
      final url =
          "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving";

      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }

    Future<bool?> _showClearLocationDialog(BuildContext context) {
      final label = context.labels;
      return showDialog<bool>(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      size: 32,
                      color: Colors.red.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    label.clearSavedLocation,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D3748),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label.areYouSureYouWantToRemove,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            label.cancel,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.red.shade600,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            label.clear,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ValueListenableBuilder<bool>(
        valueListenable: ParkingController.isSaved,
        builder: (context, isSaved, _) {
          if (isSaved) {
            return InkWell(
                onTap: () async {
                  final data = await ParkingController.get();
                  if (data != null) {
                    openGoogleMap(data['lat']!, data['lng']!);
                  }
                },
                //borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F8F3), 
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF2E6D38).withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                     
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E6D38),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E4D27),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            Text(
                              LocaleService.getLocalized(parkingModel.trackTitle),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: fontcolor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              LocaleService.getLocalized(parkingModel.trackSubtitle),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right Chevron Arrow Action Indicator
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF2E6D38),
                        size: 24,
                      ),
                      const SizedBox(width: 8),

                      // Close (X) Clear Button
                      InkWell(
                        onTap: () async {
                          final confirmed =
                              await _showClearLocationDialog(context);
                          if (confirmed == true) {
                            await ParkingController.clear();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.black38,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          } else {
            // STATE 1: INITIAL "MY PARKING" BANNER
            return InkWell(
                onTap: () async {
                  await context.push('/parking-map');
                  await ParkingController.init();
                },
               // borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryColor.withOpacity(0.1)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.03),
                    //     blurRadius: 8,
                    //     offset: const Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  child: Row(
                    children: [
                      // Parking Icon
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_parking,
                          color: whiteColor,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              LocaleService.getLocalized(parkingModel.parkingTitle),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: fontcolor,
                              ),
                            ),
                            const SizedBox(height: 2),
                             Text(
                              LocaleService.getLocalized(parkingModel.parkingSubtitle),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Arrow Icon
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
