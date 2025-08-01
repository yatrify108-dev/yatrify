import 'package:bookstay/core/models/pg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/responsive.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key, required this.banners});

  final List<PgBanner> banners;

  @override
  Widget build(BuildContext context) {
    final validBanner = banners.where((banner)=> banner.bannerImage!.isNotEmpty).toList();

    final double sliderHeight = Responsive.isDesktop(context)
        ? 300
        : Responsive.isMobile(context)
            ? 180
            : 200;

    
    Future<void> _launchUrl(String? url) async{
      if(url == null || url.isEmpty) return;

      final Uri uri = Uri.parse(url);
      if(await canLaunchUrl(uri)){
        await launchUrl(uri, mode: LaunchMode.platformDefault,);
      }
      else{
        debugPrint("could not lunch $url");
      }
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: sliderHeight,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: validBanner.map((banner) {
        return Builder(
          builder: (BuildContext content) {
            return GestureDetector(
              onTap: (){
                _launchUrl(banner.link);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: 
                  banner.bannerImage ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url)=> const Center(child: CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
