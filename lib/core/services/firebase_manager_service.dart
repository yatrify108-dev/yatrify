import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseManagerService {

  static const _debugKey = 'is_debug_mode';

  static FirebaseApp? prodApp;
  static FirebaseApp? devApp;

  static ValueNotifier<bool> isDevelopment = ValueNotifier(false);

  static FirebaseFirestore get prodFirestore =>
      FirebaseFirestore.instanceFor(app: prodApp!);

  static FirebaseFirestore get devFirestore =>
      FirebaseFirestore.instanceFor(app: devApp!);

  static FirebaseFirestore get currentFirestore =>
      isDevelopment.value ? devFirestore : prodFirestore;

  /// ============================================================
  /// INIT BOTH PROD + DEV ENVIRONMENTS
  /// ============================================================
  static Future<void> init() async {
    await _loadDebugMode();
    /// Initialize PRODUCTION (default)
    prodApp = await Firebase.initializeApp();

    /// Initialize DEVELOPMENT (Android + iOS)
    final devOptions = await _loadDevFirebaseOptions();

    devApp = await Firebase.initializeApp(
      name: "dev",
      options: devOptions,
    );

    /// Listen for changes & save automatically
    isDevelopment.addListener(_saveDebugMode);
  }

  /// ================= DEBUG MODE STORAGE =================
  static Future<void> _loadDebugMode() async {
    final prefs = await SharedPreferences.getInstance();
    isDevelopment.value = prefs.getBool(_debugKey) ?? false;
  }

  static Future<void> _saveDebugMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_debugKey, isDevelopment.value);
  }

  /// ============================================================
  /// LOAD DEV FIREBASE OPTIONS (iOS + Android)
  /// ============================================================
  static Future<FirebaseOptions> _loadDevFirebaseOptions() async {
    // ------------------------------------------------------------
    // ⭐ iOS → Load Dev plist from assets
    // ------------------------------------------------------------
    if (Platform.isIOS) {
      final xml = await rootBundle.loadString(
        'assets/firebase/GoogleService-Info-Dev.plist',
      );

      final map = _parsePlist(xml);

      return FirebaseOptions(
        apiKey: map['API_KEY'],
        appId: map['GOOGLE_APP_ID'],
        messagingSenderId: map['GCM_SENDER_ID'],
        projectId: map['PROJECT_ID'],
        storageBucket: map['STORAGE_BUCKET'],
        iosBundleId: map['BUNDLE_ID'],
        databaseURL: map['DATABASE_URL'],
      );
    }

    // ------------------------------------------------------------
    // ⭐ Android → Load Dev JSON from assets
    // ------------------------------------------------------------
    final jsonString = await rootBundle.loadString(
      'assets/firebase/google-services-dev.json',
    );

    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    final projectInfo = jsonMap['project_info'];
    final client = jsonMap['client'][0];
    final apiKey = client['api_key'][0]['current_key'];

    return FirebaseOptions(
      apiKey: apiKey,
      appId: client['client_info']['mobilesdk_app_id'],
      messagingSenderId: projectInfo['project_number'],
      projectId: projectInfo['project_id'],
      storageBucket: projectInfo['storage_bucket'],
    );
  }

  /// ============================================================
  /// HELPER → PARSE PLIST XML
  /// ============================================================
  static Map<String, dynamic> _parsePlist(String xml) {
    final regexp =
        RegExp(r'<key>(.*?)<\/key>\s*<string>(.*?)<\/string>', multiLine: true);

    final map = <String, dynamic>{};

    for (var m in regexp.allMatches(xml)) {
      map[m.group(1)!] = m.group(2)!;
    }

    return map;
  } 
}
