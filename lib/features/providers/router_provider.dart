import 'package:yatrify/core/models/temple.dart' as temple_model;
import 'package:go_router/go_router.dart';
import 'package:yatrify/core/models/pg.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/features/screens/about_page.dart';
import 'package:yatrify/features/screens/audio_player_page.dart';
import 'package:yatrify/features/screens/bhajans_view_page.dart';
import 'package:yatrify/features/screens/contact_us_page.dart';
import 'package:yatrify/features/screens/full_screen_image_gallery.dart';
import 'package:yatrify/features/screens/nearby_places_view.dart';
import 'package:yatrify/features/screens/notification_screen.dart';
import 'package:yatrify/features/screens/pg_details_view.dart';
import 'package:yatrify/features/screens/redirect_page.dart';
import 'package:yatrify/features/screens/service_view_all.dart';
import 'package:yatrify/features/screens/services_details_view.dart';
import 'package:yatrify/features/screens/settings_page.dart';
import 'package:yatrify/features/screens/temple_home_page.dart';
import 'package:yatrify/features/screens/temple_timings_view.dart';
import 'package:yatrify/features/screens/temple_upload_screen.dart';
import 'package:yatrify/features/screens/video_player_page.dart';
import 'package:yatrify/features/screens/wallpaper_page.dart';

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
        final webLogo = extra['webLogo'] ?? '';
        return ServicesDetailsView(
          service: service,
          calendar: calendar,
          webLogo: webLogo,
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
        final extra = state.extra as Map<String, String>;
        final url = extra['url'] ?? '';
        final title = extra['title'];
        final subTitle = extra['subTitle'];
        final webLogo = extra['webLogo'] ?? '';
        return RedirectPage(
          url: url,
          title: title,
          subTitle: subTitle,
          webLogo: webLogo,
        );
      },
    ),
    GoRoute(
      path: '/walpaper-page',
      builder: (context, state) {
        final wallpapers = state.extra as Wallpapers;
        return WallpaperPage(wallpapers: wallpapers);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) {
        final extra = state.extra as Map<String, String?>;
        final privacyPolicy = extra['privacyPolicy'] ?? '';
        final termsAndCondition = extra['termsAndCondition'] ?? '';
        final password = extra['password'] ?? '';
        final contactUs = extra['contactUs'] ?? '';
        return SettingsPage(
          privacyPolicy: privacyPolicy,
          termsAndCondition: termsAndCondition,
          password: password,
          contactUs: contactUs,
        );
      },
    ),
    GoRoute(
      path: '/contact-us',
      builder: (context, state) {
        final contactUs = state.extra as String;

        return ContactUsPage(contactUs: contactUs);
      },
    ),
    // GoRoute(
    //   path: '/audio-player',
    //   builder: (context, state) {
    //     final args = state.extra as Map<String, dynamic>?;

    //     final bhajans = args?['bhajans'] as List<Bhajans>? ?? [];
    //     final index = args?['index'] as int? ?? 0;

    //     return AudioPlayerScreen(
    //       bhajans: bhajans,
    //       initialIndex: index,
    //     );
    //   },
    // ),
    GoRoute(
      path: '/audio-player',
      builder: (context, state) {
        return const AudioPlayerScreen();
      },
    ),
    GoRoute(
      path: '/view-bhajans',
      builder: (context, state) {
        final bhajans = state.extra as List<Bhajans>;
        return BhajansViewPage(bhajans: bhajans);
      },
    ),
  ],
);
