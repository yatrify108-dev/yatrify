import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TempleTimingsView extends StatelessWidget {
  const TempleTimingsView({super.key, required this.timings});

  final Timings timings;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    final imageUrl = timings.image ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(label.templeTimings),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height * 0.3,
            imageUrl: imageUrl,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.darshanTimings,
                  style: context.style.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24,),
                _buildTimingRow(
                          context, 'Morning', timings.slots.first),
                          const SizedBox(height: 20,),
                _buildTimingRow(
                          context, 'Evening', timings.slots.last),
                          const SizedBox(height: 24,),
                          Text(
                  label.mealTimings,
                  style: context.style.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                      
                ),
                const SizedBox(height: 24,),
                _buildTimingRow(
                          context, 'Lunch', timings.lunch.first),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildTimingRow(BuildContext context, String title, TimeSlot slot) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              context.style.titleMedium!.copyWith(color: fontcolor, fontSize: 18,fontWeight: FontWeight.w600,),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '${slot.from} - ${slot.to}',
          style: context.style.titleMedium!.copyWith(
            // fontWeight: FontWeight.bold,
            color: fontcolor,
           // fontSize: 16,
          ),
        )
      ],
    ),
  );
}
