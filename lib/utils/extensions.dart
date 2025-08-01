import 'package:bookstay/core/models/pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:intl/intl.dart';

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

extension PriceDetailsExtensions on List<PriceDetails> {
  double get lowestPrice => map((p) => p.price).reduce((a, b) => a < b ? a : b);

  String get formatedLowestPrice => NumberFormat('#,##0').format(lowestPrice);
}

extension FormatePrice on num{
  String get formated => NumberFormat('#,##0').format(this);
}
