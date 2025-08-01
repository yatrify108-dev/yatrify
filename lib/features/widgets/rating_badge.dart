import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.rate});

  final String rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4).copyWith(right: 8),
      decoration: BoxDecoration(
        color: ratingBadgeColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
         const  Icon(Icons.star,color: ratingFontColor,size: 16,),
          Text(rate,style: const TextStyle(color: ratingFontColor),)
        ],
      ),
    );
  }
}