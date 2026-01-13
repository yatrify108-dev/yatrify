import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/providers/router_provider.dart';
import 'package:yatrify/l10n/app_localizations.dart';
import 'package:yatrify/utils/color.schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseManagerService.init();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await LocaleService.loadLocale();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
        valueListenable: LocaleService.localeNotifier,
        builder: (context, locale, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Yatrify',
            theme: ThemeData(
              primaryColor: primaryColor,
              progressIndicatorTheme:
                  const ProgressIndicatorThemeData(color: primaryColor),
              // colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              useMaterial3: true,
            ),
            routerConfig: router,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        });
  }
}
