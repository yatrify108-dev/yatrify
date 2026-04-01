import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatrify/utils/extensions.dart';
import '../../utils/color.schemes.g.dart';

class AppUpdateChecker {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initConfig() async {
    try {
      final isDebug = kDebugMode;
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval:
              isDebug ? Duration.zero : const Duration(hours: 1),
        ),
      );

      await _remoteConfig.fetchAndActivate();
    } catch (e, stack) {
      debugPrint("RemoteConfig fetch failed: $e");
      debugPrintStack(stackTrace: stack);
    }
  }

  Future<void> checkForUpdate(BuildContext context) async {
    await initConfig();
    final packageInfo = await PackageInfo.fromPlatform();
    final int currentBuildNumber = int.parse(packageInfo.buildNumber);
    final bool isUpdateRequired = _remoteConfig.getBool('isUpdateRequired');
    final bool isForceUpdate = _remoteConfig.getBool('isForceUpdate');
    final bool isShowAlways = _remoteConfig.getBool('isShowAlways');

    final int latestBuildNumber = Platform.isAndroid
        ? _remoteConfig.getInt('androidBuildNumber')
        : _remoteConfig.getInt('iOSBuildNumber');

    if ((isUpdateRequired && latestBuildNumber > currentBuildNumber) ||
        isShowAlways) {
      await _showUpdateBottomSheet(context, isForceUpdate);
    }
  }

  Future<void> _showUpdateBottomSheet(
      BuildContext context, bool isForceUpdate) async {
    await showModalBottomSheet(
        context: context,
        isDismissible: !isForceUpdate,
        enableDrag: !isForceUpdate,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/app_update.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    if (!isForceUpdate)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'New update is available',
                  style: context.style.titleSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please update the app to enjoy our new features with a faster experience.',
                  style: context.style.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: () {
                    final url = Platform.isAndroid
                        ? 'https://play.google.com/store/apps/details?id=com.yatrify.store'
                        : 'https://apps.apple.com/app/idYOUR_APP_ID';
                    _launchURL(url);
                  },
                  child: const Text("Update Now"),
                ),
              ],
            ),
          );
        });
  }

  void _launchURL(String url) async {
    final Uri launchUri = Uri.parse(url);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }
}
