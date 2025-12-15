import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:yatrify/utils/color.schemes.g.dart';

class FullScreenImageGallery extends StatefulWidget {
  const FullScreenImageGallery({
    super.key,
    required this.images,
    this.initialIndex = 0,
    this.pgName = '',
  });

  final List<String> images;
  final int initialIndex;
  final String pgName;

  @override
  State<FullScreenImageGallery> createState() => _FullScreenImageGalleryState();
}

class _FullScreenImageGalleryState extends State<FullScreenImageGallery> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    selectedIndex.value = widget.initialIndex;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          widget.pgName,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (context, index, _) {
                return PhotoView(
                  imageProvider: NetworkImage(
                    widget.images[index],
                  ),
                  backgroundDecoration: const BoxDecoration(color: whiteColor),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered,
                );
              },
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    selectedIndex.value = index;
                  },
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, selected, _) {
                      return Container(
                        margin: const EdgeInsets.only(
                          left: 8,
                        ),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            color: index == selected
                                ? primaryColor.withOpacity(0.8)
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Image.network(
                          widget.images[index],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
