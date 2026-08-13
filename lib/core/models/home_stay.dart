import 'package:flutter/material.dart';
import 'package:yatrify/utils/extensions.dart';

class HomeStay {
  final List<HomeStayBanner>? banners;
  final List<HomeStayDetails> homeStayDetails;
  final String headerText;
  

  HomeStay({
    this.banners,
    required this.homeStayDetails,
    required this.headerText,
  });

  factory HomeStay.fromMap(Map<String, dynamic> map) {
    return HomeStay(
      banners: map['banners'] != null
          ? (map['banners'] as List)
              .map((e) => HomeStayBanner.fromMap(e))
              .toList()
          : null,
      homeStayDetails: (map['homeStayDetails'] as List)
          .map((e) => HomeStayDetails.fromMap(e))
          .toList(),
          headerText: map['headerText'],
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'banners': banners?.map((e) => e.toMap()).toList(),
      'homeStayDetails': homeStayDetails.map((e) => e.toMap()).toList(),
      'headerText': headerText,
    };
  }
}


class HomeStayBanner {
  final String? bannerImage;
  final String? link;

  HomeStayBanner({this.bannerImage, this.link});

  factory HomeStayBanner.fromMap(Map<String, dynamic> map) {
    return HomeStayBanner(
      bannerImage: map['bannerImage'],
      link: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bannerImage': bannerImage,
      'link': link,
    };
  }
}


class HomeStayDetails {
  final List<String> roomImage;
  final List<Address> address;
  final List<PriceDetails> priceDetails;
  final List<Facilities>? facilities;
  final List<Services>? services;
  final String? note;
  final String aboutHomeStay;
  //final String //gender;
  final String? ratings;
  final List<HomeStayDetails>? exploreNearBy;
  final double? distanceKm;
  final String availabilityStatus;

  HomeStayDetails({
    required this.roomImage,
    required this.address,
    required this.priceDetails,
    this.facilities,
    this.services,
    this.note,
    required this.aboutHomeStay,
    //required this.//gender,
    this.ratings,
    this.exploreNearBy,
    this.distanceKm,
    required this.availabilityStatus
  });

  factory HomeStayDetails.fromMap(Map<String, dynamic> map) {
    return HomeStayDetails(
      roomImage: List<String>.from(map['roomImage']),
      address: (map['address'] as List)
          .map((e) => Address.fromMap(e))
          .toList(),
      priceDetails: (map['priceDetails'] as List)
          .map((e) => PriceDetails.fromMap(e))
          .toList(),
      facilities: map['facilities'] != null
          ? (map['facilities'] as List)
              .map((e) => Facilities.fromMap(e))
              .toList()
          : null,
      services: map['services'] != null
          ? (map['services'] as List)
              .map((e) => Services.fromMap(e))
              .toList()
          : null,
      note: map['note'],
      aboutHomeStay: map['aboutHomeStay'],
      ////gender: map['//gender'],
      ratings: map['ratings'],
      exploreNearBy: map['exploreNearBy'] != null
          ? (map['exploreNearBy'] as List)
              .map((e) => HomeStayDetails.fromMap(e))
              .toList()
          : null,
          distanceKm: map['distanceKm'] != null
    ? (map['distanceKm'] as num).toDouble()
    : null,
          availabilityStatus: map['availabilityStatus'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomImage': roomImage,
      'address': address.map((e) => e.toMap()).toList(),
      'priceDetails': priceDetails.map((e) => e.toMap()).toList(),
      'facilities': facilities?.map((e) => e.toMap()).toList(),
      'services': services?.map((e) => e.toMap()).toList(),
      'note': note,
      'aboutHomeStay': aboutHomeStay,
     // '//gender': //gender,
      'ratings': ratings,
      'exploreNearBy': exploreNearBy?.map((e) => e.toMap()).toList(),
      'distanceKm': distanceKm,
      'availabilityStatus': availabilityStatus,
    };
  }
}


class ExploreNearByPlaces {
  final String title;
  final String description;
  final String image;
  final Color color1;
  final Color color2;

  ExploreNearByPlaces({
    required this.title,
    required this.description,
    required this.image,
    required this.color1,
    required this.color2,
  });

