

import 'package:yatrify/environment/env.dart';

class MapConfig {

  // Used only for GoogleMap widget
  static const String devAndroidMapKey =
      "AIzaSyD7HULhAj6sakYwSe1UF2fw0pzaaqRo58A";

  static const String prodAndroidMapKey =
      "AIzaSyAo3BSsV5NEiRm7PKQmbBSYlj0oAFFYWvE";


  static const String devIosMapKey =
      "AIzaSyDdBJUVhihP3GzfdRwSovhGKRskoFNHaE8";

  static const String prodIosMapKey =
      "AIzaSyCC8QeaBu7Q1rLqFvymXb8mGkT_RFO9SL4";


  // Used for Nearby Places API
  static const String devPlacesKey =
      "AIzaSyBsmM9IQmJLsm2N57sgLjEvZ_WL03qsaEo";

  static const String prodPlacesKey =
      "AIzaSyBsPn1Ii7gut3NM6fAzkVHtoM3pnsev3yQ";


  static String get currentAndroidMapKey {
    return EnvironmentConfig.isDev
        ? devAndroidMapKey
        : prodAndroidMapKey;
  }


  static String get currentIosKey {
    return EnvironmentConfig.isDev
        ? devIosMapKey
        : prodIosMapKey;
  }


  static String get currentPlacesKey {
    return EnvironmentConfig.isDev
        ? devPlacesKey
        : prodPlacesKey;
  }
}