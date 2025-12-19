import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kn.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kn')
  ];

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

  /// No description provided for @openingBrowser.
  ///
  /// In en, this message translates to:
  /// **'Opening browser...'**
  String get openingBrowser;

  /// No description provided for @redirectingToVideo.
  ///
  /// In en, this message translates to:
  /// **'Redirecting to video...'**
  String get redirectingToVideo;

  /// No description provided for @openingWebsite.
  ///
  /// In en, this message translates to:
  /// **'Opening website...'**
  String get openingWebsite;

  /// No description provided for @redirectingToWebsite.
  ///
  /// In en, this message translates to:
  /// **'Redirecting to website...'**
  String get redirectingToWebsite;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get evening;

  /// No description provided for @bojana.
  ///
  /// In en, this message translates to:
  /// **'Bhojana'**
  String get bojana;

  /// No description provided for @darshanaOpen.
  ///
  /// In en, this message translates to:
  /// **'Darshana Open'**
  String get darshanaOpen;

  /// No description provided for @darshanaClose.
  ///
  /// In en, this message translates to:
  /// **'Darshana Closed'**
  String get darshanaClose;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get direction;

  /// No description provided for @rituals.
  ///
  /// In en, this message translates to:
  /// **'Rituals'**
  String get rituals;

  /// No description provided for @howToBook.
  ///
  /// In en, this message translates to:
  /// **'How to Book'**
  String get howToBook;

  /// No description provided for @specialDay.
  ///
  /// In en, this message translates to:
  /// **'Aslesha Nakshatra (Special Day)'**
  String get specialDay;

  /// No description provided for @ekadashi.
  ///
  /// In en, this message translates to:
  /// **'Ekadashi (Pooja Not Available)'**
  String get ekadashi;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @wallpapers.
  ///
  /// In en, this message translates to:
  /// **'Wallpapers'**
  String get wallpapers;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @poojaNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Pooja not available on Ekadashi'**
  String get poojaNotAvailable;

  /// No description provided for @pleaseSelectAnotherDate.
  ///
  /// In en, this message translates to:
  /// **'Please select another date'**
  String get pleaseSelectAnotherDate;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @specialPoojaDay.
  ///
  /// In en, this message translates to:
  /// **'Special Pooja Day'**
  String get specialPoojaDay;

  /// No description provided for @ashleshaNakshatraSpecialPooja.
  ///
  /// In en, this message translates to:
  /// **'Ashlesha Nakshatra – Special pooja available!'**
  String get ashleshaNakshatraSpecialPooja;

  /// No description provided for @poojaAvailable.
  ///
  /// In en, this message translates to:
  /// **'Pooja Available'**
  String get poojaAvailable;

  /// No description provided for @youCanBookPooja.
  ///
  /// In en, this message translates to:
  /// **'You can book pooja on this date'**
  String get youCanBookPooja;

  /// No description provided for @openingTemplesOfficialPage.
  ///
  /// In en, this message translates to:
  /// **'Opening temple’s official page'**
  String get openingTemplesOfficialPage;

  /// No description provided for @yourSpiritual.
  ///
  /// In en, this message translates to:
  /// **'your spiritual journey continues'**
  String get yourSpiritual;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @debug.
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get debug;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter password to enter debug mode.'**
  String get pleaseEnterPassword;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel;

  /// No description provided for @developerMode.
  ///
  /// In en, this message translates to:
  /// **'Developer Mode'**
  String get developerMode;

  /// No description provided for @debugMode.
  ///
  /// In en, this message translates to:
  /// **'Debug Mode'**
  String get debugMode;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @selectAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select App Language'**
  String get selectAppLanguage;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;
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
      <String>['en', 'kn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kn':
      return AppLocalizationsKn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
