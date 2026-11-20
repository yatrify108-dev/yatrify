import 'package:shimmer/shimmer.dart';
import 'package:yatrify/core/models/base_banner.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../screens/responsive.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel(
      {super.key,
      required this.banners,
      this.screenHeightValue,
      this.autoPlay,
      this.borderRadius = 0,
      this.showMainBanner = false});

  final List<BaseBanner> banners;
  final double? screenHeightValue;
  final bool? autoPlay;
  final double borderRadius;
  final bool? showMainBanner;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final validBanner = widget.banners
        .where((banner) =>
            banner.bannerImage != null && banner.bannerImage!.isNotEmpty)
        .toList();

    final double sliderHeight = widget.screenHeightValue ??
        (Responsive.isDesktop(context)
            ? 300
            : Responsive.isMobile(context)
                ? screenHeight * 0.5
                : 200);

    

    return CarouselSlider(
      options: CarouselOptions(
        height: sliderHeight,
        autoPlay: widget.autoPlay ?? false,
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) {
          _currentIndex.value = index;
        },
        enableInfiniteScroll: validBanner.length > 1,
        scrollPhysics: validBanner.length > 1
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),

        // aspectRatio: 16/9,
      ),
      items: validBanner.map(
        (banner) {
          return Builder(
            builder: (BuildContext content) {
              return GestureDetector(
                onTap: () {
                  // _launchUrl(banner.link);
                  banner.link!.launch();
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: banner.bannerImage != null &&
                              banner.bannerImage!.startsWith('http')
                          ? Stack(
                              children: [
                                if (widget.showMainBanner == true) ...[
                                  Image.asset(
                                    'assets/main-banner.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: sliderHeight,
                                  ),
                                ],
                                CachedNetworkImage(
                                  imageUrl: banner.bannerImage ?? '',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: sliderHeight,
                                  fadeInDuration:
                                      const Duration(milliseconds: 300),
                                  //     placeholder: (context, url) => const Center(
                                  //   child: CircularProgressIndicator(color: primaryColor,),
                                  // ),

                                  placeholder: (widget.showMainBanner == true)
                                      ? null
                                      : (context, url) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width: double.infinity,
                                              height: sliderHeight,
                                              color: Colors.white,
                                            ),
                                          );
                                        },

                                  // fadeInDuration: Duration.zero,

                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ],
                            )
                          : Image.asset(
                              banner.bannerImage ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: sliderHeight,
                              // alignment: Alignment.topCenter,
                            ),
                    ),
                    if (validBanner.length > 1)
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: ValueListenableBuilder<int>(
                          valueListenable: _currentIndex,
                          builder: (context, current, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                validBanner.length,
                                (i) => Container(
                                  width: 6,
                                  height: 6,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: i == current
                                        ? primaryColor
                                        : whiteColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
