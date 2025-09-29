import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/temple.dart';

Future<void> uploadTempleDataToFirebase(Temple templeData) async {
  final firestore = FirebaseFirestore.instance;
  final templeDoc = firestore.collection('temples').doc('temple_master');

  final templeMap = {
    'banner': templeData.banner
        ?.map((b) => {
              'bannerImage': b.bannerImage,
              'link': b.link,
            })
        .toList(),
    'services': templeData.services
        .map((s) => {
              'id': s.id,
              'name': s.name,
              'purpose': s.purpose,
              'details': s.details,
              'images': s.images,
              'bookNowButton': s.bookNowButton,
              'weblink': s.weblink,
              'timings': s.timings,
              'dressCode': s.dressCode,
              'fee': s.fee,
              'tips': s.tips,       
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
            })
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
              'bookNowButton': b.bookNowButton,
              'weblink': b.weblink,
            })
        .toList(),
        
  };

  // 🔍 Log it
  try {
    print("✅ JSON preview:");
    print(jsonEncode(templeMap)); // <-- if it crashes, bad data exists
  } catch (e) {
    print("❌ templeMap JSON encoding failed: $e");
    return;
  }

  // Upload with timeout
  try {
    print("🚀 Uploading...");
    await templeDoc.set(templeMap).timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw Exception("❌ Upload timed out"),
        );
    print("✅ Upload complete");
  } catch (e) {
    print("❌ Upload failed: $e");
    rethrow;
  }
}
