import 'package:bookstay/core/models/base_banner.dart';
import 'package:bookstay/core/models/temple.dart';
import 'package:bookstay/core/services/fetch_data.dart';
import 'package:bookstay/features/widgets/banner_carousel.dart';
import 'package:bookstay/features/widgets/nearby_places.dart';
import 'package:bookstay/features/widgets/temple_timings_card.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/service_widget.dart';
import '../widgets/temple_media_widget.dart';

class TempleHomePage extends StatelessWidget {
  const TempleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    String getCurrentDayString() {
      const days = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];
      final now = DateTime.now();
      return days[now.weekday - 1];
    }

    Timings? getTimingsForToday(List<Timings> timings) {
      final today = getCurrentDayString();
      try {
        return timings.firstWhere(
          (timing) => timing.day.toLowerCase() == today.toLowerCase(),
        );
      } catch (e) {
        return null;
      }
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: whiteColor,
        forceMaterialTransparency: true,
        title: Text(
          'Yatrify',
          style: context.style.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: FutureBuilder<Temple>(
        future: fetchTempleData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerPlaceholder(context);
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('${label.error}: ${snapshot.error}'),
            );
          }
          final temple = snapshot.data!;
          final todayTimings = getTimingsForToday(temple.timings);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerCarousel(
                  banners: (temple.banner ?? []).map((tb) {
                    return BaseBanner(
                      bannerImage: tb.bannerImage,
                      link: tb.link,
                    );
                  }).toList(),
                ),
                // BannerCarousel(
                //   banners: [
                //     BaseBanner(
                //       bannerImage: "assets/banner/banner1.jpeg",
                //       link: "",
                //     ),
                //     BaseBanner(
                //       bannerImage: "assets/banner/banner2.jpeg",
                //       link: "",
                //     ),
                //     BaseBanner(
                //       bannerImage: "assets/banner/banner3.jpeg",
                //       link: "",
                //     ),
                //   ],
                // ),

                // Stack(
                //   children: [
                //     Container(
                //       width: double.infinity,
                //       height: MediaQuery.sizeOf(context).height * 0.4,
                //       decoration: const BoxDecoration(
                //         image: DecorationImage(
                //           image: AssetImage('assets/bg.png'),
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ),
                //     const Positioned(
                //         bottom: 0, right: 20, left: 20, child: TempleNameCard())
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      // const  TempleNameCard(),
                      // const SizedBox(height: 20),
                      TempleTimingsCard(
                        timings: todayTimings ??
                            Timings(
                              day: 'No timings today',
                              slots: [],
                              lunch: [],
                            ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/icon/spark.png',
                            height: 28,
                            width: 28,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            label.yatriServices,
                            style: context.style.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: fontcolor,
                            ),
                          ),
                          // const Spacer(),
                          // TextButton(
                          //   onPressed: () {
                          //     context.push('/view-all-services', extra: temple);
                          //   },
                          //   child: Text(
                          //     label.viewAll,
                          //     style: context.style.titleSmall!.copyWith(
                          //       fontWeight: FontWeight.bold,
                          //       color: viewAllFontColor,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: temple.services.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10,
                          //childAspectRatio: 1.0,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final service = temple.services[index];
                          return ServiceCard(
                            services: service,
                            calender: temple.calender,
                          );
                        },
                      ),
                    ],
                  ),
                ),

              
                const SizedBox(height: 16),
                TempleMediaWidget<PoojaVideos>(
                  title: label.poojaVideos,
                  item: temple.videos ?? [],
                ),

            
                TempleMediaWidget<Bhajans>(
                  title: label.bhajans,
                  item: temple.bhajans ?? [],
                ),
                const SizedBox(height: 8),
                NearByPlacesCard<NearByPlaces>(
                  title: label.nearByPlaces,
                  item: temple.nearByPlaces ?? [],
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Shimmer Loader Widget
  Widget _buildShimmerPlaceholder(BuildContext context) {
    // const backgroundColor = Color(0xFFffe99e); // page bg
    // final baseShimmerColor = const Color(0xFFf9d97b); // slightly darker yellow
    // final highlightShimmerColor = const Color(0xFFfff7d1); // pale cream
    final baseShimmerColor = const Color(0xFFE0E0E0); // light gray base
    final highlightShimmerColor =
        const Color(0xFFF5F5F5); // near white highlight// pale cream

    return Shimmer.fromColors(
      baseColor: baseShimmerColor,
      highlightColor: highlightShimmerColor,
      period: const Duration(milliseconds: 1500),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Banner placeholder
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.4,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            // Temple timing card placeholder
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Service section title placeholder
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 20,
                width: 120,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            // Service cards placeholder
            SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
