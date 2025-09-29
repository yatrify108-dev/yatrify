import 'package:bookstay/core/models/temple.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/service_widget.dart';

class ServiceViewAll extends StatelessWidget {
  const ServiceViewAll({super.key, required this.temple});

  final Temple temple;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(label.allYatriServices),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: GridView.builder(
          itemCount: temple.services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            childAspectRatio: 0.9,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final s = temple.services[index];
            return GestureDetector(
              onTap: () {
                context.push(
                  '/service-details',
                  extra: {
                    'service': s,
                    'calendar': temple.calender,
                  },
                );
              },
              child: ServiceCard(
                services: s,
                calender: temple.calender,
              ),
            );
          },
        ),
      ),
    );
  }
}
