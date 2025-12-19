import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService {
  static const _key = 'app_locale';
  static const _firstLaunchKey = 'is_first_launch';

  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

  static Future<void> loadLocale() async{
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'en';
    localeNotifier.value = Locale(code);
  }

  static Future<void> setLocale(String code) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
    localeNotifier.value = Locale(code);
  }

  static String getLocalized(Map<String, String>? data) {
    final code = localeNotifier.value.languageCode;
    final value = data?[code];
    if(value != null && value.trim().isNotEmpty){
      return value;
    }
    return data?['en']?.trim().isNotEmpty == true ? data!['en']! : '';
  }

  static Future<bool> isFirstLaunch() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  static Future<void> setFirstLaunchDone() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
  }
}
