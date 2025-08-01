import 'package:bookstay/core/models/pg.dart';
import 'package:bookstay/features/screens/about_page.dart';
import 'package:bookstay/features/screens/full_screen_image_gallery.dart';
import 'package:bookstay/features/screens/home_page.dart';
import 'package:bookstay/features/screens/pg_details_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
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
  ],
);
