import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:yatrify/core/models/base_banner.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/fetch_data.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';
import 'package:yatrify/features/app_update/app_update.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/features/widgets/banner_carousel.dart';
import 'package:yatrify/features/widgets/nearby_places.dart';
import 'package:yatrify/features/widgets/small_banner_card.dart';
import 'package:yatrify/features/widgets/temple_timings_card.dart';
import 'package:yatrify/features/widgets/wallpaper_card.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/service_widget.dart';
import '../widgets/temple_media_widget.dart';

class TempleHomePage extends StatefulWidget {
  const TempleHomePage({super.key});

  @override
  State<TempleHomePage> createState() => _TempleHomePageState();
}

class _TempleHomePageState extends State<TempleHomePage> {
  @override
  void initState() {
    super.initState();
    FirebaseManager().setCurrentScreen('LandedOnHomeScreen');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppUpdateChecker().checkForUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: FirebaseManagerService.isDevelopment,
        builder: (context, isDev, _) {
          return FutureBuilder<Temple>(
            key: ValueKey(isDev),
            future: fetchTempleData(),
            builder: (context, snapshot) {
              //final temple = snapshot.data!;
              return Scaffold(
                backgroundColor: whiteColor,
                appBar: snapshot.connectionState == ConnectionState.waiting
                    ? PreferredSize(
                        preferredSize: const Size.fromHeight(42),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 21,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : PreferredSize(
                        preferredSize: const Size.fromHeight(42),
                        child: AppBar(
                          centerTitle: true,
                          backgroundColor: whiteColor,
                          forceMaterialTransparency: true,
                          title: (snapshot.hasData &&
                                  snapshot.data!.logo != null &&
                                  snapshot.data!.logo!.isNotEmpty)
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: snapshot.data!.logo!,
                                      height: 30,
                                      width: 30,
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      FirebaseManagerService.isDevelopment.value
                                          ? 'Yatrify (Dev)'
                                          : 'Yatrify',
                                      style: context.style.titleLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: fontcolor),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Yatrify',
                                  style: context.style.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: fontcolor),
                                ),
                          actions: [
                            IconButton(
                              onPressed: () async {
                                await Future.delayed(Duration.zero);
                                final url = Platform.isAndroid
                                    ? 'https://play.google.com/store/apps/details?id=com.yatrify.store'
                                    : 'https://apps.apple.com/app/idYOUR_APP_ID';

                                final text =
                                    'Check out this app on ${Platform.isAndroid ? 'Play Store' : 'App Store'}!';
                                final params = ShareParams(
                                  text: url,
                                  title: text,
                                );
                                await SharePlus.instance.share(params);
                                FirebaseManager().logEvent(
                                    FirebaseEvent.buttonClick,
                                    parameters: {'button_name': 'share'});
                              },
                              icon: const Icon(Icons.share),
                            ),
                            IconButton(
                              onPressed: () {
                                context.push(
                                  '/settings',
                                  extra: {
                                    'privacyPolicy':
                                        snapshot.data!.privacyPolicy,
                                    'termsAndCondition':
                                        snapshot.data!.termsAndCondition,
                                    'password': snapshot.data!.password,
                                  },
                                );
                              },
                              icon: const Icon(Icons.settings),
                            ),
                            // Switch(
                            //   activeThumbColor: Colors.green,
                            //   value: FirebaseManagerService.isDevelopment.value,
                            //   onChanged: (value) {
                            //     FirebaseManagerService.isDevelopment.value =
                            //         value;
                            //   },
                            // ),
                          ],
                        ),
                      ),
                body: snapshot.connectionState == ConnectionState.waiting
                    ? _buildShimmerPlaceholder(context)
                    : snapshot.hasError
                        ? Center(
                            child: Text('Error: ${snapshot.error}'),
                          )
                        : _buildTempleBody(context, snapshot.data!),
              );
            },
          );
        });
  }

  Widget _buildTempleBody(BuildContext context, Temple temple) {
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

    final todayTimings = getTimingsForToday(temple.timings);
    final hasMultipleBanners = (temple.smallBanner?.length ?? 0) > 1;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BannerCarousel(
              borderRadius: 24,
              banners: (temple.banner ?? []).map((tb) {
                return BaseBanner(
                  bannerImage: tb.bannerImage,
                  link: tb.link,
                );
              }).toList(),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const  TempleNameCard(),
              const SizedBox(height: 20),
              TempleTimingsCard(
                timings: todayTimings ??
                    Timings(
                      day: 'No timings today',
                      slots: [],
                      lunch: [],
                    ),
              ),
              if (temple.isSmallBannerShow &&
                  temple.smallBanner!.isNotEmpty) ...[
                const SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 120,
                    viewportFraction: hasMultipleBanners ? 0.81 : 1,
                    enableInfiniteScroll: hasMultipleBanners,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                  items: temple.smallBanner?.map((b) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: hasMultipleBanners ? 6 : 16),
                      child: SmallBannerCard(
                        image: b.bannerImage!,
                        url: b.link!,
                      ),
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
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
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: temple.services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      webLogo: temple.webLogo,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          NearByPlacesCard<NearByPlaces>(
            title: label.nearByPlaces,
            item: temple.nearByPlaces ?? [],
          ),
          const SizedBox(
            height: 16,
          ),
          WallpaperCard(
            wallpapers: temple.wallpapers ?? [],
            title: label.wallpapers,
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
          const SizedBox(height: 40),
        ],
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
