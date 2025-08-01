import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/color.schemes.g.dart';

class GoogleDirectionBadge extends StatelessWidget {
  const GoogleDirectionBadge({super.key, required this.lat, required this.long});
  final String lat;
  final String long;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    void openMap() async{
      final Uri googleMapUrl = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$long');
      if(await canLaunchUrl(googleMapUrl)){
        await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
      }else{
        throw 'Could not launch $googleMapUrl';
      }
    }
    return InkWell(
      onTap: (){
        openMap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
        decoration: BoxDecoration(
          color: primaryColorL.withOpacity(0.3), 
         border: Border.all(color: primaryColorM.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.directions_outlined,
              color: primaryColor,
              size: 16,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              label.directions,
              style: context.style.titleSmall!.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
