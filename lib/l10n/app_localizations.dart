import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @ratedOnGoogle.
  ///
  /// In en, this message translates to:
  /// **'Rated {rate} on Google'**
  String ratedOnGoogle(String rate);

  /// No description provided for @startsFrom.
  ///
  /// In en, this message translates to:
  /// **'Starts from'**
  String get startsFrom;

  /// No description provided for @viewDirections.
  ///
  /// In en, this message translates to:
  /// **'View Directions'**
  String get viewDirections;

  /// No description provided for @reserveNow.
  ///
  /// In en, this message translates to:
  /// **'RESERVE NOW'**
  String get reserveNow;

  /// No description provided for @requestACallBack.
  ///
  /// In en, this message translates to:
  /// **'REQUEST A CALLBACK'**
  String get requestACallBack;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// No description provided for @amenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get amenities;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @exploreNearyBy.
  ///
  /// In en, this message translates to:
  /// **'Explore Nearby Properties'**
  String get exploreNearyBy;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @scheduleVisit.
  ///
  /// In en, this message translates to:
  /// **'Schedule Visit'**
  String get scheduleVisit;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get noData;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get call;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @poojaVideos.
  ///
  /// In en, this message translates to:
  /// **'Pooja Videos'**
  String get poojaVideos;

  /// No description provided for @bhajans.
  ///
  /// In en, this message translates to:
  /// **'Bhajans'**
  String get bhajans;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get viewMore;

  /// No description provided for @availableDates.
  ///
  /// In en, this message translates to:
  /// **'Available Dates'**
  String get availableDates;

  /// No description provided for @templeTimings.
  ///
  /// In en, this message translates to:
  /// **'Temple Timings'**
  String get templeTimings;

  /// No description provided for @yatriServices.
  ///
  /// In en, this message translates to:
  /// **'Yatri Services'**
  String get yatriServices;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @forBlessings.
  ///
  /// In en, this message translates to:
  /// **'For blessings'**
  String get forBlessings;

  /// No description provided for @allYatriServices.
  ///
  /// In en, this message translates to:
  /// **'All Yatri Services'**
  String get allYatriServices;

  /// No description provided for @nearByPlaces.
  ///
  /// In en, this message translates to:
  /// **'Near By Places'**
  String get nearByPlaces;

  /// No description provided for @purpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purpose;

  /// No description provided for @timings.
  ///
  /// In en, this message translates to:
  /// **'Timings'**
  String get timings;

  /// No description provided for @dressCode.
  ///
  /// In en, this message translates to:
  /// **'Dress Code'**
  String get dressCode;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// No description provided for @tips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get tips;

  /// No description provided for @darshanTimings.
  ///
  /// In en, this message translates to:
  /// **'Darshan Timings'**
  String get darshanTimings;

  /// No description provided for @mealTimings.
  ///
  /// In en, this message translates to:
  /// **'Meal Timings'**
  String get mealTimings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