  factory ExploreNearByPlaces.fromMap(Map<String, dynamic> map) {
    return ExploreNearByPlaces(
      title: map['title'],
      description: map['description'],
      image: map['image'],
      color1: colorFromHex(map['color1']),
      color2: colorFromHex(map['color2']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'color1': color1.toHex(),
      'color2': color2.toHex(),
    };
  }
}


class Address {
  final String homeStayName;
  final String roadName;
  final String fullAddress;
  final String lat;
  final String long;
  final String phoneNo;

  Address({
    required this.homeStayName,
    required this.roadName,
    required this.fullAddress,
    required this.lat,
    required this.long,
    required this.phoneNo,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      homeStayName: map['homeStayName'],
      roadName: map['roadName'],
      fullAddress: map['fullAddress'],
      lat: map['lat'],
      long: map['long'],
      phoneNo: map['phoneNo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'homeStayName': homeStayName,
      'roadName': roadName,
      'fullAddress': fullAddress,
      'lat': lat,
      'long': long,
      'phoneNo': phoneNo,
    };
  }
}


class PriceDetails {
  final int bedNum;
  final double price;

  PriceDetails({required this.bedNum, required this.price});

  factory PriceDetails.fromMap(Map<String, dynamic> map) {
    return PriceDetails(
      bedNum: map['bedNum'],
      price: (map['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bedNum': bedNum,
      'price': price,
    };
  }
}


class Facilities {
  final String name;
  final String icon;

  Facilities({required this.name, required this.icon});

  factory Facilities.fromMap(Map<String, dynamic> map) {
    return Facilities(
      name: map['name'],
      icon: map['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }
}

class Services {
  final String name;
  final String icon;

  Services({required this.name, required this.icon});

  factory Services.fromMap(Map<String, dynamic> map) {
    return Services(
      name: map['name'],
      icon: map['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }
}


final homeStayData = HomeStay(
  headerText: 'Hotel Listing',
  banners: [
    HomeStayBanner(
      bannerImage:
          "https://images.durian.in/Durian/durian/CategoryBanner/800x800/category_banner_20250531083634.jpg",
      link:
          "https://www.pepperfry.com/?srsltid=AfmBOoqIliPm7Fqa8jd8y6_5e281VS8NNMNL3ctGfIEE9JSMuiWI_1Wd",
    ),
    HomeStayBanner(
      bannerImage:
          "https://images.durian.in/Durian/durian/CategoryBanner/800x800/category_banner_20250531083657.jpg",
      link:
          "https://www.durian.in/?srsltid=AfmBOoo34V9LebyCCN81G90p9Tf2pCw44bG6brf7RFfphOuobkO5ABpN",
    ),
    HomeStayBanner(
      bannerImage:
          "https://bantia.in/cdn/shop/files/bantia_banner.png?v=1743180283&width=2000",
      link:
          "https://www.wakefit.co/dressing-table?srsltid=AfmBOor3EytUBHPTelwHfTtUVBcQ6L7GSsa0hHv3L0Kvbcb9z-tbYjZy",
    ),
    HomeStayBanner(
      bannerImage:
          "https://www.hometown.in/cdn/shop/files/80_678c87a4-3be2-44a1-9a64-e948bfc5c6a7.png?v=1750486624",
      link:
          "https://www.hometown.in/?srsltid=AfmBOoqbYST00hsrKB4gkwxcC6qQ9I6oGi4M0JpKsuWfQ1-OgAEzPXc2",
    )
  ],
 
  homeStayDetails: [
    HomeStayDetails(
      distanceKm: 0.2,
      availabilityStatus: 'available',
        roomImage: [
          "https://static.wixstatic.com/media/741467_a5f16a61ffd14ccf9d6d5620afb3c9f6~mv2.jpg/v1/fill/w_568,h_382,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/741467_a5f16a61ffd14ccf9d6d5620afb3c9f6~mv2.jpg",
          "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/v1669280525/Website/CMS-Uploads/JWS01032_3_4_yqujvd.jpg",
          "https://5.imimg.com/data5/SELLER/Default/2023/1/KK/KI/LI/32017596/new-product.jpeg",
          "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1661498935/Website/CMS-Uploads/rbioucc0vhi1d0pfelpq.jpg",
        ],
        address: [
          Address(
            homeStayName: "Sunshine Ladies PG",
            roadName: "MG Road",
            fullAddress:
                "No. 14, MG Road, Near Trinity Circle, Opposite Metro Station, Bangalore,  Karnataka 560001 ",
            lat: "13.340927",
            long: "74.742142",
            phoneNo: "+911111111111"
          )
        ],
        priceDetails: [
          PriceDetails(
            bedNum: 1,
            price: 7500,
          ),
          PriceDetails(bedNum: 2, price: 6500),
        ],
        facilities: [
          
          Facilities(
            name: "Washing Machine",
            icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png",
          ),
          Facilities(
            name: "Power Backup",
            icon: "https://files.logomakr.com/7UP2fa-LogoMakr.png",
          ),
          Facilities(
            name: "CCTV",
            icon: "https://files.logomakr.com/3NcPMQ-LogoMakr.png",
          ),
          
          Facilities(
            name: "WiFi",
            icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png",
          ),
        ],
        services: [
          Services(
            name: "Food (Veg)",
            icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png",
          ),
          Services(
            name: "Daily Cleaning",
            icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png",
          ),
        ],
        note: "Entry restricted after 10 PM",
        aboutHomeStay: "Comfortable stay for working women with all amenities.",
       // //gender: "Female",
        ratings: "4.3",
        exploreNearBy: [
          HomeStayDetails(
            distanceKm: 1.2,
           availabilityStatus: 'few_left',
            roomImage: [
              "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1655388779/Website/CMS-Uploads/cw2q9mpx1we6tkib2m9q.jpg",
              "https://housing-images.n7net.in/01c16c28/420fafbf34314f3068604ec2fc62b348/v0/medium/3_rk_-for-rent-university_enclave-New+Delhi-double_sharing_room.jpg",
            ],
            address: [
              Address(
                homeStayName: "Elite Women's PG",
                roadName: "Koramangala 5th Block",
                fullAddress: "123, 5th Block, Koramangala, Bangalore - 560095",
                lat: "12.9345",
                long: "77.6149",
                phoneNo: "+911111111111"
              )
            ],
            priceDetails: [
              PriceDetails(bedNum: 1, price: 8500),
              PriceDetails(bedNum: 2, price: 7300),
            ],
            facilities: [
              Facilities(
                  name: "WiFi",
                  icon: "https://files.logomakr.com/4SthrW-LogoMakr.png"),
              Facilities(
                  name: "AC",
                  icon: "https://files.logomakr.com/0C4stM-LogoMakr.png"),
            ],
            services: [
              Services(
                  name: "Meals Included",
                  icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png"),
              Services(
                  name: "Laundry",
                  icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png"),
            ],
            note: "Visitors allowed till 9 PM",
            aboutHomeStay: "Premium stay for students and working professionals.",
            //gender: "Female",
            ratings: "4.6",
          ),
          HomeStayDetails(
            distanceKm: 2,
      availabilityStatus: 'unavailable',
            roomImage: [
              "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVu2vi024Ru3pbhrsZUjrIbGFPn8VhK0xU2Q5imO4LusXFWxHTEo4vpM6wQRDh9b3vou8lR1R3SimSGwKksbDURp_4ZaWncQ4oRBg-9cRU2xV5VAxp0MRKv69GoReFTZJRbcav7Yp7LxF52Mq0EovTaV828wE6Xha1LqA4OGOpdwSn4xZ_UUZS3XSz/s1600/WhatsApp%20Image%202022-06-09%20at%206.39.15%20PM.jpeg",
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbC8LqrtA0augiB0CVq5NZ9g0BqH4epQY2KrvgkQJuqwmS1LFVm_7XULMBWfQ70Mn-qZ4&usqp=CAU",
            ],
            address: [
              Address(
                homeStayName: "TechNest Boys PG",
                roadName: "Electronic City",
                fullAddress:
                    "Near Infosys Gate 2, Electronic City Phase 1, Bangalore - 560100",
                lat: "12.8398",
                long: "77.6779",
                phoneNo: "+911111111111"
              )
            ],
            priceDetails: [
              PriceDetails(bedNum: 1, price: 6200),
              PriceDetails(bedNum: 2, price: 5400),
            ],
            facilities: [
              Facilities(
                  name: "Fridge",
                  icon: "https://files.logomakr.com/1fcies-LogoMakr.png"),
              Facilities(
                  name: "CCTV",
                  icon: "https://files.logomakr.com/3NcPMQ-LogoMakr.png"),
            ],
            services: [
              Services(
                  name: "Security",
                  icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png"),
            ],
            note: null,
            aboutHomeStay: "Secure and affordable accommodation for techies.",
            ////gender: "Male",
            ratings: "4.2",
          ),
          HomeStayDetails(
            distanceKm: 1.5,
      availabilityStatus: 'few_left',
            roomImage: [
              "https://wakeuphostels.in/wp-content/uploads/elementor/thumbs/ladies-pg-jayanagar-9th-block-near-metro-station-pcgrwhf63t6wr765lewnocz59zoctcfjg8b2omxb20.jpeg",
              "https://content.jdmagicbox.com/v2/comp/pune/y1/020pxx20.xx20.240624140355.f7y1/catalogue/royalty-living-vadgaon-budruk-pune-paying-guest-accommodations-for-women-7nqrtbyr1t-250.jpg",
            ],
            address: [
              Address(
                homeStayName: "Lavender Nest PG",
                roadName: "Indiranagar 100ft Road",
                fullAddress: "456, 100ft Road, Indiranagar, Bangalore - 560038",
                lat: "12.9711",
                long: "77.6411",
                phoneNo: "+911111111111"
              )
            ],
            priceDetails: [
              PriceDetails(bedNum: 1, price: 9500),
              PriceDetails(bedNum: 2, price: 8000),
            ],
            facilities: [
              Facilities(
                  name: "Attached Bathroom",
                  icon: "https://files.logomakr.com/7UP2fa-LogoMakr.png"),
              Facilities(
                  name: "TV",
                  icon: "https://files.logomakr.com/0C4stM-LogoMakr.png"),
            ],
            services: [
              Services(
                  name: "Daily Cleaning",
                  icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png"),
              Services(
                  name: "Housekeeping",
                  icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png"),
            ],
            note: "No entry post midnight",
            aboutHomeStay: "Lavish rooms with city view and all modern amenities.",
            ////gender: "Female",
            ratings: "4.8",
          ),
        ]),
    HomeStayDetails(
     // distanceKm: 0.2,
      availabilityStatus: 'unavailable',
      roomImage: [
        "https://img.cofynd.com/images/original/1c27b135dbdcd0353c3a385f00b99075ab47b989.jpg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1655707867/Website/CMS-Uploads/ewowywmjrbeprixllsr8.jpg",
        "https://5.imimg.com/data5/SELLER/Default/2021/7/LW/GK/GJ/86872258/modular-wooden-wardrobe.jpg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1658404448/Website/CMS-Uploads/znj6c8nud8no4bzr1mcv.jpg",
      ],
      address: [
        Address(
          homeStayName: "GreenStay Men's PG",
          roadName: "BTM Layout",
          fullAddress: "5th Cross, BTM Layout Stage 1, Bangalore 560076",
          lat: "12.9166",
          long: "77.6101",
          phoneNo: "+911111111111"
        ),
      ],
      priceDetails: [
        PriceDetails(bedNum: 1, price: 6800),
        PriceDetails(bedNum: 2, price: 5000),
        PriceDetails(bedNum: 3, price: 4500),
      ],
      facilities: [
        Facilities(
            name: "Fridge",
            icon: "https://files.logomakr.com/1fcies-LogoMakr.png"),
        Facilities(
            name: "24x7 Water",
            icon: "https://files.logomakr.com/4SthrW-LogoMakr.png"),
        Facilities(
            name: "Gym",
            icon: "https://files.logomakr.com/0C4stM-LogoMakr.png"),
        Facilities(
            name: "TV Lounge",
            icon: "https://files.logomakr.com/7UP2fa-LogoMakr.png"),
      ],
      services: [
        Services(
          name: "Laundry",
          icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png",
        ),
        Services(
          name: "Security",
          icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png",
        ),
      ],
      note: null,
      aboutHomeStay: "Affordable and clean PG near IT hubs.",
      //gender: "Male",
      ratings: "4.0",
      exploreNearBy: [
        HomeStayDetails(
         // distanceKm: 0.2,
      availabilityStatus: 'available',
          roomImage: [
            "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto/v1580375346/Website/CMS-Uploads/o4bf5h8z6cxtgnb6hvxj.jpg",
            "https://gsh-cdn.sgp1.cdn.digitaloceanspaces.com/assets/img/no-broker-pune/PRT585/room-on-rent-in-pune/pg-in-koregaon-park.jpg",
          ],
          address: [
            Address(
              homeStayName: "Budget Inn PG",
              roadName: "Bannerghatta Road",
              fullAddress: "89, Bannerghatta Main Rd, Bangalore - 560076",
              lat: "12.8923",
              long: "77.6051",
              phoneNo: "+911111111111"
            )
          ],
          priceDetails: [
            PriceDetails(bedNum: 2, price: 4000),
            PriceDetails(bedNum: 3, price: 3500),
          ],
          facilities: [
            Facilities(
                name: "Parking",
                icon: "https://files.logomakr.com/4SthrW-LogoMakr.png"),
          ],
          services: [
            Services(
                name: "Basic Cleaning",
                icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png"),
          ],
          note: "Only for college students",
          aboutHomeStay: "Budget-friendly PG ideal for college students.",
          //gender: "Male",
          ratings: "3.9",
        ),
        HomeStayDetails(
          distanceKm: 1.2,
      availabilityStatus: 'available',
          roomImage: [
            "https://gsh-cdn.sgp1.cdn.digitaloceanspaces.com/assets/img/no-broker-pune/PRT603/room-on-rent-in-pune/pg-in-koregaon-park.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuVHOV0IHdFVsfLQddzl1krwZTeSHlHcjji7wWOBTRVx_JkCK7QWxf6e9ZUjgwjtlgbIM&usqp=CAU",
          ],
          address: [
            Address(
              homeStayName: "The Nest PG",
              roadName: "Whitefield",
              fullAddress:
                  "12, Hope Farm Junction, Whitefield, Bangalore - 560066",
              lat: "12.9698",
              long: "77.7499",
              phoneNo: "+911111111111"
            )
          ],
          priceDetails: [
            PriceDetails(bedNum: 1, price: 7900),
            PriceDetails(bedNum: 2, price: 6900),
          ],
          facilities: [
            Facilities(
                name: "Power Backup",
                icon: "https://files.logomakr.com/7UP2fa-LogoMakr.png"),
            Facilities(
                name: "WiFi",
                icon: "https://files.logomakr.com/4SthrW-LogoMakr.png"),
          ],
          services: [
            Services(
                name: "Meals",
                icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png"),
          ],
          note: null,
          aboutHomeStay: "A peaceful PG located close to IT parks and malls.",
          //gender: "Unisex",
          ratings: "4.4",
        ),
      ],
    ),
    HomeStayDetails(
      distanceKm: 2.2,
      availabilityStatus: 'few_left',
      roomImage: [
        "https://rook.gumlet.io/uploads/center/cover_photo/683445910027e400017caedd/CRMphoto_website_Laptop.jpeg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=390&ar=1",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1657105218/Website/CMS-Uploads/dxdorsr4nlukub1re0qt.jpg",
        "https://5.imimg.com/data5/SELLER/Default/2024/2/388241789/AE/ZL/SP/123688322/153a8983-5818-4060-8d2e-436962dd53bd.jpg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1654080041/Website/CMS-Uploads/uw40lruzwk2rrgkeaxku.jpg",
      ],
      address: [
        Address(
          homeStayName: "Unisex Cozy Stay",
          roadName: "Indiranagar",
          fullAddress: "23, 1st Main, Indiranagar, Bangalore 560038",
          lat: "12.9711",
          long: "77.6408",
          phoneNo: "+911111111111"
        ),
      ],
      priceDetails: [
        PriceDetails(bedNum: 1, price: 8200),
        PriceDetails(bedNum: 2, price: 7000),
      ],
      facilities: [
        Facilities(
            name: "AC", icon: "https://files.logomakr.com/1fcies-LogoMakr.png"),
        Facilities(
            name: "WiFi",
            icon: "https://files.logomakr.com/4SthrW-LogoMakr.png"),
        Facilities(
            name: "TV", icon: "https://files.logomakr.com/0C4stM-LogoMakr.png"),
        Facilities(
            name: "Attached Bathroom",
            icon: "https://files.logomakr.com/7UP2fa-LogoMakr.png"),
      ],
      services: [
        Services(
          name: "Housekeeping",
          icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png",
        ),
        Services(
          name: "Breakfast Included",
          icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png",
        ),
      ],
      note: "Unisex rooms available. No smoking inside premises.",
      aboutHomeStay: "A premium PG experience with full comfort.",
      //gender: "Unisex",
      ratings: "4.5",
      exploreNearBy: [
        HomeStayDetails(
          distanceKm: 0.4,
      availabilityStatus: 'available',
          roomImage: [
            "https://urbanroomz.co.in/assets/packages_images/20231123043829-43-package_image1.jpeg",
            "https://gsh-cdn.sgp1.cdn.digitaloceanspaces.com/assets/img/no-broker-pune/PRT726/room-on-rent-in-pune/pg-in-baner_1701410236.jpg",
          ],
          address: [
            Address(
              homeStayName: "Urban Edge PG",
              roadName: "BTM 2nd Stage",
              fullAddress:
                  "2nd Stage, 7th Cross, BTM Layout, Bangalore - 560076",
              lat: "12.9180",
              long: "77.6104",
              phoneNo: "+911111111111"
            )
          ],
          priceDetails: [
            PriceDetails(bedNum: 1, price: 7000),
            PriceDetails(bedNum: 2, price: 6200),
          ],
          facilities: [
            Facilities(
                name: "TV Lounge",
                icon: "https://files.logomakr.com/0C4stM-LogoMakr.png"),
            Facilities(
                name: "Laundry",
                icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png"),
          ],
          services: [
            Services(
                name: "Security",
                icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png"),
          ],
          note: "Smoking not allowed inside rooms",
          aboutHomeStay: "Modern interiors with vibrant community space.",
          //gender: "Unisex",
          ratings: "4.1",
        ),
      ],
    ),
    HomeStayDetails(
      distanceKm: 0.2,
      availabilityStatus: 'available',
      roomImage: [
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1655460718/Website/CMS-Uploads/oaikzgjrommpxcssr9rl.jpg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1657010345/Website/CMS-Uploads/aovylf5qccupnd0jakek.jpg",
        "https://img.staticmb.com/mbphoto/pg/grd2/cropped_images/2023/Oct/13/Photo_h400_w540/GR2-401121-1914227_400_540.jpeg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/v1680063871/Website/CMS-Uploads/IMG_3849_50_51-horz_rgs81p.jpg",
      ],
      address: [
        Address(
          homeStayName: "Budget Stay Boys PG",
          roadName: "HSR Layout",
          fullAddress: "2nd Main Rd, Sector 2, HSR Layout, Bangalore 560102",
          lat: "12.9100",
          long: "77.6380",
          phoneNo: "+911111111111"
        ),
      ],
      priceDetails: [
        PriceDetails(bedNum: 2, price: 5000),
        PriceDetails(bedNum: 3, price: 4000),
      ],
      facilities: [
        Facilities(
            name: "Common Kitchen",
            icon: "https://files.logomakr.com/1fcies-LogoMakr.png"),
        Facilities(
            name: "Parking",
            icon: "https://files.logomakr.com/4SthrW-LogoMakr.png"),
        Facilities(
            name: "WiFi",
            icon: "https://files.logomakr.com/0C4stM-LogoMakr.png"),
      ],
      services: [
        Services(
          name: "Security",
          icon: "https://files.logomakr.com/6ZYyiY-LogoMakr.png",
        ),
        Services(
          name: "Maintenance Support",
          icon: "https://files.logomakr.com/4ifXCv-LogoMakr.png",
        ),
      ],
      note: "Budget-friendly option for students.",
      aboutHomeStay: "Simple yet clean PG for budget-conscious residents.",
      //gender: "Male",
      ratings: "3.8",
    ),
  ],
);