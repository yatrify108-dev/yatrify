import 'package:flutter/material.dart';

class PG {
  final List<PgBanner>? banners;
  final List<PgDetails> pgDetails;
  final List<ExploreNearByPlaces>? nearByPlaces;

  PG({
    this.banners,
    required this.pgDetails,
    this.nearByPlaces,
  });
}

class PgBanner {
  final String? bannerImage;
  final String? link;

  PgBanner({this.bannerImage, this.link});
}

class PgDetails {
  final List<String> roomImage;
  final List<Address> address;
  final List<PriceDetails> priceDetails;
  final List<Facilities>? facilities;
  final List<Services>? services;
  final String? note;
  final String aboutPG;
  final String gender;
  final String? ratings;
  final List<PgDetails>? exploreNearBy;

  PgDetails({
    required this.roomImage,
    required this.address,
    required this.priceDetails,
    this.facilities,
    required this.services,
    this.note,
    required this.aboutPG,
    required this.gender,
    this.ratings,
    this.exploreNearBy,
  });
}

class ExploreNearByPlaces {
  String title;
  String description;
  String image;
  Color color1;
  Color color2;

  ExploreNearByPlaces({
    required this.title,
    required this.description,
    required this.image,
    required this.color1,
    required this.color2,
  });
}

class Address {
  final String pgName;
  final String roadName;
  final String fullAddress;
  final String lat;
  final String long;
  final String phoneNo;

  Address({
    required this.pgName,
    required this.roadName,
    required this.fullAddress,
    required this.lat,
    required this.long,
    required this.phoneNo,
  });
}

class PriceDetails {
  final int bedNum;
  final double price;

  PriceDetails({required this.bedNum, required this.price});
}

class Facilities {
  final String name;
  final String icon;

  Facilities({required this.name, required this.icon});
}

class Services {
  final String name;
  final String icon;

  Services({required this.name, required this.icon});
}

