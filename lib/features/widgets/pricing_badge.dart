import 'package:yatrify/core/models/pg.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../constant/const_string.dart';

class PricingBadge extends StatelessWidget {
  const PricingBadge({super.key, required this.priceDetails});

  final List<PriceDetails> priceDetails;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: priceDetails
          .map(
            (e) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: context.scheme.outlineVariant.withOpacity(0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: primaryColorL.withOpacity(0.4),
                        border:
                            Border.all(color: primaryColorM.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.bed_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          'x ${e.bedNum}',
                          style: const TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label.startsFrom,
                        style: context.style.bodySmall,
                      ),
                      Text(
                        '${ConstString.rupees}${e.price.formated}',
                        style: context.style.titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
