import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/temple.dart';

Future<void> uploadTempleDataToFirebase(Temple templeData, FirebaseApp app) async {
  final firestore = FirebaseFirestore.instanceFor(app: app);
  final templeDoc = firestore.collection('temple').doc('temple_master');

  final templeMap = {
    'logo': templeData.logo,
    'privacyPolicy': templeData.privacyPolicy,
    'termsAndCondition': templeData.termsAndCondition,
    'password': templeData.password,
    'webLogo': templeData.webLogo,
    'isSmallBannerShow': templeData.isSmallBannerShow,
    'banner': templeData.banner
        ?.map((b) => {
              'bannerImage': b.bannerImage,
              'link': b.link,
            })
        .toList(),
    'smallBanner': templeData.smallBanner
        ?.map((b) => {
              'bannerImage': b.bannerImage,
              'link': b.link,
            })
        .toList(),
    'services': templeData.services
        .map(
          (s) => {
            'id': s.id,
            'name': s.name,
            'icon': s.icon,
            'purpose': s.purpose,
            'details': s.details,
            'images': s.images,
            'bookNowButton': s.bookNowButton,
            'weblink': s.weblink,
            'rituals': s.rituals,
            'howToBook': s.howToBook,
            'fee': s.fee,
            'tips': s.tips,
            'calendarMaxDate': s.calendarMaxDate,
            'videos': s.videos
                ?.map((v) => {
                      'id': v.id,
                      'name': v.name,
                      'details': v.details,
                      'link': v.link,
                    })
                .toList(),
            'availableDateIds':
                s.availableDateIds?.map((id) => {'id': id}).toList(),
            'unavailableDateIds':
                s.unavailableDateIds?.map((id) => {'id': id}).toList(),
            'isCalendar': s.isCalendar,
            'otherSevas': s.otherSevas
                ?.map((c) => {
                      'categoryName': c.categoryName,
                      'sevas': c.sevas
                          .map((seva) => {
                                'title': seva.title,
                              })
                          .toList(),
                    })
                .toList(),
            'rathotsavaSevaList': s.rathotsavaSevaList
                ?.map((r) => {
                      'name': r.name,
                      'price': r.price,
                      'description': r.description,
                    })
                .toList(),
                'note': s.note,
                'contactDetails': s.contactDetails
          },
        )
        .toList(),
    'timings': templeData.timings
        .map((t) => {
              'day': t.day,
              'slots': t.slots
                  .map((slot) => {
                        'from': slot.from,
                        'to': slot.to,
                      })
                  .toList(),
              'lunch': t.lunch
                  .map((slot) => {
                        'from': slot.from,
                        'to': slot.to,
                      })
                  .toList(),
              'image': t.image
            })
        .toList(),
    'videos': templeData.videos
        ?.map((v) => {
              'name': v.name,
              'image': v.image,
              'url': v.url,
            })
        .toList(),
    'bhajans': templeData.bhajans
        ?.map((b) => {
              'name': b.name,
              'image': b.image,
              'url': b.url,
            })
        .toList(),
    'calender': templeData.calender?.map((key, value) => MapEntry(
          key,
          value,
        )),
    'nearByPlaces': templeData.nearByPlaces
        ?.map((b) => {
              'name': b.name,
              'images': b.images,
              'url': b.url,
              'description': b.description,
              'directionButton': b.directionButton,
              'weblink': b.weblink,
            })
        .toList(),
    'wallpapers': templeData.wallpapers
        ?.map((w) => {
              'shareTitle': w.shareTitle,
              'shareDescription': w.shareDescription,
              'image': w.image,
            })
        .toList(),
  };

  // 🔍 Log it
  try {
    print("JSON preview:");
    print(jsonEncode(templeMap));
  } catch (e) {
    print("JSON encoding failed: $e");
    return;
  }

  try {
    print("Uploading...");
    await templeDoc.set(templeMap).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw Exception("Upload timed out"),
    );

    print("Upload complete");
  } catch (e) {
    print("Upload failed: $e");
    rethrow;
  }

}
