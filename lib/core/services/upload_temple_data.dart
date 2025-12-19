import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/temple.dart';

Future<void> uploadTempleDataToFirebase(
    Temple templeData, FirebaseApp app) async {
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
            'name': {
              'en': s.name['en'],
              'kn': s.name['kn'],
            },
            'icon': s.icon,
            'purpose': {
              'en': s.purpose?['en'] ?? '',
              'kn': s.purpose?['kn'] ?? '',
            },
            'details': {
              'en': s.details?['en'] ?? '',
              'kn': s.details?['kn'] ?? '',
            },
            'images': s.images,
            'bookNowButton': s.bookNowButton,
            'weblink': s.weblink,
            'rituals': {
              'en': s.rituals?['en'] ?? '',
              'kn': s.rituals?['kn'] ?? '',
            },
            'howToBook': s.howToBook,
            'fee': {
              'en': s.fee?['en'] ?? '',
              'kn': s.fee?['kn'] ?? '',
            },
            'tips': {
              'en': s.tips?['en'] ?? '',
              'kn': s.tips?['kn'] ?? '',
            },
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
            'otherSevas': {
              'en': s.otherSevas?['en'] ?? '',
              'kn': s.otherSevas?['kn'] ?? '',
            },
            // 'otherSevas': s.otherSevas
            //     ?.map((c) => {
            //           'categoryName': {
            //             'en': c.categoryName['en'],
            //             'kn': c.categoryName['kn'],
            //           },
            //           'sevas': c.sevas
            //               .map((seva) => {
            //                     'title': {
            //                       'en': seva.title['en'],
            //                       'kn': seva.title['kn'],
            //                     },
            //                   })
            //               .toList(),
            //         })
            //     .toList(),
            'rathotsavaSevaList': s.rathotsavaSevaList
                ?.map((r) => {
                      'name': {
                        'en': r.name['en'],
                        'kn': r.name['kn'],
                      },
                      'price': r.price,
                      'description': {
                        'en': r.description['en'],
                        'kn': r.description['kn'],
                      },
                    })
                .toList(),
            'note': {
              'en': s.note?['en'] ?? '',
              'kn': s.note?['kn'] ?? '',
            },
            'contactDetails': {
              'en': s.contactDetails?['en'] ?? '',
              'kn': s.contactDetails?['kn'] ?? '',
            },
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
              'name': {
                'en': v.name?['en'] ?? '',
                'kn': v.name?['kn'] ?? '',
              },
              'image': v.image,
              'url': v.url,
            })
        .toList(),
    'bhajans': templeData.bhajans
        ?.map((b) => {
              'name': {
                'en': b.name?['en'] ?? '',
                'kn': b.name?['kn'] ?? '',
              },
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
              'name': {
                'en': b.name?['en'] ?? '',
                'kn': b.name?['kn'] ?? '',
              },
              'images': b.images,
              'url': b.url,
              'description': {
                'en': b.description?['en'] ?? '',
                'kn': b.description?['kn'] ?? '',
              },
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
