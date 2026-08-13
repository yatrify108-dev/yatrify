import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yatrify/core/models/home_stay.dart';
import '../models/temple.dart';

Future<void> uploadTempleDataToFirebase(
    Temple templeData, FirebaseApp app) async {
  final firestore = FirebaseFirestore.instanceFor(app: app);
  final templeDoc = firestore.collection('temple').doc('temple_master');

  final templeMap = {
    'contactUs': templeData.contactUs,
    'logo': templeData.logo,
    'privacyPolicy': templeData.privacyPolicy,
    'termsAndCondition': templeData.termsAndCondition,
    'password': templeData.password,
    'webLogo': templeData.webLogo,
    'isSmallBannerShow': templeData.isSmallBannerShow,
    'isTextBanner': templeData.isTextBanner,
    'showBhajans': templeData.showBhajans,
    'showPoojaVideos': templeData.showPoojaVideos,
    'showWallpapers': templeData.showWallpapers,
    'showNearByPlaces': templeData.showNearByPlaces,
    'showYatriServices': templeData.showYatriServices,
    'showTimings': templeData.showTimings,
    'showBookStayBanner': templeData.showBookStayBanner,
    'bookStayBanner': templeData.bookStayBanner,
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
    'textBanner': templeData.textBanner
        ?.map((t) => {
              'bannerImage': t.bannerImage,
              'link': t.link,
              'details': t.details,
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
            'subTitle': {
              'en': s.subTitle?['en'] ?? '',
              'kn': s.subTitle?['kn'] ?? '',
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
            'showService': s.showService,
            'videos': s.videos
                ?.map((v) => {
                      'id': v.id,
                      'name': v.name,
                      'details': v.details,
                      'link': v.link,
                    })
                .toList(),
            'availableDateIds': s.availableDateIds,
            'unavailableDateIds': s.unavailableDateIds,
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
    'yatriServices': templeData.yatriServices
        ?.map(
          (y) => {
            'id': y.id,
            'name': {
              'en': y.name['en'],
              'kn': y.name['kn'],
            },
            'icon': y.icon,
            'subName': {
              'en': y.subName?['en'] ?? '',
              'kn': y.subName?['kn'] ?? '',
            },
            'showSevaInfoNote': y.showSevaInfoNote,
            'sevaInfoNoteText': {
              'en': y.sevaInfoNoteText?['en'] ?? '',
              'kn': y.sevaInfoNoteText?['kn'] ?? '',
            },
            'services': y.services
                ?.map(
                  (s) => {
                    'id': s.id,
                    'name': {
                      'en': s.name['en'],
                      'kn': s.name['kn'],
                    },
                    'subTitle': {
                      'en': s.subTitle?['en'] ?? '',
                      'kn': s.subTitle?['kn'] ?? '',
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
                    'showService': s.showService,
                    'videos': s.videos
                        ?.map((v) => {
                              'id': v.id,
                              'name': v.name,
                              'details': v.details,
                              'link': v.link,
                            })
                        .toList(),
                    'availableDateIds': s.availableDateIds,
                    'unavailableDateIds': s.unavailableDateIds,
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
          },
        )
        .toList(),
    'parkingModel': templeData.parkingModel
        ?.map(
          (p) => {
            'parkingTitle': {
              'en': p.parkingTitle['en'],
              'kn': p.parkingTitle['kn'],
            },
            'parkingSubtitle': {
              'en': p.parkingSubtitle?['en'] ?? '',
              'kn': p.parkingSubtitle?['kn'] ?? '',
            },
            'showParking': p.showParking,
            'trackTitle': {
              'en': p.trackTitle['en'],
              'kn': p.trackTitle['kn'],
            },
            'trackSubtitle': {
              'en': p.trackSubtitle?['en'] ?? '',
              'kn': p.trackSubtitle?['kn'] ?? '',
            },
          },
        )
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

Future<void> uploadHomeStayDataToFirebase(
  HomeStay homeStayData,
  FirebaseApp app,
) async {
  final firestore = FirebaseFirestore.instanceFor(app: app);
  final homeStayDoc = firestore.collection('homestay').doc('homestay_master');

  final homeStayMap = {
    'headerText': homeStayData.headerText,
    'banners': homeStayData.banners
        ?.map((b) => {
              'bannerImage': b.bannerImage,
              'link': b.link,
            })
        .toList(),
    'homeStayDetails': homeStayData.homeStayDetails
        .map((p) => {
              'roomImage': p.roomImage,
              'address': p.address
                  .map((a) => {
                        'homeStayName': a.homeStayName,
                        'roadName': a.roadName,
                        'fullAddress': a.fullAddress,
                        'lat': a.lat,
                        'long': a.long,
                        'phoneNo': a.phoneNo,
                      })
                  .toList(),
              'priceDetails': p.priceDetails
                  .map((pr) => {
                        'bedNum': pr.bedNum,
                        'price': pr.price,
                      })
                  .toList(),
              'facilities': p.facilities
                  ?.map((f) => {
                        'name': f.name,
                        'icon': f.icon,
                      })
                  .toList(),
              'services': p.services
                  ?.map((s) => {
                        'name': s.name,
                        'icon': s.icon,
                      })
                  .toList(),
              'note': p.note,
              'aboutHomeStay': p.aboutHomeStay,
              // 'gender': p.gender,
              'ratings': p.ratings,
              'distanceKm': p.distanceKm,
              'availabilityStatus': p.availabilityStatus,
              'exploreNearBy': p.exploreNearBy
                  ?.map((e) => {
                        'roomImage': e.roomImage,
                        'address': e.address
                            .map((a) => {
                                  'homeStayName': a.homeStayName,
                                  'roadName': a.roadName,
                                  'fullAddress': a.fullAddress,
                                  'lat': a.lat,
                                  'long': a.long,
                                  'phoneNo': a.phoneNo,
                                })
                            .toList(),
                        'priceDetails': e.priceDetails
                            .map((pr) => {
                                  'bedNum': pr.bedNum,
                                  'price': pr.price,
                                })
                            .toList(),
                        'facilities': e.facilities
                            ?.map((f) => {
                                  'name': f.name,
                                  'icon': f.icon,
                                })
                            .toList(),
                        'services': e.services
                            ?.map((s) => {
                                  'name': s.name,
                                  'icon': s.icon,
                                })
                            .toList(),
                        'note': e.note,
                        'aboutHomeStay': e.aboutHomeStay,
                        // 'gender': e.gender,
                        'ratings': e.ratings,
                        'distanceKm': e.distanceKm,
                        'availabilityStatus': e.availabilityStatus,
                      })
                  .toList(),
            })
        .toList(),
  };

  // 🔍 Preview JSON
  try {
    print('Home Stay JSON preview:');
    print(jsonEncode(homeStayMap));
  } catch (e) {
    print('Home stay JSON encode failed: $e');
    return;
  }

  try {
    print('Uploading Home Stay data...');
    await homeStayDoc.set(homeStayMap).timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw Exception('Home Stay upload timed out'),
        );
    print('Home Stay upload completed ✅');
  } catch (e) {
    print('Home Stay upload failed ❌: $e');
    rethrow;
  }
}
