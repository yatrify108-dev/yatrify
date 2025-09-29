import 'dart:async';
import 'package:bookstay/core/models/temple.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TempleTimingsCard extends StatefulWidget {
  const TempleTimingsCard({super.key, required this.timings});
  final Timings timings;

  @override
  State<TempleTimingsCard> createState() => _TempleTimingsCardState();
}

class _TempleTimingsCardState extends State<TempleTimingsCard> {
  late final ValueNotifier<bool> isOpenNotifier;
  late final Timer timer;

  @override
  void initState() {
    isOpenNotifier = ValueNotifier(checkIfOpen());
    timer = Timer.periodic(const Duration(seconds: 30), (_) {
      isOpenNotifier.value = checkIfOpen();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    isOpenNotifier.dispose();
    super.dispose();
  }

  bool checkIfOpen() {
    final now = DateTime.now();
    for (var slot in widget.timings.slots) {
      if (isCurrentTimeInSlot(now, slot)) return true;
    }
    return false;
  }

  bool isCurrentTimeInSlot(DateTime now, TimeSlot slot) {
    final start = parseTime(slot.from);
    final end = parseTime(slot.to);
    return now.isAfter(start) && now.isBefore(end);
  }

  DateTime parseTime(String time) {
    final isPM = time.contains('PM');
    final cleaned = time.replaceAll(RegExp(r'[APM]'), '');

    List<String> parts;
    if (cleaned.contains(':')) {
      parts = cleaned.split(':');
    } else if (cleaned.contains('.')) {
      parts = cleaned.split('.');
    } else {
      parts = [cleaned];
    }

    int hour = int.parse(parts[0]);
    int minute = parts.length > 1 ? int.parse(parts[1]) : 0;

    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return DateTime.now().copyWith(
      hour: hour,
      minute: minute,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return GestureDetector(
      onTap: (){
         context.push('/temple-timings-view', extra: widget.timings);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: const Offset(0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label.templeTimings,
                  style: context.style.titleMedium!.copyWith(
                      color: fontcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isOpenNotifier,
                  builder: (context, isOpen, _) {
                    return Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: isOpen ? Colors.green : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              isOpen ? 'Darshan Open' : 'Darshan Closed',
                              style: context.style.titleSmall!.copyWith(
                                color: isOpen ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                  },
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.timings.slots.isNotEmpty)
                  Expanded(
                      child: _buildTimingRow(
                          context, 'Morning', widget.timings.slots.first)),
                if (widget.timings.slots.length > 1)
                  Expanded(
                      child: _buildTimingRow(
                          context, 'Evening', widget.timings.slots.last)),
                if (widget.timings.lunch.isNotEmpty)
                  Expanded(
                      child: _buildTimingRow(
                          context, 'Lunch', widget.timings.lunch.first))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTimingRow(BuildContext context, String title, TimeSlot slot) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Column(
      children: [
        Text(
          title,
          style:
              context.style.bodySmall!.copyWith(color: fontcolor, fontSize: 16),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '${slot.from} - ${slot.to}',
          style: context.style.titleSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: fontcolor,
          ),
        )
      ],
    ),
  );
}
