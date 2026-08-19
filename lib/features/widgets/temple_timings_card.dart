import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class TempleTimingsCard extends StatefulWidget {
  const TempleTimingsCard({
    super.key,
    required this.timings,
  });

  final Timings timings;

  @override
  State<TempleTimingsCard> createState() => _TempleTimingsCardState();
}

class _TempleTimingsCardState extends State<TempleTimingsCard> {
  late final ValueNotifier<bool> isOpenNotifier;
  late final ValueNotifier<int?> activeSlotNotifier;
  late final Timer timer;

  @override
  void initState() {
    super.initState();

    isOpenNotifier = ValueNotifier(checkIfOpen());
    activeSlotNotifier = ValueNotifier(getActiveSlotIndex());

    timer = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        isOpenNotifier.value = checkIfOpen();
        activeSlotNotifier.value = getActiveSlotIndex();
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    isOpenNotifier.dispose();
    activeSlotNotifier.dispose();
    super.dispose();
  }

  bool checkIfOpen() {
    final now = DateTime.now();

    for (var slot in widget.timings.slots) {
      if (isCurrentTimeInSlot(now, slot)) {
        return true;
      }
    }

    return false;
  }

  int? getActiveSlotIndex() {
    final now = DateTime.now();

    for (int i = 0; i < widget.timings.slots.length; i++) {
      if (isCurrentTimeInSlot(now, widget.timings.slots[i])) {
        return i;
      }
    }

    return null;
  }

  bool isCurrentTimeInSlot(DateTime now, TimeSlot slot) {
    final start = parseTime(slot.from);
    final end = parseTime(slot.to);

    return now.isAfter(start) && now.isBefore(end);
  }

  DateTime parseTime(String time) {
    final isPM = time.toUpperCase().contains('PM');

    final cleaned =
        time.toUpperCase().replaceAll('AM', '').replaceAll('PM', '').trim();

    List<String> parts;

    if (cleaned.contains(':')) {
      parts = cleaned.split(':');
    } else if (cleaned.contains('.')) {
      parts = cleaned.split('.');
    } else {
      parts = [cleaned];
    }

    int hour = int.parse(parts[0].trim());

    int minute = parts.length > 1 ? int.parse(parts[1].trim()) : 0;

    if (isPM && hour != 12) {
      hour += 12;
    }

    if (!isPM && hour == 12) {
      hour = 0;
    }

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

    final isKannada = Localizations.localeOf(context).languageCode == 'kn';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isKannada ? 10 : 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label.templeTimings,
                  style: isKannada
                      ? context.style.titleSmall!.copyWith(
                          color: fontcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )
                      : context.style.titleMedium!.copyWith(
                          color: fontcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                ),

                // OPEN / CLOSED STATUS
                ValueListenableBuilder<bool>(
                  valueListenable: isOpenNotifier,
                  builder: (context, isOpen, _) {
                    final statusColor = isOpen ? Colors.green : Colors.red;

                    return Flexible(
                      child: IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isOpen ? Icons.check_circle : Icons.cancel,
                                color: statusColor,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  isOpen
                                      ? label.darshanaOpen
                                      : label.darshanaClose,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.style.titleSmall!.copyWith(
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            // TIMING BOXES
            ValueListenableBuilder<int?>(
              valueListenable: activeSlotNotifier,
              builder: (context, activeSlotIndex, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.timings.slots.isNotEmpty)
                      Expanded(
                        child: _buildCompactTiming(
                          context,
                          label.morning,
                          widget.timings.slots.first,
                          Icons.wb_sunny_outlined,
                          Colors.orange,
                          activeSlotIndex == 0,
                        ),
                      ),
                    if (widget.timings.slots.length > 1)
                      Expanded(
                        child: _buildCompactTiming(
                          context,
                          label.evening,
                          widget.timings.slots.last,
                          Icons.nightlight_round,
                          Colors.deepOrange,
                          activeSlotIndex == 1,
                        ),
                      ),
                    if (widget.timings.lunch.isNotEmpty)
                      Expanded(
                        child: _buildCompactTiming(
                          context,
                          label.bojana,
                          widget.timings.lunch.first,
                          Icons.restaurant_outlined,
                          Colors.green,
                          isCurrentTimeInSlot(
                            DateTime.now(),
                            widget.timings.lunch.first,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCompactTiming(
  BuildContext context,
  String title,
  TimeSlot slot,
  IconData icon,
  Color color,
  bool isActive,
) {
  final label = context.labels;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 6,
    ),
    decoration: BoxDecoration(
      color: isActive ? color.withOpacity(0.18) : color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: isActive
          ? Border.all(
              color: color.withOpacity(0.6),
              width: 1.2,
            )
          : null,
    ),
    child: Column(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.style.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${slot.from} - ${slot.to}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.style.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        if (isActive) ...[
          const SizedBox(height: 4),
          Text(
            label.now,
            style: context.style.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ],
    ),
  );
}
