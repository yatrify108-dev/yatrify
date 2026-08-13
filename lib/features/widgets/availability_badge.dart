import 'package:flutter/material.dart';
import 'package:yatrify/utils/extensions.dart';

class AvailabilityBadge extends StatelessWidget {
  final String status;

  const AvailabilityBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUnavailable = status == 'unavailable';
    final bool isFewLeft = status == 'few_left';

    final Color color = isUnavailable
        ? Colors.red
        : isFewLeft
            ? Colors.orange
            : Colors.green;

    final IconData icon = isUnavailable
        ? Icons.cancel_outlined
        : isFewLeft
            ? Icons.warning_amber_rounded
            : Icons.check_circle_outline;

    final String text = isUnavailable
        ? 'Currently Unavailable'
        : isFewLeft
            ? 'Few Rooms Left'
            : 'Available';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: context.style.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}