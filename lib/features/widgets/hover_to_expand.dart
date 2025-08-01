import 'package:bookstay/core/models/pg.dart';
import 'package:bookstay/features/screens/responsive.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:flutter/material.dart';

class HoverToExpand extends StatelessWidget {
  const HoverToExpand({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            itemCount: pgData.nearByPlaces?.length,
            itemBuilder: (context, index) {
              final data = pgData.nearByPlaces![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: HoverItem(nearByPlaces: data),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HoverItem extends StatelessWidget {
  const HoverItem({super.key, required this.nearByPlaces});

  final ExploreNearByPlaces nearByPlaces;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isHovered = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovered,
        builder: (context, isAnimate, _) {
          double cardHeight = isAnimate ? 320 : 200;
          double cardWidth = isAnimate ? 530 : 200;
          BorderRadius borderRadius = isAnimate
              ? BorderRadius.circular(30)
              : BorderRadius.circular(999);
          Color color = isAnimate ? nearByPlaces.color2 : nearByPlaces.color1;

          double imageSize = isAnimate ? 150 : 200;
          Alignment imageAlign =
              isAnimate ? Alignment.centerRight : Alignment.topCenter;

          return Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                color: color,
                borderRadius: borderRadius,
              ),
              child: Stack(
                children: [
                  // TEXT CONTENT
                  AnimatedOpacity(
                    opacity: isAnimate ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              nearByPlaces.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 260,
                              child: Text(
                                nearByPlaces.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // IMAGE — INSIDE THE CARD ALWAYS
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    alignment: imageAlign,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: imageSize,
                        height: imageSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            nearByPlaces.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
