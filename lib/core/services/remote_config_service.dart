import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final remoteConfig = FirebaseRemoteConfig.instance;

  static Future<DateTime?> getCalendarMaxDate() async {
  try {
    await remoteConfig.fetchAndActivate();
    String maxDateStr = remoteConfig.getString('calendar_max_date');
    print("Date from RemoteConfig: $maxDateStr");

    if (maxDateStr.isNotEmpty) {
      List<String> parts = maxDateStr.split('-');
      if (parts.length == 3) {
        final year = int.tryParse(parts[0]);
        final month = int.tryParse(parts[1]);
        final day = int.tryParse(parts[2]);
        if (year != null && month != null && day != null) {
          return DateTime(year, month, day);
        }
      }
    }

    // fallback
    return DateTime(2026, 4, 30);
  } catch (e) {
    print('Error fetching calendar max date: $e');
    return DateTime(2026, 3, 31);
  }
}

}
