import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class OfficialLinkWidget extends StatelessWidget {
  final String bookingUrl;
  final String bookingLinkTitle;

  const OfficialLinkWidget({
    super.key,
    required this.bookingUrl,
    required this.bookingLinkTitle,
  });

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: primaryColor,
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (bookingLinkTitle.isNotEmpty) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.link_rounded,
                      color: primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        bookingLinkTitle,
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    24, 
                    (index) => Container(
                      width: 8, 
                      height: 0.9, 
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        bookingUrl,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: bookingUrl!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Link copied to clipboard!"),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.copy_rounded,
                            color: primaryColor,
                            size: 28,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            label.copy,
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
