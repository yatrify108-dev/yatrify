import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WebGalaryOverlay extends StatelessWidget {
  const WebGalaryOverlay(
      {super.key,
      required this.images,
      required this.initialIndex,
      required this.pgName});

  final List<String> images;
  final int initialIndex;
  final String pgName;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
    selectedIndex.value = initialIndex;
    final PageController controller = PageController(
      initialPage: initialIndex,
      viewportFraction: 0.5,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, index, _) {
                  return SizedBox(
                   // width: 800,
                    height: 500,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: controller,
                          itemCount: images.length,
                          onPageChanged: (index) => selectedIndex.value = index,
                          itemBuilder: (context, index) {
                            return ValueListenableBuilder(
                              valueListenable: selectedIndex,
                              builder: (context, currentIndex, _) {
                                final isCenter = index == currentIndex;
                                return AnimatedContainer(
                                  duration: const Duration(microseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Transform.scale(
                                    scale: isCenter ? 1.0 : 0.9,
                                    child: Center(
                                      child: InteractiveViewer(
                                        panEnabled: true,
                                        minScale: 1,
                                        maxScale: 4,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Image.network(
                                                images[index],
                                                fit: BoxFit.cover,
                                              ),
                                              if (!isCenter)
                                                Container(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        // Center(
                        //   child: InteractiveViewer(
                        //     panEnabled: true,
                        //     minScale: 1,
                        //     maxScale: 4,
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(8),
                        //       child: Image.network(
                        //         images[index],
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          left: 8,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              if (index > 0) {
                                controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: (index > 0) ? whiteColor : Colors.grey,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white38,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          right: 8,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              if (index < images.length - 1) {
                                controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: (index < images.length - 1)
                                    ? whiteColor
                                    : Colors.grey,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white38,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 80,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return ValueListenableBuilder(
                        valueListenable: selectedIndex,
                        builder: (context, selected, _) {
                          return GestureDetector(
                            onTap: () {
                              selectedIndex.value = index;
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: index == selected
                                        ? primaryColor
                                        : Colors.grey,
                                    width: 2,
                                  )),
                              child: Image.network(
                                images[index],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.close,
                color: whiteColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
