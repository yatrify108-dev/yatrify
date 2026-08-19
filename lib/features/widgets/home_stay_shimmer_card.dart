import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeStayShimmerCard extends StatelessWidget {
  const HomeStayShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 18,
                        width: 140,
                        color: Colors.white,
                      ),
                      Container(
                        height: 18,
                        width: 60,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Subtitle & Availability Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 14,
                        width: 100,
                        color: Colors.white,
                      ),
                      Container(
                        height: 14,
                        width: 60,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tags Row (Facilities)
                  Row(
                    children: [
                      Container(
                        height: 32,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 32,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeStayShimmerList extends StatelessWidget {
  const HomeStayShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 20,
          width: 120,
          color: Colors.grey.shade300,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (_, __) => const HomeStayShimmerCard(),
      ),
    );
  }
}