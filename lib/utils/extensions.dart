import 'package:yatrify/core/models/pg.dart';
import 'package:yatrify/l10n/app_localizations.dart';
import 'package:yatrify/l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get scheme => theme.colorScheme;
  TextTheme get style => theme.textTheme;

  AppLocalizations get labels => AppLocalizations.of(this)!;
  AppLocalizations get en => AppLocalizationsEn();

  void message(dynamic value) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: scheme.inverseSurface,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          content: Text(
            '$value',
            style: TextStyle(color: scheme.onInverseSurface),
          ),
        ),
      );
  }
}
enum MessageType { success, error, info }

void showTopMessage(
  BuildContext context,
  String message, {
  MessageType type = MessageType.success,
}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: type == MessageType.success
                ? Colors.green
                : type == MessageType.error
                    ? Colors.red
                    : Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}




extension PriceDetailsExtensions on List<PriceDetails> {
  double get lowestPrice => map((p) => p.price).reduce((a, b) => a < b ? a : b);

  String get formatedLowestPrice => NumberFormat('#,##0').format(lowestPrice);
}

extension FormatePrice on num{
  String get formated => NumberFormat('#,##0').format(this);
}


extension UrlLauncher on String?{
  Future<void> launch() async{
    final url = this;
    if(url == null || url.isEmpty){
      debugPrint("empty or null URL");
      return;
    }
    try {
      final Uri uri = Uri.parse(url);
      if(await canLaunchUrl(uri)){
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
      else{
        debugPrint("Could not launch $url");
      }
    } catch (e) {
      debugPrint("Invalid URL: $url");
    }
  }
}

extension StringNullCheckExtension on String?{
  bool get isNotNullOrEmpty  => this?.isNotEmpty ?? false;
}