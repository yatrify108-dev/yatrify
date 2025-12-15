import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RedirectWidget extends StatelessWidget {
  const RedirectWidget({
    super.key,
    required this.webLogo,
    required this.title,
    required this.subtitle,
  });

  final String webLogo;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            webLogo.isEmpty ?
           const  Icon(
              Icons.open_in_browser,
              size: 60,
              color: Colors.purple,
            ):
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: webLogo,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