final pgData = PG(
  banners: [
    PgBanner(
      bannerImage:
          "https://images.durian.in/Durian/durian/CategoryBanner/800x800/category_banner_20250531083634.jpg",
      link:
          "https://www.pepperfry.com/?srsltid=AfmBOoqIliPm7Fqa8jd8y6_5e281VS8NNMNL3ctGfIEE9JSMuiWI_1Wd",
    ),
    PgBanner(
      bannerImage:
          "https://images.durian.in/Durian/durian/CategoryBanner/800x800/category_banner_20250531083657.jpg",
      link:
          "https://www.durian.in/?srsltid=AfmBOoo34V9LebyCCN81G90p9Tf2pCw44bG6brf7RFfphOuobkO5ABpN",
    ),
    PgBanner(
      bannerImage:
          "https://bantia.in/cdn/shop/files/bantia_banner.png?v=1743180283&width=2000",
      link:
          "https://www.wakefit.co/dressing-table?srsltid=AfmBOor3EytUBHPTelwHfTtUVBcQ6L7GSsa0hHv3L0Kvbcb9z-tbYjZy",
    ),
    PgBanner(
      bannerImage:
          "https://www.hometown.in/cdn/shop/files/80_678c87a4-3be2-44a1-9a64-e948bfc5c6a7.png?v=1750486624",
      link:
          "https://www.hometown.in/?srsltid=AfmBOoqbYST00hsrKB4gkwxcC6qQ9I6oGi4M0JpKsuWfQ1-OgAEzPXc2",
    )
  ],
  nearByPlaces: [
    ExploreNearByPlaces(
      title: 'Adi Subramanya Temple',
      description: "Subramanya Swamy temple is located in Subramanya village, Sullia District. The district is near Mangalore and Karnataka. The prime deity here is Subramanya or Karthikeya, the son of Lord Shiva. The presiding Lord here is considered the master of all serpents; it is one of the untouched shrines in India.",
      image: "https://www.astroved.com/astropedia/assets/images/temples/adi-subramanya-temple.jpg",
      color1: const Color(0xff1f3c92),
      color2:const  Color(0xffac8950),
    ),
    ExploreNearByPlaces(
      title: 'Kumara Parvatha Trek',
      description: "Kumara Parvatha TrekKumara Parvatha Trek  Kumara Parvatha, located in the beautiful state of Karnataka, India, is a trekker's paradise and a haven for nature enthusiasts. This majestic peak, also known as Pushpagiri, stands tall at an impressive height of 1,712 meters (5,617 feet), making it the second-highest mountain in the Western Ghats. Renowned for its breathtaking landscapes, lush greenery, and thrilling trails, the Kumara Parvatha Trek offers an unforgettable adventure for those seeking to immerse themselves in the lap of nature.",
      image: "https://media1.thrillophilia.com/filestore/phgoo8etex49ioirzbqg01dusemp_bmckp9.jpg",
      color1: const Color(0xff188a8f),
      color2:const  Color(0xff835b40),
    ),
    ExploreNearByPlaces(
      title: 'Bisle View Point, Sakleshpur',
      description: "A favourite spot amongst nature lovers and about 1.5 hours from Sakleshpur, Bisle View Point offers breath-taking views of the three mountain ranges, Doddabetta, Pushpagiri and Kumaraparvatha.",
      image: "https://media1.thrillophilia.com/filestore/ldgirqglzscchoi18501coe3syt9_shutterstock_1292277949.jpg",
      color1: const Color(0xffceb69b),
      color2:const Color(0xff188a8f),
    ),
    ExploreNearByPlaces(
      title: 'Madikeri (Coorg)',
      description: "Madikeri is a hill town in southern India. Framed by the Western Ghats mountain range, it’s known for the Raja’s Seat, a simple monument overlooking forests and rice paddies. In the center, the 17th-century Madikeri Fort features 2 stone elephants at the entrance. Nearby, the domed Omkareshwar Temple is dedicated to the Hindu deity Shiva. To the northwest, cascading Abbey Falls is surrounded by spice plantations.",
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR800pM9SOoFapjzS_KYgJNvjhqbIFXMcZfizlEZCuEWxXHixbYJeYNY87gBpxWxd98ZXo&usqp=CAU",
      color1: const Color(0xff188a8f),
      color2:const  Color(0xff835b40),
    ),
  ],
  pgDetails: [
    PgDetails(
        roomImage: [
          "https://static.wixstatic.com/media/741467_a5f16a61ffd14ccf9d6d5620afb3c9f6~mv2.jpg/v1/fill/w_568,h_382,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/741467_a5f16a61ffd14ccf9d6d5620afb3c9f6~mv2.jpg",
          "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/v1669280525/Website/CMS-Uploads/JWS01032_3_4_yqujvd.jpg",
          "https://5.imimg.com/data5/SELLER/Default/2023/1/KK/KI/LI/32017596/new-product.jpeg",
          "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1661498935/Website/CMS-Uploads/rbioucc0vhi1d0pfelpq.jpg",
        ],
        address: [
          Address(
            pgName: "Sunshine Ladies PG",
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
        aboutPG: "Comfortable stay for working women with all amenities.",
        gender: "Female",
        ratings: "4.3",
        exploreNearBy: [
          PgDetails(
            roomImage: [
              "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1655388779/Website/CMS-Uploads/cw2q9mpx1we6tkib2m9q.jpg",
              "https://housing-images.n7net.in/01c16c28/420fafbf34314f3068604ec2fc62b348/v0/medium/3_rk_-for-rent-university_enclave-New+Delhi-double_sharing_room.jpg",
            ],
            address: [
              Address(
                pgName: "Elite Women's PG",
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
            aboutPG: "Premium stay for students and working professionals.",
            gender: "Female",
            ratings: "4.6",
          ),
          PgDetails(
            roomImage: [
              "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiVu2vi024Ru3pbhrsZUjrIbGFPn8VhK0xU2Q5imO4LusXFWxHTEo4vpM6wQRDh9b3vou8lR1R3SimSGwKksbDURp_4ZaWncQ4oRBg-9cRU2xV5VAxp0MRKv69GoReFTZJRbcav7Yp7LxF52Mq0EovTaV828wE6Xha1LqA4OGOpdwSn4xZ_UUZS3XSz/s1600/WhatsApp%20Image%202022-06-09%20at%206.39.15%20PM.jpeg",
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbC8LqrtA0augiB0CVq5NZ9g0BqH4epQY2KrvgkQJuqwmS1LFVm_7XULMBWfQ70Mn-qZ4&usqp=CAU",
            ],
            address: [
              Address(
                pgName: "TechNest Boys PG",
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
            aboutPG: "Secure and affordable accommodation for techies.",
            gender: "Male",
            ratings: "4.2",
          ),
          PgDetails(
            roomImage: [
              "https://wakeuphostels.in/wp-content/uploads/elementor/thumbs/ladies-pg-jayanagar-9th-block-near-metro-station-pcgrwhf63t6wr765lewnocz59zoctcfjg8b2omxb20.jpeg",
              "https://content.jdmagicbox.com/v2/comp/pune/y1/020pxx20.xx20.240624140355.f7y1/catalogue/royalty-living-vadgaon-budruk-pune-paying-guest-accommodations-for-women-7nqrtbyr1t-250.jpg",
            ],
            address: [
              Address(
                pgName: "Lavender Nest PG",
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
            aboutPG: "Lavish rooms with city view and all modern amenities.",
            gender: "Female",
            ratings: "4.8",
          ),
        ]),
    PgDetails(
      roomImage: [
        "https://img.cofynd.com/images/original/1c27b135dbdcd0353c3a385f00b99075ab47b989.jpg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1655707867/Website/CMS-Uploads/ewowywmjrbeprixllsr8.jpg",
        "https://5.imimg.com/data5/SELLER/Default/2021/7/LW/GK/GJ/86872258/modular-wooden-wardrobe.jpg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1658404448/Website/CMS-Uploads/znj6c8nud8no4bzr1mcv.jpg",
      ],
      address: [
        Address(
          pgName: "GreenStay Men's PG",
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
      aboutPG: "Affordable and clean PG near IT hubs.",
      gender: "Male",
      ratings: "4.0",
      exploreNearBy: [
        PgDetails(
          roomImage: [
            "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto/v1580375346/Website/CMS-Uploads/o4bf5h8z6cxtgnb6hvxj.jpg",
            "https://gsh-cdn.sgp1.cdn.digitaloceanspaces.com/assets/img/no-broker-pune/PRT585/room-on-rent-in-pune/pg-in-koregaon-park.jpg",
          ],
          address: [
            Address(
              pgName: "Budget Inn PG",
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
          aboutPG: "Budget-friendly PG ideal for college students.",
          gender: "Male",
          ratings: "3.9",
        ),
        PgDetails(
          roomImage: [
            "https://gsh-cdn.sgp1.cdn.digitaloceanspaces.com/assets/img/no-broker-pune/PRT603/room-on-rent-in-pune/pg-in-koregaon-park.jpg",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuVHOV0IHdFVsfLQddzl1krwZTeSHlHcjji7wWOBTRVx_JkCK7QWxf6e9ZUjgwjtlgbIM&usqp=CAU",
          ],
          address: [
            Address(
              pgName: "The Nest PG",
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
          aboutPG: "A peaceful PG located close to IT parks and malls.",
          gender: "Unisex",
          ratings: "4.4",
        ),
      ],
    ),
    PgDetails(
      roomImage: [
        "https://rook.gumlet.io/uploads/center/cover_photo/683445910027e400017caedd/CRMphoto_website_Laptop.jpeg?compress=true&format=auto&quality=75&dpr=auto&h=auto&w=390&ar=1",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1657105218/Website/CMS-Uploads/dxdorsr4nlukub1re0qt.jpg",
        "https://5.imimg.com/data5/SELLER/Default/2024/2/388241789/AE/ZL/SP/123688322/153a8983-5818-4060-8d2e-436962dd53bd.jpg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1654080041/Website/CMS-Uploads/uw40lruzwk2rrgkeaxku.jpg",
      ],
      address: [
        Address(
          pgName: "Unisex Cozy Stay",
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
      aboutPG: "A premium PG experience with full comfort.",
      gender: "Unisex",
      ratings: "4.5",
      exploreNearBy: [
        PgDetails(
          roomImage: [
            "https://urbanroomz.co.in/assets/packages_images/20231123043829-43-package_image1.jpeg",
            "https://gsh-cdn.sgp1.cdn.digitaloceanspaces.com/assets/img/no-broker-pune/PRT726/room-on-rent-in-pune/pg-in-baner_1701410236.jpg",
          ],
          address: [
            Address(
              pgName: "Urban Edge PG",
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
          aboutPG: "Modern interiors with vibrant community space.",
          gender: "Unisex",
          ratings: "4.1",
        ),
      ],
    ),
    PgDetails(
      roomImage: [
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1655460718/Website/CMS-Uploads/oaikzgjrommpxcssr9rl.jpg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/f_auto,q_auto/v1657010345/Website/CMS-Uploads/aovylf5qccupnd0jakek.jpg",
        "https://img.staticmb.com/mbphoto/pg/grd2/cropped_images/2023/Oct/13/Photo_h400_w540/GR2-401121-1914227_400_540.jpeg",
        "https://asset-cdn.stanzaliving.com/stanza-living/image/upload/f_auto,q_auto,w_600/e_improve/e_sharpen:10/e_saturation:10/v1680063871/Website/CMS-Uploads/IMG_3849_50_51-horz_rgs81p.jpg",
      ],
      address: [
        Address(
          pgName: "Budget Stay Boys PG",
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
      aboutPG: "Simple yet clean PG for budget-conscious residents.",
      gender: "Male",
      ratings: "3.8",
    ),
  ],
);
