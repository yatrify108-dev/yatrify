import 'package:bookstay/core/models/pg.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';

class FacilitiesBadge extends StatelessWidget {
  const FacilitiesBadge({
    super.key,
     this.facilities,
     this.services
  });

  final List<Facilities>? facilities;
  final List<Services>? services;

  @override
  Widget build(BuildContext context) {
    final items = facilities != null && facilities!.isNotEmpty ?
    facilities!.where((e)=>e.name.isNotEmpty).toList(): services != null && services!.isNotEmpty ? services!.where((e)=>e.name.isNotEmpty).toList():[];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                //color: primaryColor.withOpacity(0.08),
               // color: whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: context.scheme.outlineVariant.withOpacity(0.4),),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                        color: context.scheme.outlineVariant.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4)),
                    child: 
                    Image.network(
                    e.icon,
                    fit: BoxFit.contain,
                    height: 16,
                    width: 16,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.close, size: 16,color: primaryColor,),
                  ),
                  ),
                  
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    e.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
