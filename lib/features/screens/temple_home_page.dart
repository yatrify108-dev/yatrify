import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatrify/core/models/base_banner.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/bajana_audio_service.dart';
import 'package:yatrify/core/services/fetch_data.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/app_update/app_update.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/features/screens/parking_map_page.dart';
import 'package:yatrify/features/screens/settings_page.dart';
import 'package:yatrify/features/widgets/banner_carousel.dart';
import 'package:yatrify/features/widgets/mini_player.dart';
import 'package:yatrify/features/widgets/nearby_places.dart';
import 'package:yatrify/features/widgets/parking_widget.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AppUpdateChecker().checkForUpdate(context);
      final isFirstLaunch = await LocaleService.isFirstLaunch();
      if (isFirstLaunch) {
        showLanguageDialog(context);
        await LocaleService.setFirstLaunchDone();
      }
    });
  }

  // Future<void> openGoogleMap(double lat, double lng) async {
  //   final url =
  //       "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving";

  //   await launchUrl(
  //     Uri.parse(url),
  //     mode: LaunchMode.externalApplication,
  //   );
  // }

  void preloadImages(Temple temple) {
    for (var banner in temple.banner ?? []) {
      if (banner.bannerImage != null && banner.bannerImage!.isNotEmpty) {
        precacheImage(
          NetworkImage(banner.bannerImage!),
          context,
        );
      }
    }
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
              if (snapshot.hasData) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  preloadImages(snapshot.data!);
                });
              }
              //final temple = snapshot.data!;
              return Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: whiteColor,
                extendBody: true,
                bottomNavigationBar: ValueListenableBuilder<bool>(
                  valueListenable: BhajanAudioService.instance.showMiniPlayer,
                  builder: (context, show, _) {
                    return show
                        ? const SafeArea(
                            top: false,
                            child: MiniPlayer(),
                          )
                        : const SizedBox.shrink();
                  },
                ),
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
                          backgroundColor: Colors.transparent,
                          elevation: 0,
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

                                final String shareMessage = '''
*Yatrify* — Your complete guide for Kukke Shri Subrahmanya Temple 🛕

Stay informed, spiritually connected, and plan your visit with ease.

📥 *Download the app now:*
$url
''';

                                final params = ShareParams(
                                  text: shareMessage,
                                  subject:
                                      'Explore Kukke Subrahmanya Temple with Yatrify',
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
                                    'contactUs': snapshot.data!.contactUs,
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
    final textBanners = temple.textBanner ?? [];
    const double miniPlayerHeight = 74;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    const double bannerHeight = 0.45;
    const double overlap = 78;
    return ValueListenableBuilder<bool>(
        valueListenable: BhajanAudioService.instance.showMiniPlayer,
        builder: (context, show, _) {
          return Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: BannerCarousel(
                    showMainBanner: true,
                    // borderRadius: 24,
                    banners: (temple.banner ?? []).map((tb) {
                      return BaseBanner(
                        bannerImage: tb.bannerImage,
                        link: tb.link,
                      );
                    }).toList(),
                  )),
              SafeArea(
                  top: true,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.45 -
                                overlap,
                          ),
                        ),
                      ];
                    },
                    body: Container(
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: show
                              ? miniPlayerHeight + bottomSafeArea + 16
                              : bottomSafeArea + 16,
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // const  TempleNameCard(),
                                if (temple.showTimings == true) ...[
                                  const SizedBox(height: 20),
                                  TempleTimingsCard(
                                    timings: todayTimings ??
                                        Timings(
                                          day: 'No timings today',
                                          slots: [],
                                          lunch: [],
                                        ),
                                  ),
                                ],

                                if (temple.isSmallBannerShow &&
                                    temple.smallBanner!.isNotEmpty) ...[
                                  const SizedBox(height: 20),
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height: 120,
                                      viewportFraction:
                                          hasMultipleBanners ? 0.81 : 1,
                                      enableInfiniteScroll: hasMultipleBanners,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                    ),
                                    items: temple.smallBanner?.map((b) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                hasMultipleBanners ? 6 : 16),
                                        child: SmallBannerCard(
                                          image: b.bannerImage!,
                                          url: b.link!,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],

                                if ((temple.isTextBanner ?? false) &&
                                    textBanners.isNotEmpty) ...[
                                  const SizedBox(height: 20),
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height: 120,
                                      viewportFraction:
                                          hasMultipleBanners ? 0.81 : 1,
                                      enableInfiniteScroll: hasMultipleBanners,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                    ),
                                    items: temple.textBanner?.map((b) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                hasMultipleBanners ? 6 : 16),
                                        child: SmallBannerCard(
                                          image: b.bannerImage!,
                                          url: b.link!,
                                          details: b.details,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],

                                if (temple.showYatriServices == true) ...[
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
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
                                          style: context.style.titleMedium!
                                              .copyWith(
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
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 16),
                                  //   child: GridView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     itemCount: temple.yatriServices?.length,
                                  //     gridDelegate:
                                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                                  //       crossAxisCount: 2,
                                  //       crossAxisSpacing: 14,
                                  //       mainAxisSpacing: 14,
                                  //       childAspectRatio: 1.4,
                                  //       //childAspectRatio: 1.0,
                                  //     ),
                                  //     shrinkWrap: true,
                                  //     physics:
                                  //         const NeverScrollableScrollPhysics(),
                                  //     itemBuilder: (context, index) {
                                  //       final yatriServices = temple.yatriServices?[index];
                                  //       final service = temple.services;
                                  //       return ServiceCard(
                                  //         services: service,
                                  //         calender: temple.calender,
                                  //         webLogo: temple.webLogo,
                                  //         yatriServices: yatriServices!,
                                  //       );
                                  //     },
                                  //   ),
                                  // ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Builder(
                                      builder: (context) {
                                        final items =
                                            temple.yatriServices ?? [];

                                        // Filter items where showYatriService is explicitly true
                                        final activeServices = items
                                            .where((s) =>
                                                s.showYatriService == true)
                                            .take(4)
                                            .toList();

                                        if (activeServices.isEmpty) {
                                          return const SizedBox.shrink();
                                        }

                                        return IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children:
                                                activeServices.map((item) {
                                              return Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 3),
                                                  child: ServiceCard(
                                                    services:
                                                        temple.services ?? [],
                                                    calender: temple.calender,
                                                    webLogo: temple.webLogo,
                                                    yatriServices: item,
                                                    itemCount:
                                                        activeServices.length,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                                if (temple.parkingModel![0].showParking) ...[
                                  const SizedBox(height: 16),
                                  ParkingBannerWidget(
                                    parkingModel: temple.parkingModel![0],
                                  ),
                                ],


                                if (temple.showBookStayBanner == true &&
                                    temple.bookStayBanner != null &&
                                    temple.bookStayBanner!.isNotEmpty) ...[
                                  const SizedBox(height: 16),
                                  GestureDetector(
                                    onTap: () {
                                      context.push('/book-stay-home');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl: temple.bookStayBanner!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                            if (temple.showNearByPlaces == true &&
                                (temple.nearByPlaces?.isNotEmpty ?? false)) ...[
                              const SizedBox(height: 16),
                              NearByPlacesCard<NearByPlaces>(
                                title: label.nearByPlaces,
                                item: temple.nearByPlaces ?? [],
                              ),
                            ],
                            if (temple.showWallpapers == true &&
                                (temple.wallpapers?.isNotEmpty ?? false)) ...[
                              const SizedBox(
                                height: 16,
                              ),
                              WallpaperCard(
                                wallpapers: temple.wallpapers ?? [],
                                title: label.wallpapers,
                              ),
                            ],
                            if (temple.showPoojaVideos == true &&
                                (temple.videos?.isNotEmpty ?? false)) ...[
                              const SizedBox(height: 16),
                              TempleMediaWidget<PoojaVideos>(
                                title: label.poojaVideos,
                                item: temple.videos ?? [],
                              ),
                            ],
                            if (temple.showBhajans == true &&
                                (temple.bhajans?.isNotEmpty ?? false)) ...[
                              SizedBox(
                                  height: (temple.showPoojaVideos == true)
                                      ? 0
                                      : 16),
                              TempleMediaWidget<Bhajans>(
                                title: label.bhajans,
                                item: temple.bhajans ?? [],
                                showViewAll: true,
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  )),

              // const SizedBox(height: 40),
            ],
          );
        });
  }

  /// Shimmer Loader Widget
  Widget _buildShimmerPlaceholder(BuildContext context) {
    
    final baseShimmerColor = const Color(0xFFE0E0E0);
    final highlightShimmerColor = const Color(0xFFF5F5F5);

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
