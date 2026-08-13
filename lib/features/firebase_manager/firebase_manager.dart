import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';

/// Analytics Event Enums
enum FirebaseEvent {
  logMessage,
  buttonClick,
  videoClick,
  errorOccured,

  // Hotel / Stay Events
  bookStayClicked,
  landedOnListing,
  staySelected,
  stayCallClicked,
}

extension FirebaseEventExtension on FirebaseEvent {
  /// Converts enum values into standardized Firebase Event names.
  /// Automatically prefixes with 'dev_' if running in Development mode.
  String get eventName {
    final String prefix =
        FirebaseManagerService.isDevelopment.value ? 'dev_' : '';

    switch (this) {
      case FirebaseEvent.logMessage:
        return '${prefix}log_message';
      case FirebaseEvent.buttonClick:
        return '${prefix}button_click';
      case FirebaseEvent.videoClick:
        return '${prefix}video_click';
      case FirebaseEvent.errorOccured:
        return '${prefix}error_occurred';
      case FirebaseEvent.bookStayClicked:
        return '${prefix}book_stay_clicked';
      case FirebaseEvent.landedOnListing:
        return '${prefix}landed_on_listing';
      case FirebaseEvent.staySelected:
        return '${prefix}stay_selected';
      case FirebaseEvent.stayCallClicked:
        return '${prefix}stay_call_clicked';
    }
  }
}

class FirebaseManager {
  static final FirebaseManager _instance = FirebaseManager._internal();
  factory FirebaseManager() => _instance;
  FirebaseManager._internal();

  // ✅ Single default instance for mobile (prevents PlatformException)
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  static final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    await _analytics.setAnalyticsCollectionEnabled(true);

    // Set user property tag for Dev vs Prod identification
    final String env =
        FirebaseManagerService.isDevelopment.value ? 'DEV' : 'PROD';
    await setUserProperty('app_environment', env);
  }

  /// Base method to log custom events
  Future<void> logEvent(
    FirebaseEvent event, {
    Map<String, Object>? parameters,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint(
            "🔥 [Firebase Analytics] Logging: ${event.eventName} | Params: $parameters");
      }
      await _analytics.logEvent(
        name: event.eventName,
        parameters: parameters,
      );
    } catch (e, stackTrace) {
      await logException(e, stackTrace);
    }
  }

  // ============================================================
  // ⭐ HOTEL & STAY TRACKING EVENT HELPER METHODS
  // ============================================================

  /// 1. Trigger when user clicks 'Book Stay'
  Future<void> logBookStayClicked() async {
    await logEvent(FirebaseEvent.bookStayClicked);
  }

  /// 2. Trigger when user lands on the Hotel Listing screen
  Future<void> logLandedOnListing() async {
    await logEvent(FirebaseEvent.landedOnListing);
  }

  /// 3. Trigger when user selects a particular hotel card/item
  Future<void> logStaySelected({
    required String hotelName,
    String? hotelId,
    String? hotelContactNumber,
  }) async {
    final Map<String, Object> params = {
      'hotel_name': hotelName,
      if (hotelId != null && hotelId.isNotEmpty) 'hotel_id': hotelId,
      if (hotelContactNumber != null && hotelContactNumber.isNotEmpty)
        'hotel_contact_number': hotelContactNumber,
    };

    await logEvent(FirebaseEvent.staySelected, parameters: params);
  }

  /// 4. Trigger when user clicks the Call button inside hotel details
  Future<void> logStayCallClicked({
    required String hotelName,
    String? hotelId,
    String? hotelContactNumber,
  }) async {
    final Map<String, Object> params = {
      'hotel_name': hotelName,
      if (hotelId != null && hotelId.isNotEmpty) 'hotel_id': hotelId,
      if (hotelContactNumber != null && hotelContactNumber.isNotEmpty)
        'hotel_contact_number': hotelContactNumber,
    };

    await logEvent(FirebaseEvent.stayCallClicked, parameters: params);
  }

  // ============================================================
  // UTILITIES & CRASH REPORTING
  // ============================================================

  Future<void> logException(Object error, StackTrace stackTrace) async {
    if (kDebugMode) {
      debugPrint("Exception caught: $error");
    }
    await reportError(error, stackTrace);
  }

  Future<void> reportError(dynamic error, StackTrace stackTrace) async {
    try {
      await _crashlytics.recordError(error, stackTrace, fatal: false);
    } catch (e) {
      debugPrint("Failed to log error: $e");
    }
  }

  Future<void> logMessage(String message) async {
    debugPrint("Firebase Log: $message");
    await logEvent(FirebaseEvent.logMessage, parameters: {'message': message});
  }

  Future<void> setCurrentScreen(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);
    } catch (e, stackTrace) {
      await logException(e, stackTrace);
    }
  }

  Future<void> setUserProperty(String key, String value) async {
    try {
      await _analytics.setUserProperty(name: key, value: value);
    } catch (e, stackTrace) {
      await logException(e, stackTrace);
    }
  }

  Future<void> setUserId(String userID) async {
    try {
      await _analytics.setUserId(id: userID);
    } catch (e, stackTrace) {
      await logException(e, stackTrace);
    }
  }
}