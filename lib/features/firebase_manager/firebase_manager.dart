import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class FirebaseManager {
  static final FirebaseManager _instance = FirebaseManager._internal();
  factory FirebaseManager() => _instance;
  FirebaseManager._internal();

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  static final remoteConfig = FirebaseRemoteConfig.instance;

  
  Future<void> initialize() async{
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    await _analytics.setAnalyticsCollectionEnabled(true);
  }

  Future<void> logEvent(FirebaseEvent event, {Map<String, Object>? parameters}) async{
    try{
      await _analytics.logEvent(name: event.name, parameters: parameters);
    }
    catch(e, stackTrace){
      await logException(e, stackTrace);
    }
  }

  Future<void> logException(Object error, StackTrace stackTrace) async{
    if(kDebugMode){
      debugPrint("Exception caught: $error");
    }
    await reportError(error, stackTrace);
  }

  Future<void> reportError(dynamic error, StackTrace stackTrace) async{
    try{
      await _crashlytics.recordError(error, stackTrace, fatal: false);
    }
    catch(e, stackTrace){
      debugPrint("Failed to log error: $e");
    }
  }

  Future<void> logMessage(String message) async{
    debugPrint("Firebase Log: $message");
    await logEvent(FirebaseEvent.logMessage, parameters: {'message': message});
  }

  Future<void> setCurrentScreen(String screenName) async{
    try{
      await _analytics.logScreenView(screenName: screenName);
    }
    catch(e, stackTrace){
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

enum FirebaseEvent{
  logMessage,
  buttonClick,
  videoClick,
  errorOccured
}