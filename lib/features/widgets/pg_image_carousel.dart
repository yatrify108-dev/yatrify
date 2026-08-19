import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/color.schemes.g.dart';

class HomeStayImageCarousel extends StatefulWidget {
  const HomeStayImageCarousel({
    super.key,
    required this.images,
    this.height = 240,
    this.borderRadius,
    this.customClipper,
    this.indicatorAlignment = Alignment.bottomLeft,
    this.showIndicator = true,
    this.bottomOverlay,
    this.topOverlay,
    this.autoPlay = false,
    this.onImageTap,
  });

  final List<String> images;
  final double height;
  final BorderRadius? borderRadius;
  final CustomClipper<Path>? customClipper;
  final Alignment indicatorAlignment;
  final bool showIndicator;
  final Widget? bottomOverlay;
  final Widget? topOverlay;
  final bool? autoPlay;
  final void Function(int index)? onImageTap;

  @override
  State<HomeStayImageCarousel> createState() => _HomeStayImageCarouselState();
}

class _HomeStayImageCarouselState extends State<HomeStayImageCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildImage(String url) {
      final image = CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: double.infinity,
        height: widget.height,
        // placeholder: (context, url) => const Center(
        //   child: CircularProgressIndicator(color: Colors.white),
        // ),
        placeholder: (context, url) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: widget.height,
        color: Colors.white,
      ),
    ),
        
        // errorWidget: (context, url, error) => const Center(
        //   child: Icon(
        //     Icons.broken_image,
        //     size: 48,
        //     color: Colors.grey,
        //   ),
        // ),
        errorWidget: (context, url, error) => Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.broken_image,
          size: 48,
          color: Colors.grey,
        ),
      ),
    ),
  
      );
      // Image.network(
      //   url,
      //   fit: BoxFit.cover,
      //   width: double.infinity,
      //   height: widget.height,
      //   errorBuilder: (context, error, statTrace) => const Center(
      //     child: Icon(
      //       Icons.broken_image,
      //       size: 48,
      //       color: Colors.grey,
      //     ),
      //   ),
      // );

      if (widget.customClipper != null) {
        return ClipPath(
          clipper: widget.customClipper,
          child: image,
        );
      }
      return image;
    }

    Widget carouselContent = Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index, realImage) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onImageTap != null
                  ? () {
                      _currentIndex.value = index;
                      widget.onImageTap?.call(index);
                    }
                  : null,
              child: buildImage(
                widget.images[index],
              ),
            );
          },
          options: CarouselOptions(
              autoPlay: widget.autoPlay!,
              height: widget.height,
              viewportFraction: 1.0,
              enableInfiniteScroll: widget.images.length > 1,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                _currentIndex.value = index;
              }),
        ),
        if (widget.topOverlay != null)
          Positioned(
            top: 8,
            right: 8,
            child: widget.topOverlay!,
          ),
        if (widget.bottomOverlay != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: widget.bottomOverlay!,
          ),
        if (widget.showIndicator)
          Positioned(
            bottom: 8,
            left: widget.indicatorAlignment == Alignment.bottomLeft ? 12 : 0,
            right:
                widget.indicatorAlignment == AlignmentDirectional.bottomCenter
                    ? 0
                    : null,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, current, _) {
                return Row(
                  mainAxisAlignment:
                      widget.indicatorAlignment == Alignment.bottomCenter
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                  children: List.generate(
                    widget.images.length,
                    (i) => Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == current ? primaryColor : whiteColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: carouselContent,
      ),
    );
  }
}
