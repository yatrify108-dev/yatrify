import 'package:bookstay/core/models/pg.dart';
import 'package:bookstay/core/models/temple.dart' as temple_model;
import 'package:bookstay/features/screens/about_page.dart';
import 'package:bookstay/features/screens/full_screen_image_gallery.dart';
import 'package:bookstay/features/screens/home_page.dart';
import 'package:bookstay/features/screens/nearby_places_view.dart';
import 'package:bookstay/features/screens/notification_screen.dart';
import 'package:bookstay/features/screens/pg_details_view.dart';
import 'package:bookstay/features/screens/redirect_page.dart';
import 'package:bookstay/features/screens/service_view_all.dart';
import 'package:bookstay/features/screens/services_details_view.dart';
import 'package:bookstay/features/screens/temple_home_page.dart';
import 'package:bookstay/features/screens/temple_timings_view.dart';
import 'package:bookstay/features/screens/temple_upload_screen.dart';
import 'package:bookstay/features/screens/video_player_page.dart';
import 'package:bookstay/features/screens/wallpaper_page.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/temple.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TempleHomePage(),
    ),
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const TempleUploadScreen(),
    // ),
    GoRoute(
      path: '/pg-details',
      builder: (context, state) {
        final pgDetails = state.extra as PgDetails;
        return PgDetailsView(pgDetails: pgDetails);
      },
    ),
    GoRoute(
      path: '/full-image-view',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return FullScreenImageGallery(
          images: extra['images'] as List<String>,
          initialIndex: extra['initialIndex'] as int,
          pgName: extra['pgName'] as String,
        );
      },
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        return AboutView(
            about: extra['about'] as String, pgName: extra['pgName'] as String);
      },
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/service-details',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final service = extra['service'] as temple_model.Services;
        final calendar = extra['calendar'] as Map<String, List<String>>;
        return ServicesDetailsView(
          service: service,
          calendar: calendar,
        );
      },
    ),
    GoRoute(
      path: '/video-player',
      builder: (context, state) {
        final videoUrl = state.extra as String;
        return VideoPlayerPage(videoUrl: videoUrl);
      },
    ),
    GoRoute(
      path: '/view-all-services',
      builder: (context, state) {
        final temple = state.extra as Temple;
        return ServiceViewAll(temple: temple);
      },
    ),
    GoRoute(
      path: '/temple-timings-view',
      builder: (context, state) {
        final timings = state.extra as Timings;
        return TempleTimingsView(timings: timings);
      },
    ),
    GoRoute(
      path: '/nearby-places-view',
      builder: (context, state) {
        final nearByPlaces = state.extra as NearByPlaces;
        return NearbyPlacesView(nearByPlaces: nearByPlaces);
      },
    ),
    GoRoute(
      path: '/redirect-page',
      builder: (context, state) {
        final url = state.extra as String;
        return RedirectPage(url: url);
      },
    ),
    GoRoute(
      path: '/walpaper-page',
      builder: (context, state) {
        final wallpapers = state.extra as Wallpapers;
        return WallpaperPage(wallpapers: wallpapers);
      },
    ),
  ],
);
