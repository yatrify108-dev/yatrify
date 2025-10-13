import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SmallBannerCard extends StatelessWidget {
  const SmallBannerCard({
    super.key,
    required this.image,
    required this.url,
  });

  final String image;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(url.isNotEmpty){
          context.push('/redirect-page', extra: url);
        }
         
      },
      child: Container(
          decoration: BoxDecoration(
           // color: context.scheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: CachedNetworkImageProvider(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
    );
  }
}
