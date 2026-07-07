// ignore_for_file: public_member_api_docs, sort_constructors_first

class Temple {
  final String? logo;
  final String? contactUs;
  final String webLogo;
  final List<TempleBanner>? banner;
  final List<SmallBanner>? smallBanner;
  final List<Services> services;
  final List<Timings> timings;
  final List<PoojaVideos>? videos;
  final List<Bhajans>? bhajans;
  final Map<String, List<String>>? calender;
  final List<NearByPlaces>? nearByPlaces;
  final List<Wallpapers>? wallpapers;
  final bool isSmallBannerShow;
  final String? privacyPolicy;
  final String? termsAndCondition;
  final String? password;
  final bool? isTextBanner;
  final List<TextBanner>? textBanner;
  final bool? showBhajans;
  final bool? showPoojaVideos;
  final bool? showWallpapers;
  final bool? showNearByPlaces;
  final bool? showYatriServices;
  final bool? showTimings;

  Temple(
      {required this.webLogo,
      this.logo,
      this.contactUs,
      this.banner,
      this.smallBanner,
      required this.services,
      required this.timings,
      this.videos,
      this.bhajans,
      this.calender,
      this.nearByPlaces,
      this.wallpapers,
      required this.isSmallBannerShow,
      this.privacyPolicy,
      this.termsAndCondition,
      this.password,
      this.isTextBanner,
      this.textBanner,
      this.showBhajans,
      this.showPoojaVideos,
      this.showWallpapers,
      this.showNearByPlaces,
      this.showYatriServices,
      this.showTimings,
      });

  factory Temple.fromMap(Map<String, dynamic> map) {
    return Temple(
      webLogo: map['webLogo'] ?? '',
      logo: map['logo'],
      contactUs: map['contactUs'],
      banner: (map['banner'] as List?)
          ?.map((b) => TempleBanner.fromMap(b))
          .toList(),
      smallBanner: (map['smallBanner'] as List?)
          ?.map((b) => SmallBanner.fromMap(b))
          .toList(),
      services:
          (map['services'] as List).map((s) => Services.fromMap(s)).toList(),
      timings: (map['timings'] as List).map((t) => Timings.fromMap(t)).toList(),
      videos:
          (map['videos'] as List?)?.map((v) => PoojaVideos.fromMap(v)).toList(),
      bhajans:
          (map['bhajans'] as List?)?.map((b) => Bhajans.fromMap(b)).toList(),
      calender: (map['calender'] as Map?)?.map(
          (key, value) => MapEntry(key.toString(), List<String>.from(value))),
      nearByPlaces: (map['nearByPlaces'] as List?)
          ?.map((b) => NearByPlaces.fromMap(b))
          .toList(),
      wallpapers: (map['wallpapers'] as List?)
          ?.map((w) => Wallpapers.fromMap(w))
          .toList(),
      isSmallBannerShow: map['isSmallBannerShow'],
      privacyPolicy: map['privacyPolicy'],
      termsAndCondition: map['termsAndCondition'],
      password: map['password'],
      isTextBanner: map['isTextBanner'],
      textBanner: (map['textBanner'] as List?)
          ?.map((b) => TextBanner.fromMap(b))
          .toList(),
          showBhajans: map['showBhajans'],
          showPoojaVideos: map['showPoojaVideos'],
          showWallpapers: map['showWallpapers'],
          showNearByPlaces: map['showNearByPlaces'],
          showYatriServices: map['showYatriServices'],
          showTimings: map['showTimings'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'contactUs': contactUs,
      'logo': logo,
      'webLogo': webLogo,
      'banner': banner?.map((b) => b.toMap()).toList(),
      'smallBanner': smallBanner?.map((b) => b.toMap()).toList(),
      'services': services.map((b) => b.toMap()).toList(),
      'timings': timings.map((b) => b.toMap()).toList(),
      'videos': videos?.map((b) => b.toMap()).toList(),
      'bhajans': bhajans?.map((b) => b.toMap()).toList(),
      'calender': calender,
      'nearByPlaces': nearByPlaces?.map((n) => n.toMap()).toList(),
      'wallpapers': wallpapers?.map((w) => w.toMap()).toList(),
      'isSmallBannerShow': isSmallBannerShow,
      'isTextBanner': isTextBanner,
      'textBanner': textBanner?.map((b) => b.toMap()).toList(),
      'showBhajans': showBhajans,
      'showPoojaVideos': showPoojaVideos,
      'showWallpapers': showWallpapers,
      'showNearByPlaces': showNearByPlaces,
      'showYatriServices': showYatriServices,
      'showTimings': showTimings,
    };
  }
}

class Wallpapers {
  final String shareTitle;
  final String shareDescription;
  final String image;

  Wallpapers({
    required this.shareTitle,
    required this.shareDescription,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shareTitle': shareTitle,
      'shareDescription': shareDescription,
      'image': image,
    };
  }

  factory Wallpapers.fromMap(Map<String, dynamic> map) {
    return Wallpapers(
      shareTitle: map['shareTitle'] as String,
      shareDescription: map['shareDescription'] as String,
      image: map['image'] as String,
    );
  }
}

class NearByPlaces {
  final Map<String, String>? name;
  final List<String>? images;
  final String? url;
  final Map<String, String>? description;
  final bool directionButton;
  final String weblink;

  NearByPlaces({
    this.name,
    this.images,
    this.url,
    required this.description,
    required this.directionButton,
    required this.weblink,
  });

  factory NearByPlaces.fromMap(Map<String, dynamic> map) {
    // Convert name and description to Map<String, String> safely
    Map<String, String>? nameMap;
    Map<String, String>? descMap;

    if (map['name'] != null) {
      nameMap = Map<String, String>.from(map['name']);
    }

    if (map['description'] != null) {
      descMap = Map<String, String>.from(map['description']);
    }

    return NearByPlaces(
      name: nameMap,
      images: List<String>.from(map['images'] ?? []),
      url: map['url'],
      description: descMap,
      directionButton:
          map['directionButton']?.toString().toLowerCase() == 'true',
      weblink: map['weblink'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name, // Already Map<String, String>
      'images': images,
      'url': url,
      'description': description, // Already Map<String, String>
      'directionButton': directionButton,
      'weblink': weblink,
    };
  }
}

class TempleBanner {
  final String? bannerImage;
  final String? link;

  TempleBanner({
    this.bannerImage,
    this.link,
  });

  factory TempleBanner.fromMap(Map<String, dynamic> map) {
    return TempleBanner(
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

class SmallBanner {
  final String? bannerImage;
  final String? link;

  SmallBanner({
    this.bannerImage,
    this.link,
  });

  factory SmallBanner.fromMap(Map<String, dynamic> map) {
    return SmallBanner(
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

class TextBanner {
  final String? bannerImage;
  final String? link;
  final String? details;

  TextBanner({
    this.bannerImage,
    this.link,
    this.details,
  });

  factory TextBanner.fromMap(Map<String, dynamic> map) {
    return TextBanner(
      bannerImage: map['bannerImage'],
      link: map['link'],
      details: map['details'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'bannerImage': bannerImage, 'link': link, 'details': details};
  }
}

class Services {
  final String id;
  final Map<String, String> name;
  final String icon;
  final Map<String, String>? purpose;
  final Map<String, String>? details;
  final List<ServiceVideo>? videos;
  final List<String>? availableDateIds;
  final List<String>? unavailableDateIds;
  final List<String> images;
  final bool bookNowButton;
  final String weblink;
  final Map<String, String>? rituals;
  final Map<String, String>? howToBook;
  final Map<String, String>? fee;
  final Map<String, String>? tips;
  final bool? isCalendar;
  //final List<SevaCategory>? otherSevas;
  final Map<String, String>? otherSevas;
  final String calendarMaxDate;
  final List<RathotsavaSevaList>? rathotsavaSevaList;
  final Map<String, String>? note;
  final Map<String, String>? contactDetails;

  Services({
    required this.id,
    required this.name,
    required this.icon,
    this.purpose,
    this.details,
    this.videos,
    this.availableDateIds,
    this.unavailableDateIds,
    required this.images,
    required this.bookNowButton,
    required this.weblink,
    this.rituals,
    this.howToBook,
    this.fee,
    this.tips,
    this.isCalendar,
    this.otherSevas,
    required this.calendarMaxDate,
    this.rathotsavaSevaList,
    this.note,
    this.contactDetails,
  });

  factory Services.fromMap(Map<String, dynamic> map) {
    Map<String, String>? parseText(Map? m) =>
        m?.map((key, value) => MapEntry(key.toString(), value.toString()));

    return Services(
      id: map['id'] ?? '',
      name: parseText(map['name'] as Map?) ?? {'en': '', 'kn': ''},
      icon: map['icon'] ?? '',
      purpose: parseText(map['purpose'] as Map?),
      details: parseText(map['details'] as Map?),
      videos: (map['videos'] as List?)
              ?.map((v) => ServiceVideo.fromMap(v))
              .toList() ??
          [],
      availableDateIds: (map['availableDateIds'] as List?)
              ?.map((d) => d.toString())
              .toList() ??
          [],
      unavailableDateIds: (map['unavailableDateIds'] as List?)
              ?.map((d) => d.toString())
              .toList() ??
          [],
      bookNowButton: map['bookNowButton']?.toString().toLowerCase() == 'true',
      images: List<String>.from(map['images'] ?? []),
      weblink: map['weblink'] ?? '',
      rituals: parseText(map['rituals'] as Map?),
      howToBook: parseText(map['howToBook'] as Map?),
      fee: parseText(map['fee'] as Map?),
      tips: parseText(map['tips'] as Map?),
      isCalendar: map['isCalendar'],
      otherSevas: parseText(map['otherSevas'] as Map?),
      // otherSevas: (map['otherSevas'] as List?)
      //     ?.map((c) => SevaCategory.fromMap(c))
      //     .toList(),
      calendarMaxDate: map['calendarMaxDate'] ?? '',
      rathotsavaSevaList: (map['rathotsavaSevaList'] as List?)
              ?.map((v) => RathotsavaSevaList.fromMap(v))
              .toList() ??
          [],
      note: parseText(map['note'] as Map?),
      contactDetails: parseText(map['contactDetails'] as Map?),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'purpose': purpose,
      'details': details,
      'videos': videos?.map((videos) => videos.toMap()).toList(),
      'availableDateIds': availableDateIds,
      'unavailableDateIds': unavailableDateIds,
      'bookNowButton': bookNowButton,
      'images': images,
      'weblink': weblink,
      'rituals': rituals,
      'howToBook': howToBook,
      'fee': fee,
      'tips': tips,
      'isCalendar': isCalendar,
      'otherSevas': otherSevas,
      //'otherSevas': otherSevas?.map((c) => c.toMap()).toList(),
      'calendarMaxDate': calendarMaxDate,
      'rathotsavaSevaList': rathotsavaSevaList?.map((r) => r.toMap()).toList(),
      'note': note,
      'contactDetails': contactDetails
    };
  }
}

class RathotsavaSevaList {
  final Map<String, String> name;
  final String? price;
  final Map<String, String> description;

  RathotsavaSevaList({
    required this.name,
    this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'description': description,
    };
  }

  factory RathotsavaSevaList.fromMap(Map<String, dynamic> map) {
    Map<String, String>? parseText(Map? m) =>
        m?.map((key, value) => MapEntry(key.toString(), value.toString()));
    return RathotsavaSevaList(
      name: parseText(map['name'] as Map?) ?? {'en': '', 'kn': ''},
      price: map['price'] != null ? map['price'] as String : null,
      description:
          parseText(map['description'] as Map?) ?? {'en': '', 'kn': ''},
    );
  }
}

class SevaCategory {
  final Map<String, String> categoryName;
  final List<SevaItem> sevas;

  SevaCategory({
    required this.categoryName,
    required this.sevas,
  });

  factory SevaCategory.fromMap(Map<String, dynamic> map) {
    Map<String, String>? parseText(Map? m) =>
        m?.map((key, value) => MapEntry(key.toString(), value.toString()));
    return SevaCategory(
      categoryName:
          parseText(map['categoryName'] as Map?) ?? {'en': '', 'kn': ''},
      sevas: (map['sevas'] as List? ?? [])
          .map((e) => SevaItem.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'categoryName': categoryName,
        'sevas': sevas.map((e) => e.toMap()).toList(),
      };
}

class SevaItem {
  final Map<String, String> title;

  SevaItem({
    required this.title,
  });

  factory SevaItem.fromMap(Map<String, dynamic> map) {
    Map<String, String>? parseText(Map? m) =>
        m?.map((key, value) => MapEntry(key.toString(), value.toString()));
    return SevaItem(
      title: parseText(map['title'] as Map?) ?? {'en': '', 'kn': ''},
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
      };
}

class ServiceVideo {
  final String id;
  final String name;
  final String details;
  final String link;

  ServiceVideo({
    required this.id,
    required this.name,
    required this.details,
    required this.link,
  });

  factory ServiceVideo.fromMap(Map<String, dynamic> map) {
    return ServiceVideo(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      details: map['Details'] ?? '',
      link: map['link'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'Details': details,
      'link': link,
    };
  }
}

class Timings {
  final String day;
  final List<TimeSlot> slots;
  final List<TimeSlot> lunch;
  final String? image;

  Timings(
      {required this.day,
      required this.slots,
      required this.lunch,
      this.image});

  factory Timings.fromMap(Map<String, dynamic> map) {
    return Timings(
      day: map['day'] ?? '',
      slots: (map['slots'] as List? ?? [])
          .map((x) => TimeSlot.fromMap(x))
          .toList(),
      lunch: (map['lunch'] as List? ?? [])
          .map((x) => TimeSlot.fromMap(x))
          .toList(),
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'slots': slots.map((slot) => slot.toMap()).toList(),
      'lunch': slots.map((slot) => slot.toMap()).toList(),
      'image': image,
    };
  }
}

class TimeSlot {
  final String from;
  final String to;

  TimeSlot({
    required this.from,
    required this.to,
  });

  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      from: map['from'],
      to: map['to'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'slots': to,
    };
  }
}

class PoojaVideos {
  final Map<String, String>? name;
  final String? image;
  final String? url;

  PoojaVideos({
    this.name,
    this.image,
    this.url,
  });

  factory PoojaVideos.fromMap(Map<String, dynamic> map) {
    Map<String, String>? parseText(Map? m) =>
        m?.map((key, value) => MapEntry(key.toString(), value.toString()));
    return PoojaVideos(
      name: parseText(map['name'] as Map?),
      image: map['image'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'url': url,
    };
  }
}

class Bhajans {
  final Map<String, String>? name;
  final String? image;
  final String? url;

  Bhajans({
    this.name,
    this.image,
    this.url,
  });

  factory Bhajans.fromMap(Map<String, dynamic> map) {
    Map<String, String>? parseText(Map? m) =>
        m?.map((key, value) => MapEntry(key.toString(), value.toString()));
    return Bhajans(
      name: parseText(map['name'] as Map?),
      image: map['image'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'url': url,
    };
  }
}

// Development
final templeData = Temple(
  isTextBanner: true,
  contactUs: 'qayatri028@gmail.com',
  password: 'Kukke2\$2*?!',
  privacyPolicy: 'https://sites.google.com/view/yatrify',
  termsAndCondition: 'https://sites.google.com/view/yatrify-terms-conditions',
  webLogo:
      'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760338098/weblogo_bo09n0.png',
  isSmallBannerShow: true,
  logo:
      'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760333124/logo_k8ljmu.png',
  banner: [
    TempleBanner(
      bannerImage:
          // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
          // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759465403/banner_lfafdc.jpg',
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759736124/banner1_pfpvjl.jpg',
      link: '',
    ),
  ],
  smallBanner: [
    SmallBanner(
      bannerImage:
          'https://res.cloudinary.com/dftflve8u/image/upload/v1765721022/Kan_Text_cgfd1w.png',
      //'https://www.dreamstime.com/photos-images/sweets-mithai-diwali-banner.html',
      link: 'https://sites.google.com/view/yatrify-terms-conditions',
    ),
    SmallBanner(
      bannerImage:
          'https://res.cloudinary.com/dftflve8u/image/upload/v1765721260/English_mxjagv.png',
      link: 'https://sites.google.com/view/yatrify-terms-conditions',
    ),
    SmallBanner(
      bannerImage:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760003436/small_banner2_nwjugj.jpg',
      link: '',
    ),
    SmallBanner(
      bannerImage:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760003435/small_banner3_epyaba.jpg',
      link: 'https://www.kantisweets.com/branch',
    ),
  ],
  textBanner: [
    TextBanner(
      bannerImage:
          "https://i.pinimg.com/736x/66/f1/6e/66f16eee76fa106a4cc160cbf6a58611.jpg",
      link: '',
      details: '''<p style="font-size:8px;">
  <strong>Maintain Silence &amp; Decorum</strong> – Devotees are requested to maintain silence and decorum within the temple premises.
  <br><br>
  <strong>Dress Code</strong> – Traditional and modest attire is required. Please avoid wearing shorts or sleeveless clothing.
  <br><br>
  <strong>Restricted Items</strong> – Mobile phones, cameras, and electronic gadgets are not permitted inside the sanctum.
</p>

''',
    ),
    TextBanner(
      bannerImage:
          'https://static.vecteezy.com/system/resources/previews/023/417/489/non_2x/abstract-fluid-colorfull-banner-background-with-blank-space-free-vector.jpg',
      link: '',
      details: '',
    )
  ],
  services: [
    Services(
      details: {
        'en': '',
        'kn': '',
      },
      isCalendar: true,
      id: 'SarpaSamskara',
      name: {
        'en': 'Sarpa Samskara',
        'kn': 'ಸರ್ಪ ಸಂಸ್ಕಾರ',
      },
      icon:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893680/sarpa_samskara_ifsyf1.png',
      purpose: {
        'en': '''
<p>
  <strong>Relief from Sarpa / Naga Dosha</strong> – This pooja helps remove the negative effects caused by harming or killing snakes, knowingly or unknowingly, in this life or past lives.
  <br><br>
  <strong>Ancestral Peace (Pitru Dosha)</strong> – It helps clear ancestral curses and brings peace to forefathers, whose blessings in turn bring harmony and prosperity to the family.
  <br><br>
  <strong>Marriage &amp; Children Blessings</strong> – This pooja helps remove obstacles in marriage, resolves issues of delayed marriage, and blesses couples who are hoping to have children.
</p>

''',
        'kn': '''
<p>
  <strong>ಸರ್ಪ / ನಾಗ ದೋಷ ನಿವಾರಣೆ</strong> – ತಿಳಿದುಕೊಂಡು ಅಥವಾ ತಿಳಿಯದೆ ಈ ಜನ್ಮದಲ್ಲಿ ಅಥವಾ ಹಿಂದಿನ ಜನ್ಮಗಳಲ್ಲಿ ಸರ್ಪಗಳಿಗೆ ಹಾನಿ ಮಾಡಿದ ಕಾರಣ ಉಂಟಾದ ದೋಷಗಳನ್ನು ಈ ಪೂಜೆ ನಿವಾರಿಸುತ್ತದೆ.
  <br><br>
  <strong>ಪಿತೃ ದೋಷ ಶಾಂತಿ</strong> – ಪೂರ್ವಜರ ದೋಷಗಳನ್ನು ನಿವಾರಿಸಿ, ಅವರಿಗೆ ಶಾಂತಿಯನ್ನು ನೀಡುತ್ತದೆ. ಇದರಿಂದ ಕುಟುಂಬಕ್ಕೆ ಅವರ ಆಶೀರ್ವಾದ ಲಭಿಸುತ್ತದೆ.
  <br><br>
  <strong>ವಿವಾಹ ಮತ್ತು ಸಂತಾನ ಭಾಗ್ಯ</strong> – ವಿವಾಹದಲ್ಲಿ ಇರುವ ಅಡೆತಡೆಗಳನ್ನು ದೂರ ಮಾಡುತ್ತದೆ, ವಿಳಂಬವಾದ ವಿವಾಹ ಸಮಸ್ಯೆಗಳನ್ನು ನಿವಾರಿಸಿ, ದಂಪತಿಗಳಿಗೆ ಮಕ್ಕಳ ಭಾಗ್ಯವನ್ನು ಕರುಣಿಸುತ್ತದೆ.
</p>

'''
      },
      images: [
        'https://res.cloudinary.com/dftflve8u/image/upload/v1765695183/Sarpa_Samskara2_lqmutc.png',
        'https://res.cloudinary.com/dftflve8u/image/upload/v1765695182/Kaala-Sarpa-Shanti-Homa.png_jzgtlo.webp',
        'https://res.cloudinary.com/dftflve8u/image/upload/v1765695956/Pooja-Services-1_wxjcie.webp',
      ],
      bookNowButton: true,
      weblink:
          'https://itms.kar.nic.in/ticketing/service_collection.php?tid=21&scode=21&sscode=1&target_type=&fees_slno=204256&group_id=4&action=P',
      rituals: {
        'en': '''
<p>
  <strong>Sarpa Samskara</strong> is a sacred <b>2-day pooja</b>. Devotees are advised to arrive one day in advance.
  After taking a holy bath in the <b>Kumaradhara River</b>, devotees should have <b>darshana in the temple</b>
  and then be present at the <b>Sarpa Samskara Yagashala (Adi Subrahmanya)</b> by <b>8:00 AM</b>.
  Devotees should wear simple and traditional attire.
</p>

<h4>Day 1 – Main Procedure</h4>
<ol>
  <li>
    <b>Reporting at Yagashala (8:00 AM)</b> – After holy bath and darshana, devotees must report to the
    Sarpa Samskara Yagashala, Adi Subrahmanya, by 8:00 AM and be seated in the assigned place.
  </li>
  <li>
    <b>Seva Sankalpa</b> – Sankalpa for the seva will be performed by the priest by taking the
    names and details of the devotees.
  </li>
  <li>
    <b>Sarpa Samskara – Day 1 Pooja (up to 11:30 AM)</b> – The first day rituals, including Homa,
    are performed to seek forgiveness for harming snakes knowingly or unknowingly,
    in this life or past lives.
  </li>
  <li>
    <b>Bhojana for Sevarthis</b> – Lunch will be served at the
    <b>Sarpa Samskara Bhojana Shala</b>, located near the Yagashala.
  </li>
</ol>

<h4>Important Instructions (Day 1)</h4>
<ul>
  <li>
    <b>Night dinner is not allowed</b> as per Sarpa Samskara pooja rules.
  </li>
  <li>
    <b>Light food</b> will be provided in the evening between <b>6:00 PM and 7:30 PM</b>.
  </li>
  <li>
    As <b>Sarpa Samskara Sootaka</b> is observed, sevarthis are
    <b>not allowed to enter the temple or have darshana</b> after the pooja begins.
  </li>
</ul>

<h4>Day 2 – Final Rituals</h4>
<ol>
  <li>
    <b>Reporting at Yagashala (5:30 AM)</b> – Sevarthis must take a bath and wear fresh clothes
    at the <b>same Yagashala</b> and be seated at the <b>same place as Day 1</b> by 5:30 AM.
  </li>
  <li>
    <b>Second Day Rituals (5:45 AM – 7:00 AM)</b> – The second set of Sarpa Samskara rituals
    will be performed during this time.
  </li>
  <li>
    <b>Go Pooja &amp; Brahmachari Aradhana (7:00 AM – 7:30 AM)</b> – Go Pooja and
    Brahmachari Aradhana will be conducted.
  </li>
  <li>
    <b>Breakfast for Sevarthis (7:30 AM – 8:30 AM)</b> – Morning breakfast will be served at the
    <b>Sarpa Samskara Bhojana Shala</b>.
  </li>
  <li>
    <b>Naga Prathishta Sankalpa &amp; Darshana</b> – After breakfast, devotees should proceed to
    <b>Kukke Subrahmanya Temple</b>, take Sankalpa for the
    <b>Naga Prathishta Seva</b>, and have darshana.
    Devotees must be present at the
    <b>Naga Prathishta Mantapa</b> between <b>12:00 PM and 1:00 PM</b>
    to receive the <b>Naga Prathishta Seva Prasada</b>.
  </li>
  <li>
    <b>Temple Bhojana &amp; Conclusion</b> – After receiving the prasada,
    devotees may have bhojana at the
    <b>Shanmukha Prasada Bhojana Shala</b> and then conclude the Sarpa Samskara.
  </li>
</ol>

''',
        'kn': '''
<p>
  <strong>ಸರ್ಪ ಸಂಸ್ಕಾರ</strong>ವು <b>2 ದಿನಗಳ ಪವಿತ್ರ ಪೂಜೆ</b>.
  ಭಕ್ತರು ಪೂಜೆಗೆ ಒಂದು ದಿನ ಮುಂಚಿತವಾಗಿ ಕುಕ್ಕೆ ಸುಬ್ರಹ್ಮಣ್ಯಕ್ಕೆ ಆಗಮಿಸುವುದು ಉತ್ತಮ.
  ಪೂಜೆಯ ದಿನ <b>ಕುಮಾರಧಾರಾ ನದಿಯಲ್ಲಿ ಸ್ನಾನ</b> ಮಾಡಿ,
  <b>ದೇವಾಲಯದಲ್ಲಿ ದರ್ಶನ</b> ಪಡೆದ ನಂತರ
  <b>ಆದಿ ಸುಬ್ರಹ್ಮಣ್ಯದಲ್ಲಿರುವ ಸರ್ಪ ಸಂಸ್ಕಾರ ಯಾಗಶಾಲೆಗೆ</b>
  <b>ಬೆಳಿಗ್ಗೆ 8:00 ಗಂಟೆಯೊಳಗೆ</b> ಹಾಜರಾಗಬೇಕು.
  ದಯವಿಟ್ಟು ಸರಳ ಹಾಗೂ ಸಂಪ್ರದಾಯಬದ್ಧ ವಸ್ತ್ರ ಧರಿಸಿ.
</p>

<h4>ದಿನ 1 – ಪೂಜೆಯ ಕ್ರಮ</h4>
<ol>
  <li>
    <b>ಯಾಗಶಾಲೆಗೆ ಹಾಜರಾಗುವುದು (8:00 AM)</b><br>
    ಸ್ನಾನ ಮತ್ತು ದರ್ಶನದ ನಂತರ,
    ಆದಿ ಸುಬ್ರಹ್ಮಣ್ಯದ ಸರ್ಪ ಸಂಸ್ಕಾರ ಯಾಗಶಾಲೆಗೆ
    ಬೆಳಿಗ್ಗೆ 8:00ಕ್ಕೆ ಹಾಜರಾಗಿ,
    ಸೂಚಿಸಲಾದ ಸ್ಥಳದಲ್ಲಿ ಕುಳಿತುಕೊಳ್ಳಬೇಕು.
  </li>

  <li>
    <b>ಸೇವಾ ಸಂಕಲ್ಪ</b><br>
    ಅರ್ಚಕರು ಭಕ್ತರ ಹೆಸರು, ಗೋತ್ರ ಹಾಗೂ ಉದ್ದೇಶದೊಂದಿಗೆ
    ಸೇವಾ ಸಂಕಲ್ಪವನ್ನು ನೆರವೇರಿಸುತ್ತಾರೆ.
  </li>

  <li>
    <b>ಸರ್ಪ ಸಂಸ್ಕಾರ – ಮೊದಲ ದಿನದ ಪೂಜೆ (ಸುಮಾರು 11:30 AMವರೆಗೆ)</b><br>
    ಈ ಪೂಜೆಯಲ್ಲಿ ಹೋಮ ಹಾಗೂ ಇತರೆ ವಿಧಿವಿಧಾನಗಳು ನಡೆಯುತ್ತವೆ.
    ಈ ಜನ್ಮದಲ್ಲೋ ಅಥವಾ ಹಿಂದಿನ ಜನ್ಮದಲ್ಲೋ
    ತಿಳಿದು ಅಥವಾ ತಿಳಿಯದೆ ಸರ್ಪಗಳಿಗೆ ಹಾನಿಯಾದ ದೋಷಗಳ ನಿವಾರಣೆಗಾಗಿ
    ಈ ಪೂಜೆ ನೆರವೇರುತ್ತದೆ.
  </li>

  <li>
    <b>ಮಧ್ಯಾಹ್ನ ಭೋಜನ</b><br>
    ಎಲ್ಲಾ ಸೇವಾರ್ಥಿಗಳಿಗೆ
    ಯಾಗಶಾಲೆ ಸಮೀಪದಲ್ಲಿರುವ
    <b>ಸರ್ಪ ಸಂಸ್ಕಾರ ಭೋಜನ ಶಾಲೆಯಲ್ಲಿ</b>
    ಮಧ್ಯಾಹ್ನ ಭೋಜನ ನೀಡಲಾಗುತ್ತದೆ.
  </li>
</ol>

<h4>ಮುಖ್ಯ ನಿಯಮಗಳು (ದಿನ 1)</h4>
<ul>
  <li>
    ಸರ್ಪ ಸಂಸ್ಕಾರ ನಿಯಮದಂತೆ
    <b>ರಾತ್ರಿ ಭೋಜನಕ್ಕೆ ಅವಕಾಶ ಇರುವುದಿಲ್ಲ</b>.
  </li>
  <li>
    <b>ಸಂಜೆ 6:00 ರಿಂದ 7:30ರವರೆಗೆ</b>
    ಲಘು ಆಹಾರವನ್ನು ಒದಗಿಸಲಾಗುತ್ತದೆ.
  </li>
  <li>
    ಸರ್ಪ ಸಂಸ್ಕಾರ <b>ಸೂತಕ ಇರುವುದರಿಂದ</b>,
    ಪೂಜೆ ಆರಂಭವಾದ ನಂತರ
    <b>ದೇವಾಲಯ ಪ್ರವೇಶ ಅಥವಾ ದರ್ಶನಕ್ಕೆ ಅನುಮತಿ ಇರುವುದಿಲ್ಲ</b>.
  </li>
</ul>

<h4>ದಿನ 2 – ಅಂತಿಮ ಪೂಜೆ</h4>
<ol>
  <li>
    <b>ಬೆಳಿಗ್ಗೆ ಯಾಗಶಾಲೆಗೆ ಹಾಜರಾತಿ (5:30 AM)</b><br>
    ಅದೇ ಯಾಗಶಾಲೆಯಲ್ಲಿ ಸ್ನಾನ ಮಾಡಿ,
    ಹೊಸ ವಸ್ತ್ರ ಧರಿಸಿ,
    ಮೊದಲ ದಿನ ಕುಳಿತಿದ್ದ <b>ಅದೇ ಸ್ಥಳದಲ್ಲಿ</b>
    ಬೆಳಿಗ್ಗೆ 5:30ಕ್ಕೆ ಹಾಜರಾಗಬೇಕು.
  </li>

  <li>
    <b>ಎರಡನೇ ದಿನದ ಪೂಜೆ (5:45 – 7:00 AM)</b><br>
    ಸರ್ಪ ಸಂಸ್ಕಾರದ ಎರಡನೇ ದಿನದ
    ಮುಖ್ಯ ವಿಧಿವಿಧಾನಗಳು ನಡೆಯುತ್ತವೆ.
  </li>

  <li>
    <b>ಗೋ ಪೂಜೆ ಮತ್ತು ಬ್ರಹ್ಮಚಾರಿಗಳ ಆರಾಧನೆ (7:00 – 7:30 AM)</b><br>
    ಗೋ ಪೂಜೆ ಹಾಗೂ ಬ್ರಹ್ಮಚಾರಿಗಳ ಆರಾಧನೆ
    ಪೂಜೆಯ ಭಾಗವಾಗಿ ನೆರವೇರುತ್ತದೆ.
  </li>

  <li>
    <b>ಬೆಳಗಿನ ಉಪಹಾರ (7:30 – 8:30 AM)</b><br>
    ಸೇವಾರ್ಥಿಗಳಿಗೆ
    <b>ಸರ್ಪ ಸಂಸ್ಕಾರ ಭೋಜನ ಶಾಲೆಯಲ್ಲಿ</b>
    ಬೆಳಗಿನ ಉಪಹಾರ ನೀಡಲಾಗುತ್ತದೆ.
  </li>

  <li>
    <b>ನಾಗ ಪ್ರತಿಷ್ಠಾ ಸೇವೆ ಮತ್ತು ದರ್ಶನ</b><br>
    ಉಪಹಾರದ ನಂತರ ಭಕ್ತರು
    <b>ಕುಕ್ಕೆ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಾಲಯಕ್ಕೆ</b> ತೆರಳಿ,
    <b>ನಾಗ ಪ್ರತಿಷ್ಠಾ ಸೇವೆಯ ಸಂಕಲ್ಪ</b> ಮಾಡಿ ದರ್ಶನ ಪಡೆಯಬೇಕು.
    <br>
    <b>ಮಧ್ಯಾಹ್ನ 12:00 ರಿಂದ 1:00ರವರೆಗೆ</b>
    <b>ನಾಗ ಪ್ರತಿಷ್ಠಾ ಮಂಟಪದಲ್ಲಿ</b>
    ಸೇವಾ ಪ್ರಸಾದವನ್ನು ಸ್ವೀಕರಿಸಬೇಕು.
  </li>

  <li>
    <b>ದೇವಾಲಯ ಭೋಜನ ಮತ್ತು ಪೂಜೆಯ ಪೂರ್ಣತೆ</b><br>
    ನಂತರ ಭಕ್ತರು
    <b>ಶಣ್ಮುಖ ಪ್ರಸಾದ ಭೋಜನ ಶಾಲೆಯಲ್ಲಿ</b>
    ಭೋಜನ ಮಾಡಿ,
    ಸರ್ಪ ಸಂಸ್ಕಾರ ಪೂಜೆಯನ್ನು ಪೂರ್ಣಗೊಳಿಸಬಹುದು.
  </li>
</ol>

'''
      },
      howToBook: {
        'en': '''
<p>
  Booking for the Sarpa Samskara Pooja can be done <b>online only</b> 
  through the official <b>Kukke Subrahmanya Temple</b> website.
</p>

<ol>
  <li>
   click the 
    <b>“Book Now”</b> button to go directly to the temple’s official site. 
    Check the available calendar, select your preferred date, 
    and fill in the required details.
  </li>
  <li>
    <b>Note:</b> Pooja will <b>not be performed on Ekadashi days</b>.
  </li>
  <li>
    To confirm your booking, pay the <b>₹4200</b> fee directly to the temple via the website.
  </li>
  <li>
    When attending the pooja, bring your booking receipt and a valid <b>ID proof</b>.
  </li>
</ol>

''',
        'kn': '''
<p>
  ಸರ್ಪ ಸಂಸ್ಕಾರ ಪೂಜೆಯ ಬುಕಿಂಗ್ ಅನ್ನು ಅಧಿಕೃತ
  <b>ಕುಕ್ಕೆ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನ</b> ವೆಬ್‌ಸೈಟ್ ಮೂಲಕ
  <b>ಆನ್ಲೈನ್ ಮಾತ್ರ</b> ಮಾಡಲಾಗುತ್ತದೆ.
</p>

<ol>
  <li>
  
    <b>“ಬುಕ್ ಮಾಡಿ”</b> ಬಟನ್ ಕ್ಲಿಕ್ ಮಾಡಿದರೆ
    ನೇರವಾಗಿ ದೇವಸ್ಥಾನದ ಅಧಿಕೃತ ವೆಬ್‌ಸೈಟ್‌ಗೆ ಹೋಗುತ್ತದೆ.
    ಅಲ್ಲಿ ಲಭ್ಯವಿರುವ ಕ್ಯಾಲೆಂಡರ್ ಪರಿಶೀಲಿಸಿ,
    ನಿಮ್ಮ ಇಚ್ಛಿತ ದಿನಾಂಕವನ್ನು ಆಯ್ಕೆ ಮಾಡಿ
    ಮತ್ತು ಅಗತ್ಯವಿರುವ ವಿವರಗಳನ್ನು ಭರ್ತಿ ಮಾಡಿ.
  </li>
  <li>
    <b>ಸೂಚನೆ:</b> <b>ಏಕಾದಶಿ ದಿನಗಳಲ್ಲಿ</b> ಪೂಜೆ ನಡೆಯುವುದಿಲ್ಲ.
  </li>
  <li>
    ನಿಮ್ಮ ಬುಕಿಂಗ್ ದೃಢೀಕರಿಸಲು,
    ವೆಬ್‌ಸೈಟ್ ಮೂಲಕ
    <b>₹4200</b> ಶುಲ್ಕವನ್ನು
    ನೇರವಾಗಿ ದೇವಸ್ಥಾನಕ್ಕೆ ಪಾವತಿಸಬೇಕು.
  </li>
  <li>
    ಪೂಜೆಗೆ ಆಗಮಿಸುವಾಗ
    ಬುಕಿಂಗ್ ರಸೀದಿ ಮತ್ತು ಮಾನ್ಯ
    <b>ID ಪ್ರೂಫ್</b> ಅನ್ನು ತರಬೇಕು.
  </li>
</ol>

'''
      },
      tips: {
        'en': '''
<style>
  ul {
    margin: 0;
    padding-left: 18px;
    line-height: 1.6;
  }
  li {
    margin-bottom: 8px;
    color: #333;
  }
</style>

<ul>
 
  <li>
    For any information or clarification, please <b>contact the temple authorities directly</b>.
    Do not rely on brokers or middlemen.
  </li>
  <li>
    <b>The true benefits of Sarpa Samskara Pooja</b> can be obtained
    <b>only when it is performed at Kukke Subrahmanya Temple</b>.
    Poojas conducted at third-party or external locations do not provide the same spiritual benefits.
  </li>
</ul>

''',
        'kn': '''
<style>
  ul {
    margin: 0;
    padding-left: 18px;
    line-height: 1.6;
  }
  li {
    margin-bottom: 8px;
    color: #333;
  }
</style>

<ul>
 
  <li>
    ಯಾವುದೇ ಮಾಹಿತಿ ಅಥವಾ ಸ್ಪಷ್ಟತೆಗಾಗಿ <b>ನೇರವಾಗಿ ದೇವಾಲಯದ ಅಧಿಕಾರಿಗಳನ್ನು ಮಾತ್ರ ಸಂಪರ್ಕಿಸಿ</b>.
    ಮಧ್ಯವರ್ತಿಗಳು (ಬ್ರೋಕರ್‌ಗಳು) ನೀಡುವ ಮಾಹಿತಿಯನ್ನು ಅವಲಂಬಿಸಬೇಡಿ.
  </li>
  <li>
    <b>ಸರ್ಪ ಸಂಸ್ಕಾರ ಪೂಜೆಯ ನಿಜವಾದ ಫಲವು</b>
    <b>ಕುಕ್ಕೆ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಾಲಯದಲ್ಲಿ</b> ನಡೆಸಿದಾಗ ಮಾತ್ರ ಲಭ್ಯವಾಗುತ್ತದೆ.
    ಯಾವುದೇ ಮೂರನೇ ವ್ಯಕ್ತಿಗಳ ಅಥವಾ ಹೊರಗಿನ ಸ್ಥಳಗಳಲ್ಲಿ ಮಾಡಿದ ಪೂಜೆಯಿಂದ
    ದೇವಾಲಯದ ಅನುಗ್ರಹ ಫಲ ಲಭಿಸುವುದಿಲ್ಲ.
  </li>
</ul>

'''
      },
      unavailableDateIds: [
        'yekadashi',
      ],
      availableDateIds: [],
      calendarMaxDate: "31-03-2026",
    ),
    Services(
      details: {
        'en': '',
        'kn': '',
      },
      id: 'AshleshaBali',
      name: {
        'en': 'Ashlesha Bali',
        'kn': 'ಅಶ್ಲೇಷ ಬಲಿ',
      },
      icon:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893679/ashlesha_bali_fydhmn.png',
      purpose: {
        'en': '''
<p>To remove Sarpa Dosha (serpent curse) from one’s jataka (horoscope).</p>
<p>Brings relief from obstacles in marriage, childbirth, and family life.</p>
<p>Helps overcome ancestral karmic issues, financial instability, and health problems caused by Naga Dosha.</p>

''',
        'kn': '''
<p>ಸ್ವಂತ ಜಾತಕ (ಹೋರೋಸ್ಕೋಪ್) ನಿಂದ ಸರ್ಪ ದೋಷ (ಹುಲಿಯ ಶಾಪ) ತೆಗೆದುಹಾಕಲು.</p>
<p>ವಿವಾಹ, ಸಂತಾನೋತ್ಪತ್ತಿ ಮತ್ತು ಕುಟುಂಬ ಜೀವನದ ಅಡ್ಡಿಗಳಿಂದ ಮುಕ್ತಿ ನೀಡುತ್ತದೆ.</p>
<p>ಪಿತೃ ದೋಷದಿಂದ ಉಂಟಾಗುವ ಪೂರಕ ಸಮಸ್ಯೆಗಳು, ಹಣಕಾಸಿನ ಅಸ್ಥಿರತೆ ಮತ್ತು ಆರೋಗ್ಯ ಸಮಸ್ಯೆಗಳನ್ನು ದಾಟಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ.</p>
'''
      },
      images: [
        'https://res.cloudinary.com/dftflve8u/image/upload/v1765695415/Ashlesha_Bali_eyiriv.png',
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760338286/AshleshaBali2_jmtpqo.png',
      ],
      bookNowButton: true,
      weblink:
          'https://itms.kar.nic.in/ticketing/service_collection.php?tid=21&scode=21&sscode=1&target_type=&fees_slno=214319&group_id=4&action=P',
      rituals: {
        'en': '''
<p><strong>Sankalpa:</strong> Devotee’s name, gotra, and purpose are declared.</p>
<p>Pooja will be done in Ashlesha Bali Mantapa. Once done, you will be given the prasada.</p>
<p><strong>Pooja duration:</strong> ~1.5 to 2 hours.</p>
<p>Best performed on Ashlesha Nakshatra days.</p>
''',
        'kn': '''
<p><strong>ಸಂಕಲ್ಪ:</strong> ಭಕ್ತರ ಹೆಸರು, ಗೊತ್ರ ಮತ್ತು ಉದ್ದೇಶ ಘೋಷಿಸಲಾಗುತ್ತದೆ.</p>
<p>ಪೂಜೆಯನ್ನು ಅಶ್ಲೇಷ ಬಾಳಿ ಮಂಟಪದಲ್ಲಿ ನಡೆಸಲಾಗುತ್ತದೆ. ಪೂಜೆ ನಂತರ, ನಿಮಗೆ ಪ್ರಸಾದ ನೀಡಲಾಗುತ್ತದೆ.</p>
<p><strong>ಪೂಜೆ ಅವಧಿ:</strong> ~1.5 ರಿಂದ 2 ಗಂಟೆಗಳು.</p>
<p>ಅಶ್ಲೇಷ ನಕ್ಷತ್ರ ದಿನಗಳಲ್ಲಿ ಅತ್ಯುತ್ತಮವಾಗಿ ನಡೆಸಲಾಗುತ್ತದೆ.</p>
'''
      },
      howToBook: {
        'en': '''
<p>Book online via the official <strong>Kukke Subrahmanya Temple</strong> website.</p>
<p>Tickets also available at the temple counter (subject to slot availability).</p>
<p><strong>Cost:</strong> ₹400–₹500 per person (basic).</p>
<p>Advance booking recommended, especially on <strong>Ashlesha Nakshatra</strong> days.</p>
<p>Click the <strong>Book Now</strong> button below to proceed.</p>
<p><strong>Yatrify</strong> redirects you to the official temple website for secure booking.</p>

''',
        'kn': '''
<p>ಅಧಿಕೃತ <strong>ಕುಕ್ಕೇ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನ</strong> ವೆಬ್‌ಸೈಟ್ ಮೂಲಕ ಆನ್ಲೈನ್‌ನಲ್ಲಿ ಬುಕ್ ಮಾಡಿ.</p>
<p>ಟಿಕೆಟ್‌ಗಳು ದೇವಸ್ಥಾನದ ಕೌಂಟರ್‌ನಲ್ಲಿ ಕೂಡ ಲಭ್ಯವಿವೆ (ಸ್ಲಾಟ್ ಲಭ್ಯತೆ ಮೇಲೆ ಅವಲಂಬಿತವಾಗಿದೆ).</p>
<p><strong>ಖರ್ಚು:</strong> ಪ್ರತಿ ವ್ಯಕ್ತಿಗೆ ₹400–₹500 (ಮೂಲ).</p>
<p>ಮುಂಚಿತ ಬುಕ್ಕಿಂಗ್ ಶಿಫಾರಸು ಮಾಡಲಾಗುತ್ತದೆ, ವಿಶೇಷವಾಗಿ <strong>ಅಶ್ಲೇಷ ನಕ್ಷತ್ರ</strong> ದಿನಗಳಲ್ಲಿ.</p>
<p>ಮುಂದೆProceed ಮಾಡಲು ಕೆಳಗಿನ <strong>ಬುಕ್ ನೌ</strong> ಬಟನ್ ಕ್ಲಿಕ್ ಮಾಡಿ.</p>
<p><strong>ಯಾತ್ರಿಫೈ</strong> ಸುರಕ್ಷಿತ ಬುಕ್ಕಿಂಗ್ ಗಾಗಿ ಅಧಿಕೃತ ದೇವಸ್ಥಾನ ವೆಬ್‌ಸೈಟ್‌ಗೆ ರೀಡೈರೆಕ್ಟ್ ಮಾಡುತ್ತದೆ.</p>

'''
      },
      fee: {
        'en': '',
        'kn': '',
      },
      tips: {
        'en': '''
<p><strong>Ashlesha Nakshatra</strong> is the most auspicious day for this pooja.</p>
<p>Not performed on <strong>Ekadashi</strong>, so check the calendar before booking.</p>
''',
        'kn': '''
<p><strong>ಅಶ್ಲೇಷ ನಕ್ಷತ್ರ</strong> ಈ ಪೂಜೆಗೆ ಅತ್ಯಂತ ಶುಭದ ದಿನವಾಗಿದೆ.</p>
<p><strong>ಏಕಾದಶಿ</strong> ದಿನ ಪೂಜೆ ನಡೆಯುವುದಿಲ್ಲ, ಆದ್ದರಿಂದ ಬುಕ್ಕಿಂಗ್ ಮಾಡುವ ಮೊದಲು ಕ್ಯಾಲೆಂಡರ್ ಪರಿಶೀಲಿಸಿ.</p>
'''
      },
      videos: [
        ServiceVideo(
            id: 'Kukke Subramanya',
            name: 'Kukke Subramanya',
            details: 'Kukke Subramanya ',
            link: 'https://youtu.be/YmXgWdy74t8'),
        ServiceVideo(
            id: 'Kukke Subramanya',
            name: 'Kukke Subramanya',
            details: 'Kukke Subramanya ',
            link: 'https://youtu.be/YmXgWdy74t8'),
        ServiceVideo(
            id: 'Kukke Subramanya',
            name: 'Kukke Subramanya',
            details: 'Kukke Subramanya ',
            link: 'https://youtu.be/YmXgWdy74t8'),
      ],
      isCalendar: true,
      availableDateIds: [
        'shuddaShasti',
        'ashleshanakshathra',
      ],
      unavailableDateIds: [
        'yekadashi',
      ],
      calendarMaxDate: "31-03-2026",
    ),
    Services(
      details: {
        'en': '',
        'kn': '',
      },
      id: 'NagaPrathishta',
      name: {
        'en': 'Naga Prathishta',
        'kn': 'ನಾಗ ಪ್ರತಿಷ್ಠಾ',
      },
      icon:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893679/naga_prathista_x3fczb.png',
      purpose: {
        'en': '''
<p>To remove Sarpa Dosha (afflictions related to serpents) from the horoscope.</p>
<p>To bring peace, prosperity, and family well-being.</p>
<p>To seek blessings of serpent deities for health and harmony.</p>

''',
        'kn': '''
<p>ಜಾತಕ (ಹೋರೋಸ್ಕೋಪ್) ಯಿಂದ ಸರ್ಪ ದೋಷ (ಸರ್ಪಗಳಿಗೆ ಸಂಬಂಧಿಸಿದ ಸಂಕಷ್ಟಗಳು) ತೆಗೆದುಹಾಕಲು.</p>
<p>ಶಾಂತಿ, ಸಂಪತ್ತು ಮತ್ತು ಕುಟುಂಬದ ಕ್ಷೇಮವನ್ನು ತರಲು.</p>
<p>ಆರೋಗ್ಯ ಮತ್ತು ಸೌಹಾರ್ಧಕ್ಕಾಗಿ ಸರ್ಪ ದೇವತೆಗಳ ಆಶೀರ್ವಾದವನ್ನು ಪಡೆಯಲು.</p>
'''
      },
      images: [
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759854227/naga_pratista2_j24wd9.png',
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759847682/naga_pratista1_zbtwtp.png',
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759855767/naga_pratista3_dzumsz.png',
      ],
      bookNowButton: true,
      weblink: '',
      rituals: {
        'en': '''
<p>The pooja begins with <b>Sankalpa</b> – devotees/family declare their name, Gotra, and purpose of performing the pooja.</p>

<p><b>Pratishthapane</b> (installation) is performed for the Naga Vigraha.</p>

<p>The priests also perform <b>Abhishekam</b> (holy bathing) of the Naga idol with sacred substances.</p>

<p>Special mantras and offerings are conducted throughout the ceremony.</p>

<p>The ritual starts at <b>11:00 AM</b> and continues for about 1 hour.</p>

''',
        'kn': '''
<p>ಪೂಜೆ <b>ಸಂಕಲ್ಪ</b>ದಿಂದ ಪ್ರಾರಂಭವಾಗುತ್ತದೆ – ಭಕ್ತರು/ಕುಟುಂಬ their ಹೆಸರು, ಗೋತ್ರ ಮತ್ತು ಪೂಜೆ ಸಲ್ಲಿಸುವ ಉದ್ದೇಶವನ್ನು ಘೋಷಿಸುತ್ತಾರೆ.</p>

<p><b>ಪ್ರತಿಷ್ಠಾಪನೆ</b> (ಸ್ಥಾಪನೆ) ನಾಗ ವಿಗ್ರಹಕ್ಕೆ ನಡೆಯುತ್ತದೆ.</p>

<p>ಪೂಜಾರಿಗಳು ನಾಗ ಪ್ರತಿಮೆ <b>ಅಭಿಷೇಕ</b> (ಪವಿತ್ರ ಸ್ನಾನ) ಅನ್ನು ಪವಿತ್ರ ವಸ್ತುಗಳೊಂದಿಗೆ ನೆರವೇರಿಸುತ್ತಾರೆ.</p>

<p>ಸಮಾರಂಭದ ಎಲ್ಲಾ ಸಮಯದಲ್ಲಿ ವಿಶೇಷ ಮಂತ್ರಗಳು ಮತ್ತು ಅರ್ಪಣೆಗಳು ನಡೆಯುತ್ತವೆ.</p>

<p>ಈ ವಿಧಿ <b>ಬೆಳಗ್ಗೆ 11:00 AM</b> ಗೆ ಪ್ರಾರಂಭವಾಗುತ್ತದೆ ಮತ್ತು ಸುಮಾರು 1 ಗಂಟೆಯ ಕಾಲ ಮುಂದುವರಿಯುತ್ತದೆ.</p>

'''
      },
      howToBook: {
        'en': '''
<p><strong>No online booking</strong> is available for this pooja.</p>
<p>Devotees must <strong>register directly at the temple counter</strong> on arrival.</p>
''',
        'kn': '''
<p><strong>ಈ ಪೂಜೆಗೆ ಯಾವುದೇ ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್</strong> ಲಭ್ಯವಿಲ್ಲ.</p>
<p>ಭಕ್ತರು ಬಂದಾಗ <strong>ನೇರವಾಗಿ ದೇವಸ್ಥಾನದ ಕೌಂಟರ್‌ನಲ್ಲಿ ನೋಂದಣಿ ಮಾಡಿಕೊಳ್ಳಬೇಕು</strong>.</p>
'''
      },
      fee: {
        'en': '',
        'kn': '',
      },
      videos: [
        ServiceVideo(
            id: 'Kukke Subramanya',
            name: 'Kukke Subramanya',
            details: 'Kukke Subramanya ',
            link: 'https://youtu.be/YmXgWdy74t8'),
      ],
      isCalendar: true,
      availableDateIds: [],
      unavailableDateIds: [
        'yekadashi',
      ],
      calendarMaxDate: "31-03-2026",
      tips: {
        'en': '''
<p>The pooja is not performed on Ekadashi days.</p>
''',
        'kn': '''
<p>ಈ ಪೂಜೆಯನ್ನು ಏಕಾದಶಿ ದಿನಗಳಲ್ಲಿ ನಡೆಸುವುದಿಲ್ಲ.</p>
'''
      },
    ),
    Services(
      details: {
        'en': '',
        'kn': '',
      },
      isCalendar: true,
      id: 'RathosthavaSeva',
      name: {
        'en': 'Rathosthava Seva',
        'kn': 'ರಥೋತ್ಸವ ಸೇವೆ',
      },
      icon:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893680/rathosthava_seve_wkp1cb.png',
      purpose: {
        'en':
            'Is an elaborate and grand pooje dedicated to the Nagas or serpent deities. It is performed to gain blessings from the Nagas and to seek protection from snake-related troubles.',
        'kn':
            'ನಾಗರು ಅಥವಾ ಹಾವು ದೇವತೆಗಳಿಗೆ ಅರ್ಪಿಸಲಾದ ವಿಶಾಲ ಮತ್ತು ಭವ್ಯ ಪೂಜೆ. ನಾಗರಿಂದ ಆಶೀರ್ವಾದ ಪಡೆಯಲು ಮತ್ತು ಹಾವು ಸಂಬಂಧಿತ ಸಮಸ್ಯೆಗಳಿಂದ ರಕ್ಷಣೆ ಪಡೆಯಲು ಇದನ್ನು ನಡೆಸಲಾಗುತ್ತದೆ.'
      },
      images: [
        'https://res.cloudinary.com/dftflve8u/image/upload/v1765713223/Rath3_psryez.jpg',
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915920/ratostava3_fujkzx.jpg',
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915919/ratostava2_zpywxl.jpg',
      ],
      bookNowButton: true,
      weblink: '',
      videos: [
        ServiceVideo(id: '', name: '', details: '', link: ''),
      ],
      availableDateIds: [],
      unavailableDateIds: [],
      calendarMaxDate: "31-03-2026",
      rathotsavaSevaList: [
        RathotsavaSevaList(
          name: {'en': 'Brahmha Rathotsava', 'kn': 'ಬ್ರಹ್ಮ ರಥೋತ್ಸವ'},
          description: {
            'en': '''
<p>The grand chariot procession featuring <strong>Lord Subrahmanya</strong>.</p>

<p><strong>When:</strong> Held once every year during <em>Champa Shashti Mahotsava</em>.</p>

<p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

<p><strong>Note:</strong> This is the primary and most prominent Rathotsava held during the festival.</p>
  ''',
            'kn': '''
<p><strong>ಲಾರ್ಡ್ ಸುಬ್ರಹ್ಮಣ್ಯ</strong>ರನ್ನು ಸೇರಿಸಿಕೊಂಡ ಭव्य ರಥೋತ್ಸವ ಪ್ರದರ್ಶನ.</p>

<p><strong>ಯಾವಾಗ:</strong> ಚಂಪಾ ಷಷ್ಟಿ ಮಹೋತ್ಸವದ ವೇಳೆ ವರ್ಷಕ್ಕೆ ಒಂದು ಬಾರಿ ನಡೆಯುತ್ತದೆ.</p>

<p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

<p><strong>ಸೂಚನೆ:</strong> ಈ ರಥೋತ್ಸವವು ಉತ್ಸವದ ಪ್ರಮುಖ ಮತ್ತು ಅತ್ಯಂತ ಪ್ರಸಿದ್ಧ ರಥೋತ್ಸವವಾಗಿದೆ.</p>
  '''
          },
          price: '₹25,000',
        ),
        RathotsavaSevaList(
          name: {'en': 'Chikka Rathotsava', 'kn': 'ಚಿಕ್ಕ ರಥೋತ್ಸವ'},
          description: {
            'en': '''
<p>A procession using a smaller chariot, offering a more intimate experience.</p>

<p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

<p><strong>Note:</strong> Ideal for those seeking a less crowded participation.</p>
  ''',
            'kn': '''
<p>ಚಿಕ್ಕ ರಥವನ್ನು ಬಳಸಿ ನಡೆದ ರಥೋತ್ಸವ, ಹೆಚ್ಚು ಹತ್ತಿರದ ಅನುಭವವನ್ನು ನೀಡುತ್ತದೆ.</p>

<p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

<p><strong>ಸೂಚನೆ:</strong> ಕಡಿಮೆ ಜನಸಂಖ್ಯೆಯ ಭಾಗವಹಿಸುವಿಕೆಯನ್ನು ಇಚ್ಛಿಸುವವರಿಗೆ ಅತ್ಯುತ್ತಮ.</p>
  '''
          },
          price: '₹8,000',
        ),
        RathotsavaSevaList(
          name: {'en': 'Chandramandala Rathothsava', 'kn': 'ಚಂದ್ರಮಂಡಲ ರಥೋತ್ಸವ'},
          description: {
            'en': '''
<p>The deity is taken in a circular procession around the temple streets.</p>

<p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

<p><strong>Note:</strong> Devotees can witness the deity’s journey through the town.</p>
  ''',
            'kn': '''
<p>ದೇವತೆ ದೇವಸ್ಥಾನದ ಬೀದಿಗಳ ಸುತ್ತ ಸುತ್ತುವ ರಥಯಾತ್ರೆಯಲ್ಲಿ ನಡೆಸಲ್ಪಡುತ್ತದೆ.</p>

<p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

<p><strong>ಸೂಚನೆ:</strong> ಭಕ್ತರು ದೇವತೆಯ ಪಟ್ಟಣದ ಮೂಲಕ ನಡೆದ ಪ್ರಯಾಣವನ್ನು ನೋಡಬಹುದು.</p>
  '''
          },
          price: '₹6,000',
        ),
        RathotsavaSevaList(
          name: {'en': 'Hoovina Rathothsava', 'kn': 'ಹೂವಿನ ರಥೋತ್ಸವ'},
          description: {
            'en': '''
<p>A procession featuring a chariot adorned with flowers, symbolizing beauty and devotion.</p>

<p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

<p><strong>Note:</strong> Visually captivating event showcasing the temple's floral offerings.</p>
  ''',
            'kn': '''
<p>ಮಾಲೆಗಳಿಂದ ಅಲಂಕರಿಸಲಾದ ರಥವನ್ನು ಒಳಗೊಂಡ ಯಾತ್ರೆ, ಸುಂದರತೆ ಮತ್ತು ಭಕ್ತಿಯ ಸಂಕೇತವಾಗಿದೆ.</p>

<p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

<p><strong>ಸೂಚನೆ:</strong> ದೇವಾಲಯದ ಹೂವಿನ ಅಲಂಕಾರಗಳನ್ನು ಪ್ರದರ್ಶಿಸುವ ದೃಶ್ಯಾವಳಿ ಆಕರ್ಷಕ ಘಟನೆ.</p>
  '''
          },
          price: '₹5,000',
        ),
        RathotsavaSevaList(
          name: {
            'en': 'Sheshavahana Bhandi Utsava in the Angana',
            'kn': 'ಅಂಗಣದಲ್ಲಿ ಶೇಷವಾಹನ ಭಂಡಿ ಉತ್ಸವ'
          },
          description: {
            'en': '''
<p>The deity is placed on the Sheshavahana (serpent vehicle) within the temple courtyard.</p>

<p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

<p><strong>Note:</strong> Symbolizes the deity's association with serpents.</p>
  ''',
            'kn': '''
<p>ದೇವತೆ ದೇವಾಲಯದ ಆವರಣದಲ್ಲಿ ಶೇಷವಾಹನ (ನಾಗ ವಾಹನ) ಮೇಲೆ置ಿಸಲಾಗಿದೆ.</p>

<p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

<p><strong>ಸೂಚನೆ:</strong> ದೇವತೆಯ ನಾಗರ ಸಂಬಂಧವನ್ನು ಪ್ರತಿನಿಧಿಸುತ್ತದೆ.</p>
  '''
          },
          price: '₹3,000',
        ),
      ],
      note: {
        'en': '''
         <h2>Important Notes</h2>

<p><strong>Booking:</strong> Advance registration is typically required for these sevas. Contact the temple authorities for details.</p>

<p><strong>Availability:</strong> Primarily offered during the annual Rathotsava festival (usually March–April). Dates may vary; check temple announcements.</p>

<p><strong>Participation:</strong> Devotees are expected to follow the temple’s dress code and conduct guidelines.</p>
         ''',
        'kn': '''
         <h2>ಮುಖ್ಯ ಟಿಪ್ಪಣಿಗಳು</h2>

<p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಈ ಸೇವೆಗಳಿಗಾಗಿ ಸಾಮಾನ್ಯವಾಗಿ ಮುಂಚಿತ ನೋಂದಣಿ ಅಗತ್ಯವಿದೆ. ವಿವರಗಳಿಗೆ ದೇವಸ್ಥಾನ ಪ್ರಾಧಿಕಾರಿಗಳ ಸಂಪರ್ಕಕ್ಕೆ ಹೋಗಿ.</p>

<p><strong>ಲಭ್ಯತೆ:</strong> ಮುಖ್ಯವಾಗಿ ವಾರ್ಷಿಕ ರಥೋತ್ಸವದ ಸಮಯದಲ್ಲಿ (ಸಾಮಾನ್ಯವಾಗಿ ಮಾರ್ಚ್–ಎಪ್ರಿಲ್) ನೀಡಲಾಗುತ್ತದೆ. ದಿನಾಂಕಗಳು ಬದಲಾಗಬಹುದು; ದೇವಸ್ಥಾನ ಪ್ರಕಟಣೆಗಳನ್ನು ಪರಿಶೀಲಿಸಿ.</p>

<p><strong>ಪಾಲ್ಗೊಳ್ಳುವಿಕೆ:</strong> ಭಕ್ತರು ದೇವಸ್ಥಾನದ ವಸ್ತ್ರ ಧಾರಣೆ ಮತ್ತು ನಡೆರಗಿನ ಮಾರ್ಗಸೂಚಿಗಳನ್ನು ಅನುಸರಿಸಲು ನಿರೀಕ್ಷಿಸಲಾಗುತ್ತದೆ.</p>
         '''
      },
      contactDetails: {
        'en': '''
         <h2>Temple Contact</h2>

<p style="margin:8px 0;">
    📞 <a href="tel:+918257281224" style="color:#e25a20; text-decoration:none;">
    +91 8257 281224
    </a>
  </p>

  <p style="margin:4px 0;">
    ✉️ <a href="mailto:eokukkesubrahmanya@gmail.com" style="color:#e25a20; text-decoration:none;">
    eokukkesubrahmanya@gmail.com
    </a>
  </p>

         ''',
        'kn': '''
         <h2>ದೇವಸ್ಥಾನ ಸಂಪರ್ಕ</h2>

<p style="margin:8px 0;">
    📞 <a href="tel:+918257281224" style="color:#e25a20; text-decoration:none;">
    +91 8257 281224
    </a>
  </p>

  <p style="margin:4px 0;">
    ✉️ <a href="mailto:eokukkesubrahmanya@gmail.com" style="color:#e25a20; text-decoration:none;">
    eokukkesubrahmanya@gmail.com
    </a>
  </p>

         '''
      },
    ),
    // Services(
    //   isCalendar: false,
    //   id: 'TempleHistory',
    //   name: 'Temple History',
    //   purpose: '',
    //   details:
    //       '🕉 Kukke Subrahmanya Temple – History \n Location & Significance \n Situated on the banks of the Kumaradhara River at the foothills of Kumara Parvatha in the Western Ghats. One among the seven holy places (Sapta Kshetras) created by Parashurama. \n Mythological Origin \n Lord Kumaraswamy (Subrahmanya) was born to destroy demons. \n He defeated Tharakasura and came to Kumara Parvatha. \n On the banks of the Kumaradhara, Indra offered his daughter Devasena in marriage to Lord Kumaraswamy on Margashira Shuddha Shashti. \n Around the same time, Vasuki, king of serpents, was meditating there. The Lord blessed him and promised to stay eternally at Kukke with Devasena, as the protector of serpents. \n Historical Mentions \n References are found in Skanda Purana and Shankaracharya’s Shankar Vijaya (9th–10th century), where he praises the Lord as “Bhaje Kukkelingam”. \n An inscription of the Bunts (9th century) mentions Kukke. \n The temple is believed to have a history of over 5000 years. \n Beliefs & Significance \n The Lord resides in serpent form in the sanctum. \n Devotees believe worship here grants: \n Progeny (Santana prapti) \n Marital blessings (Mangala bhagya) \n Relief from skin diseases \n Removal of serpent curses (Naga Dosha). \n Temple Rituals & Special Features \n Main prasadam is holy soil (hutta mannu) believed to have divine powers. \n Special poojas: Sarpa Samskara, Ashlesha Bali, Naga Pratishte. \n Sacred rivers Kumaradhara and Darpana Teertha surround the temple. \n Taking a holy dip here is believed to cure skin ailments. \n In 2005, the sanctum (garbhagudi) was renovated. \n During Champashashti festival, soil prasadam is distributed with Vedic rituals. \n Traditional Offerings \n Abhisheka with coconut water and milk. \n Applying turmeric, sandalwood paste to the deity. \n Offerings of banana, jaggery, and flowers continue as tradition.',
    //   images:
    //       ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefX9fCIuEQ2LbMkp1Wmy8DCON0olwUwA3pQ&s'],
    //   bookNowButton: true,
    //   weblink: '',
    //   videos: [
    //     ServiceVideo(id: '', name: '', details: '', link: ''),
    //   ],
    // ),
    Services(
      details: {
        'en': '',
        'kn': '',
      },
      isCalendar: false,
      id: 'OtherServices',
      name: {
        'en': 'Other Sevas',
        'kn': 'ಇತರೆ ಸೇವೆಗಳು',
      },
      icon:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893679/other_service_qpkmwu.png',
      images: [
        'https://res.cloudinary.com/dftflve8u/image/upload/v1765608787/OtherServices_zo6k1l.png',
        'https://res.cloudinary.com/dftflve8u/image/upload/v1765697744/God1_c721ai.png',
      ],
      bookNowButton: true,
      weblink: '',
      otherSevas: {
        'en': '''
<h3>Daily Sevas</h3>

<ol>
  <li>Mahapooje (Whole day included) – ₹400</li>
  <li>Mahapooje (Afternoon included) – ₹250</li>
  <li>Pavamana Panchamrita Abhisheka – ₹100</li>
  <li>Kalasha Pooja Panchamrita Abhisheka – ₹100</li>
  <li>Panchamrita Abhisheka – ₹75</li>
  <li>Rudrabhisheka – ₹75</li>
  <li>Ksheerabhisheka – ₹50</li>
  <li>Sheshaseva – ₹100</li>
  <li>Kartika Pooje – ₹50</li>
  <li>Pancha Kajjaya – ₹20</li>
  <li>Halu Payasa – ₹100</li>
  <li>Chitranna Samarpane – ₹100</li>
</ol>

<h3>Harake Sevas</h3>

<ol>
  <li>Thulabhara – ₹75</li>
  <li>Chavala – ₹25</li>
  <li>Kivi Chuchhuvudu (Ear Piercing) – ₹20</li>
  <li>Anna Prashana – ₹25</li>
  <li>Namkarana – ₹150</li>
</ol>
  ''',
        'kn': '''
<h3>ದೈನಂದಿನ ಸೇವೆಗಳು</h3>

<ol>
  <li>ಮಹಾಪೂಜೆ (ಸಂಪೂರ್ಣ ದಿನ ಒಳಗೊಂಡಿದೆ) – ₹400</li>
  <li>ಮಹಾಪೂಜೆ (ಮಧ್ಯಾಹ್ನ ಒಳಗೊಂಡಿದೆ) – ₹250</li>
  <li>ಪವಮಾನ ಪಂಚಾಮೃತ ಅಭಿಷೇಕ – ₹100</li>
  <li>ಕಲಶ ಪೂಜೆ ಪಂಚಾಮೃತ ಅಭಿಷೇಕ – ₹100</li>
  <li>ಪಂಚಾಮೃತ ಅಭಿಷೇಕ – ₹75</li>
  <li>ರುದ್ರಾಭಿಷೇಕ – ₹75</li>
  <li>ಕ್ಷೀರಾಭಿಷೇಕ – ₹50</li>
  <li>ಶೇಷಸೇವೆ – ₹100</li>
  <li>ಕಾರ್ತಿಕ ಪೂಜೆ – ₹50</li>
  <li>ಪಂಚ ಕಜ್ಜಾಯ – ₹20</li>
  <li>ಹಾಲು ಪಾಯಸ – ₹100</li>
  <li>ಚಿತ್ರಾನ್ನ ಸಮರ್ಪಣೆ – ₹100</li>
</ol>

<h3>ಹರಕೆ ಸೇವೆಗಳು</h3>

<ol>
  <li>ತೂಲಾಭಾರ – ₹75</li>
  <li>ಚವಳ – ₹25</li>
  <li>ಕಿವಿ ಚುಚ್ಚುವುದು – ₹20</li>
  <li>ಅನ್ನಪ್ರಾಶನ – ₹25</li>
  <li>ನಾಮಕರಣ – ₹150</li>
</ol>
  '''
      },
      calendarMaxDate: "31-03-2026",
    ),
    Services(
      icon:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893679/kp_treck_yywfug.png',
      details: {
        'en': '''
<p>
Rising to an elevation of <b>1,712 meters</b>, Kumara Parvatha—also known as Pushpagiri—is the
<b>second-highest peak in Karnataka</b> and one of the most popular trekking destinations in the Western Ghats.
</p>

<p>
The trek offers a rewarding mix of dense forests, steep climbs, and open grasslands, making it a memorable experience for adventure lovers and nature enthusiasts.
</p>

<h3>Trek Routes & Distance Details</h3>

<div style="display:flex; flex-direction:column; gap:14px;">

  <!-- Route 1 -->
  <div style="padding:14px; border:1px solid #e0e0e0; border-radius:10px; background:#fafafa;">
    <strong>Route 1: Subrahmanya – Sheshaparvatha – Subrahmanya</strong>

    <ul style="margin-top:8px; padding-left:18px;">
      <li><b>Start Point:</b> Near Kukke Subrahmanya Temple</li>
      <li><b>Distance:</b> 14 km (one way) · <b>28 km</b> (round trip)</li>
      <li><b>Difficulty:</b> Long & Challenging</li>
      <li><b>Best For:</b> Experienced trekkers</li>
      <li>
        <b>Booking Option:</b>
        Select <b>District – Kodagu</b> →
        <b>Subrahmanya – Sheshaparvatha – Subrahmanya</b>
      </li>
    </ul>
  </div>

  <!-- Route 2 -->
  <div style="padding:14px; border:1px solid #e0e0e0; border-radius:10px; background:#f3f8ff;">
    <strong>Route 2: Beedahalli – Kumara Parvatha – Beedahalli</strong>

    <ul style="margin-top:8px; padding-left:18px;">
      <li><b>Start Point:</b> Beedahalli</li>
      <li><b>Distance:</b> 7 km (one way) · <b>14 km</b> (round trip)</li>
      <li><b>Difficulty:</b> Easier compared to Subrahmanya route</li>
      <li><b>Best For:</b> Beginners & moderate trekkers</li>
      <li>
        <b>Booking Option:</b>
        Select <b>Beedahalli – Kumara Parvatha – Beedahalli</b>
      </li>
    </ul>
  </div>

</div>

<h3>Trek Rules & Guidelines</h3>
<ul>
  <li>The trek must be <b>completed within a single day</b>.</li>
  <li><b>Camping is not permitted</b> on either trekking route.</li>
  <li>All trekkers are advised to start early and follow forest department rules.</li>
</ul>

<h3>Why Trek Kumara Parvatha?</h3>
<ul>
  <li>One of the highest and most scenic treks in Karnataka</li>
  <li>Choice of routes for both experienced and moderate-level trekkers</li>
  <li>Panoramic views from the summit</li>
  <li>A perfect blend of adventure and nature</li>
</ul>

<h3>Quick Info</h3>
<ul>
  <li><b>Difficulty:</b> Moderate to Difficult</li>
  <li><b>Duration:</b> 1 Day</li>
  <li><b>Best Season:</b> October to February</li>
  <li><b>Permit & Fees:</b> Entry pass required (₹350 per person) – valid ID proof mandatory</li>
  <li><b>Booking:</b> Trek permits are available only through the Karnataka Tourism official website</li>
</ul>

<p style="color:red; font-size:14px;">
  <strong>Important:</strong> Avoid trekking during monsoon months, as trails become slippery and leech-prone.
</p>

''',
        'kn': '''
<p>
<b>1,712 ಮೀಟರ್</b> ಎತ್ತರಕ್ಕೆ ಏರಿರುವ ಕುಮಾರ ಪರ್ವತ — ಪುಷ್ಪಗಿರಿ ಎಂದೂ ಕರೆಯಲ್ಪಡುವುದು —
<b>ಕರ್ನಾಟಕದ ಎರಡನೇ ಅತಿ ಎತ್ತರದ ಶಿಖರ</b>ವಾಗಿದ್ದು, ಪಶ್ಚಿಮ ಘಟ್ಟಗಳಲ್ಲಿನ ಅತ್ಯಂತ ಜನಪ್ರಿಯ ಟ್ರೆಕ್ಕಿಂಗ್ ಸ್ಥಳಗಳಲ್ಲಿ ಒಂದಾಗಿದೆ.
</p>

<p>
ಈ ಟ್ರೆಕ್ ದಟ್ಟವಾದ ಕಾಡುಗಳು, ತೀವ್ರ ಏರುಬಾಗಿಲುಗಳು ಮತ್ತು ವಿಶಾಲ ಹುಲ್ಲುಮೈದಾನಗಳ ಸಂಯೋಜನೆಯನ್ನು ನೀಡುತ್ತಿದ್ದು,
ಸಾಹಸ ಪ್ರಿಯರು ಮತ್ತು ಪ್ರಕೃತಿ ಪ್ರೇಮಿಗಳಿಗೆ ಮರೆಯಲಾಗದ ಅನುಭವವಾಗಿರುತ್ತದೆ.
</p>

<h3>ಟ್ರೆಕ್ ಮಾರ್ಗಗಳು ಮತ್ತು ದೂರದ ವಿವರಗಳು</h3>

<div style="display:flex; flex-direction:column; gap:14px;">

  <!-- Route 1 -->
  <div style="padding:14px; border:1px solid #e0e0e0; border-radius:10px; background:#fafafa;">
    <strong>ಮಾರ್ಗ 1: ಸುಬ್ರಹ್ಮಣ್ಯ – ಶೇಷಪರ್ವತ – ಸುಬ್ರಹ್ಮಣ್ಯ</strong>

    <ul style="margin-top:8px; padding-left:18px;">
      <li><b>ಪ್ರಾರಂಭ ಸ್ಥಳ:</b> ಕುಕ್ಕೆ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನದ ಬಳಿ</li>
      <li><b>ದೂರ:</b> 14 ಕಿಮೀ (ಒಂದು ದಾರಿ) · <b>28 ಕಿಮೀ</b> (ರೌಂಡ್ ಟ್ರಿಪ್)</li>
      <li><b>ಕಷ್ಟದ ಮಟ್ಟ:</b> ದೀರ್ಘ ಮತ್ತು ಸವಾಲಿನದು</li>
      <li><b>ಯಾರಿಗೆ ಸೂಕ್ತ:</b> ಅನುಭವಿ ಟ್ರೆಕ್ಕರ್‌ಗಳಿಗೆ</li>
      <li>
        <b>ಬುಕಿಂಗ್ ಆಯ್ಕೆ:</b>
        <b>ಜಿಲ್ಲೆ – ಕೊಡಗು</b> →
        <b>ಸುಬ್ರಹ್ಮಣ್ಯ – ಶೇಷಪರ್ವತ – ಸುಬ್ರಹ್ಮಣ್ಯ</b> ಆಯ್ಕೆಮಾಡಿ
      </li>
    </ul>
  </div>

  <!-- Route 2 -->
  <div style="padding:14px; border:1px solid #e0e0e0; border-radius:10px; background:#f3f8ff;">
    <strong>ಮಾರ್ಗ 2: ಬೀಡಹಳ್ಳಿ – ಕುಮಾರ ಪರ್ವತ – ಬೀಡಹಳ್ಳಿ</strong>

    <ul style="margin-top:8px; padding-left:18px;">
      <li><b>ಪ್ರಾರಂಭ ಸ್ಥಳ:</b> ಬೀಡಹಳ್ಳಿ</li>
      <li><b>ದೂರ:</b> 7 ಕಿಮೀ (ಒಂದು ದಾರಿ) · <b>14 ಕಿಮೀ</b> (ರೌಂಡ್ ಟ್ರಿಪ್)</li>
      <li><b>ಕಷ್ಟದ ಮಟ್ಟ:</b> ಸುಬ್ರಹ್ಮಣ್ಯ ಮಾರ್ಗಕ್ಕಿಂತ ಸುಲಭ</li>
      <li><b>ಯಾರಿಗೆ ಸೂಕ್ತ:</b> ಆರಂಭಿಕರು ಮತ್ತು ಮಧ್ಯಮ ಮಟ್ಟದ ಟ್ರೆಕ್ಕರ್‌ಗಳಿಗೆ</li>
      <li>
        <b>ಬುಕಿಂಗ್ ಆಯ್ಕೆ:</b>
        <b>ಬೀಡಹಳ್ಳಿ – ಕುಮಾರ ಪರ್ವತ – ಬೀಡಹಳ್ಳಿ</b> ಆಯ್ಕೆಮಾಡಿ
      </li>
    </ul>
  </div>

</div>

<h3>ಟ್ರೆಕ್ ನಿಯಮಗಳು ಮತ್ತು ಮಾರ್ಗಸೂಚಿಗಳು</h3>
<ul>
  <li>ಟ್ರೆಕ್ ಅನ್ನು <b>ಒಂದು ದಿನದಲ್ಲೇ ಪೂರ್ಣಗೊಳಿಸಬೇಕು</b>.</li>
  <li>ಯಾವುದೇ ಮಾರ್ಗದಲ್ಲಿಯೂ <b>ಶಿಬಿರ ಹೂಡುವುದಕ್ಕೆ ಅನುಮತಿ ಇಲ್ಲ</b>.</li>
  <li>ಎಲ್ಲಾ ಟ್ರೆಕ್ಕರ್‌ಗಳು ಬೆಳಗ್ಗೆ ಬೇಗ ಆರಂಭಿಸಿ ಅರಣ್ಯ ಇಲಾಖೆಯ ನಿಯಮಗಳನ್ನು ಪಾಲಿಸಬೇಕು.</li>
</ul>

<h3>ಏಕೆ ಕುಮಾರ ಪರ್ವತ ಟ್ರೆಕ್?</h3>
<ul>
  <li>ಕರ್ನಾಟಕದ ಅತಿ ಎತ್ತರದ ಮತ್ತು ಅತ್ಯಂತ ಸುಂದರ ಟ್ರೆಕ್‌ಗಳಲ್ಲಿ ಒಂದು</li>
  <li>ಅನುಭವಿ ಹಾಗೂ ಮಧ್ಯಮ ಮಟ್ಟದ ಟ್ರೆಕ್ಕರ್‌ಗಳಿಗೆ ವಿಭಿನ್ನ ಮಾರ್ಗಗಳ ಆಯ್ಕೆ</li>
  <li>ಶಿಖರದಿಂದ ಕಾಣುವ ಮನಮೋಹಕ ನೋಟಗಳು</li>
  <li>ಸಾಹಸ ಮತ್ತು ಪ್ರಕೃತಿಯ ಪರಿಪೂರ್ಣ ಸಂಯೋಜನೆ</li>
</ul>

<h3>ತ್ವರಿತ ಮಾಹಿತಿ</h3>
<ul>
  <li><b>ಕಷ್ಟದ ಮಟ್ಟ:</b> ಮಧ್ಯಮದಿಂದ ಕಠಿಣ</li>
  <li><b>ಅವಧಿ:</b> 1 ದಿನ</li>
  <li><b>ಉತ್ತಮ ಕಾಲ:</b> ಅಕ್ಟೋಬರ್‌ನಿಂದ ಫೆಬ್ರವರಿವರೆಗೆ</li>
  <li><b>ಪರ್ಮಿಟ್ ಮತ್ತು ಶುಲ್ಕ:</b> ಪ್ರವೇಶ ಪಾಸ್ ಅಗತ್ಯ (ಪ್ರತಿ ವ್ಯಕ್ತಿಗೆ ₹350) – ಮಾನ್ಯ ಗುರುತಿನ ಚೀಟಿ ಕಡ್ಡಾಯ</li>
  <li><b>ಬುಕಿಂಗ್:</b> ಟ್ರೆಕ್ ಪರವಾನಗಿಗಳು ಕರ್ನಾಟಕ ಪ್ರವಾಸೋದ್ಯಮದ ಅಧಿಕೃತ ವೆಬ್‌ಸೈಟ್ ಮೂಲಕ ಮಾತ್ರ ಲಭ್ಯ</li>
</ul>

<p style="color:red; font-size:14px;">
  <strong>ಮುಖ್ಯ ಸೂಚನೆ:</strong> ಮಳೆಗಾಲದ ಸಮಯದಲ್ಲಿ ಟ್ರೆಕ್ಕಿಂಗ್ ತಪ್ಪಿಸಿ, ಏಕೆಂದರೆ ದಾರಿಗಳು ಜಾರಿ ಮತ್ತು ಜಲಾವೃತವಾಗಿರುತ್ತವೆ.
</p>
'''
      },
      isCalendar: false,
      id: 'KumaraParvathaTrek',
      name: {
        'en': 'Kumara Parvatha Trek',
        'kn': 'ಕುಮಾರ ಪರ್ವತ ಟ್ರೆಕ್',
      },
      purpose: {
        'en': '',
        'kn': '',
      },
      images: [
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949730/Kumara_Parvatha_rjsekj.jpg',
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949741/Kumara_Parvatha1_ty8yy7.jpg',
        // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949909/Kumara_Parvatha4_ydpyeo.png',
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949811/Kumara_Parvatha2_jihuxo.jpg',
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949816/Kumara_Parvatha3_bodqcf.jpg',
      ],
      bookNowButton: true,
      weblink:
          'https://trek.kodaguecotourism.com/trailDetail/14/Subramanya%20-%20Kumaraparvatha',
      rituals: {
        'en': '',
        'kn': '',
      },
      howToBook: {
        'en': '',
        'kn': '',
      },
      fee: {
        'en': '',
        'kn': '',
      },
      tips: {
        'en': '',
        'kn': '',
      },
      calendarMaxDate: "31-03-2026",
    ),
  ],
  timings: [
    Timings(
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
      day: "Monday",
      slots: [
        TimeSlot(from: "6AM", to: "1PM"),
        TimeSlot(from: "3PM", to: "8PM"),
      ],
      lunch: [
        TimeSlot(from: "1PM", to: "3PM"),
      ],
    ),
    Timings(
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
      day: "Tuesday",
      slots: [
        TimeSlot(from: "6AM", to: "1PM"),
        TimeSlot(from: "3PM", to: "8PM"),
      ],
      lunch: [
        TimeSlot(from: "1PM", to: "3PM"),
      ],
    ),
    Timings(
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
      day: "Wednesday",
      slots: [
        TimeSlot(from: "6AM", to: "1PM"),
        TimeSlot(from: "3PM", to: "8PM"),
      ],
      lunch: [
        TimeSlot(from: "1PM", to: "3PM"),
      ],
    ),
    Timings(
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
      day: "Thursday",
      slots: [
        TimeSlot(from: "6AM", to: "1PM"),
        TimeSlot(from: "3PM", to: "5.25PM"),
      ],
      lunch: [
        TimeSlot(from: "1PM", to: "3PM"),
      ],
    ),
    Timings(
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
      day: "Friday",
      slots: [
        TimeSlot(from: "6AM", to: "8AM"),
        TimeSlot(from: "3PM", to: "8PM"),
      ],
      lunch: [
        TimeSlot(from: "1PM", to: "3PM"),
      ],
    ),
    Timings(
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
      day: "Saturday",
      slots: [
        TimeSlot(from: "6AM", to: "1PM"),
        TimeSlot(from: "3PM", to: "8PM"),
      ],
      lunch: [
        TimeSlot(from: "1PM", to: "3PM"),
      ],
    ),
    Timings(
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
      day: "Sunday",
      slots: [
        TimeSlot(from: "6AM", to: "1PM"),
        TimeSlot(from: "3PM", to: "8PM"),
      ],
      lunch: [
        TimeSlot(from: "1PM", to: "3PM"),
      ],
    ),
  ],
  videos: [
    PoojaVideos(
      name: {'en': 'Morning Pooja', 'kn': 'ಮಾರ್ನಿಂಗ್ ಪೂಜೆ'},
      image:
          'https://icctmemphis.org/wp-content/uploads/2023/01/Subramanya_Valli_Devasena-scaled-e1675130620249.jpg',
      url: 'https://www.youtube.com/shorts/u2m8QZUXXjw',
      //'https://youtu.be/yXxeQndQYEM',
    ),
    PoojaVideos(
      name: {'en': 'Evening Pooja', 'kn': 'ಸಂಜೆ ಪೂಜೆ'},
      image:
          'https://i.pinimg.com/736x/35/16/1a/35161a12f032244c3c78249d726ecb3d.jpg',
      url: 'https://youtu.be/yXxeQndQYEM',
    ),
    PoojaVideos(
      name: {'en': 'Special Pooja', 'kn': 'ಪ್ರತ್ಯೇಕ ಪೂಜೆ'},
      image:
          'https://m.media-amazon.com/images/I/81VkuGYTB2L._UF894,1000_QL80_.jpg',
      url: 'https://youtu.be/yXxeQndQYEM',
    ),
  ],
  bhajans: [
    Bhajans(
      name: {
        'en': 'Namo Namo Shri',
        'kn': 'ನಮೋ ನಮೋ ಶ್ರೀ',
      },
      image:
          'https://res.cloudinary.com/dftflve8u/image/upload/v1766416944/Cimg8_mepek4.jpg',
      url: 'https://archive.org/download/Venkatachala-Nilayam/01%20-%20Dristi%20Ninna%20Padadalli.mp3'
      //'https://youtu.be/8H2WFMXXgZI?si=enUE26paHHWDARqu',
    ),
    Bhajans(
      name: {'en': 'Huthadinda Eddu', 'kn': 'ಹುತ್ತದಿಂದ ಎದ್ದು'},
      image:
          'https://res.cloudinary.com/dftflve8u/image/upload/v1766333387/Pooja_Imag3_t7tvbb.jpg',
      url: "https://res.cloudinary.com/dftflve8u/video/upload/v1771826431/Subramanya_Ashtakam_-_Sacred_Chants_bgn2r6.mp3"
      //'https://youtu.be/fqXsdsLd1p0?si=yeUCXSyjIQfRfi1b',
    ),
    Bhajans(
      name: {'en': 'Nagana Roopadi', 'kn': 'ನಾಗನ ರೂಪದಿ'},
      image:
          'https://res.cloudinary.com/dftflve8u/image/upload/v1766333662/Pooja_image5_zfktxk.jpg',
      url: 
      //'https://res.cloudinary.com/dftflve8u/video/upload/v1771582796/info_tccfyc.mp4'
      'https://youtu.be/38tgnkkIcRw?si=1ho_VGqqcJ7EVdN5',
    ),
  ],
  nearByPlaces: [
    NearByPlaces(
      name: {
        'en': 'Basaveshwara temple Kulkunda',
        'kn': 'ಬಸವೇಶ್ವರ ದೇವಸ್ಥಾನ ಕುಲ್ಕುಂಡ'
      },
      images: [
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759741561/Basaveshwara_temple_Kulkunda_ade9lh.jpg',
      ],
      description: {
        'en': '''
<h3>Basaveshwara Temple, Kulkunda</h3>
<p>
Located just <b>4 km from Kukke Temple</b>, this <b>800-year-old shrine</b> showcases
ancient Hindu architecture with a <b>unique Shivalinga on Nandi’s forehead</b>.
</p>
  ''',
        'kn': '''
<h3>ಬಸವೇಶ್ವರ ದೇವಸ್ಥಾನ, ಕುಲ್ಕುಂಡ</h3>
<p>
ಕುಕ್ಕೆ ದೇವಸ್ಥಾನದಿಂದ ಕೇವಲ <b>4 ಕಿಮೀ</b> ದೂರದಲ್ಲಿರುವ ಈ <b>800 ವರ್ಷಗಳ ಹಳೆಯ ದೇವಾಲಯ</b> ಪ್ರಾಚೀನ ಹಿಂದೂ ವಾಸ್ತುಶಿಲ್ಪವನ್ನು ತೋರಿಸುತ್ತದೆ, <b>ನಂದಿಯ ಮುಚ್ಚಳದ ಮೇಲೆ ವಿಶಿಷ್ಟ ಶಿವಲಿಂಗ</b> ಸಹಿತ.
</p>
  '''
      },
      directionButton: true,
      weblink: 'https://maps.app.goo.gl/mp3hEt4ssudMDUhR6',
      url: '',
    ),

    NearByPlaces(
      name: {
        'en': 'Somanatheshwara temple',
        'kn': 'ಸೋಮನಾಥೇಶ್ವರ ದೇವಸ್ಥಾನ',
      },
      images: [
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742005/Shri_Somanatheshwara_temple_hgwtja.jpg',
      ],
      description: {
        'en': '''
<h3>Shri Somanatheshwara Temple</h3>

<p>
Located just <b>2 km from Kukke Temple</b>, the <b>Agrahara Somanath Temple</b> is an
<b>800-year-old shrine</b> situated on the riverbank, reflecting the grandeur of
ancient Hindu architecture.
</p>
''',
        'kn': '''
<h3>ಶ್ರೀ ಸೋಮನಾಥೇಶ್ವರ ದೇವಸ್ಥಾನ</h3>

<p>
ಕುಕ್ಕೆ ದೇವಸ್ಥಾನದಿಂದ ಕೇವಲ <b>2 ಕಿಮೀ ದೂರದಲ್ಲಿ</b>, <b>ಅಗ್ರಹಾರ ಸೋಮನಾಥ ದೇವಸ್ಥಾನ</b>
ಒಂದು <b>800 ವರ್ಷದ ಹಳೆಯ ದೇವಸ್ಥಾನ</b>, ನದಿ ತೀರದಲ್ಲಿ ಸ್ಥಿತವಾಗಿದೆ ಮತ್ತು
ಪ್ರಾಚೀನ ಹಿಂದೂ ವಾಸ್ತುಶಿಲ್ಪದ ಮಹತ್ವವನ್ನು ಪ್ರತಿಬಿಂಬಿಸುತ್ತದೆ.
</p>
'''
      },
      directionButton: true,
      weblink: 'https://maps.app.goo.gl/9WnpfaDLKqBGmhEz8',
      url: '',
    ),
    NearByPlaces(
      name: {
        'en': 'Shankapala Subrahmanya Temple',
        'kn': 'ಶಂಕಪಾಲ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನ',
      },
      images: [
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742245/Shri_Shankapala_Subrahmanya_Swami_Temple_cnd92j.jpg',
      ],
      description: {
        'en': '''
<h3>Shri Shankapala Subrahmanya Swami Temple</h3>

<p>
It is located about <b>10 km from Kukke Temple</b>. A unique feature of this temple is
the presence of a <b>live anthill (hutta)</b> inside the sanctum.
</p>
  ''',
        'kn': '''
<h3>ಶ್ರೀ ಶಂಕಪಾಲ ಸುಬ್ರಹ್ಮಣ್ಯ ಸ್ವಾಮಿ ದೇವಸ್ಥಾನ</h3>

<p>
ಇದು <b>ಕುಕ್ಕೆ ದೇವಾಲಯದಿಂದ 10 ಕಿಮೀ</b> ದೂರದಲ್ಲಿದೆ. ಈ ದೇವಾಲಯದ ವಿಶೇಷತೆ ಎಂದರೆ
ಪ್ರಾರ್ಥನಾ ಕ್ಷೇತ್ರದೊಳಗೆ <b>ಜೀವಂತ ಹುಟ್ಟ (ಹುಟ್ಟ)</b> ಇರುವುದು.
</p>
  ''',
      },
      directionButton: true,
      weblink: 'https://maps.app.goo.gl/ccHSTWV5kPniqSEJA',
      url: '',
    ),

    NearByPlaces(
      name: {
        'en': 'Marakatha DurgaParameshwari Temple',
        'kn': 'ಮರಕಥ ದುರ್ಗಾಪರಮೇಶ್ವರಿ ದೇವಸ್ಥಾನ',
      },
      images: [
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742425/Marakatha_DurgaParameshwari_Temple_i2glza.jpg',
      ],
      description: {
        'en': '''
<h3>Marakatha Durga Parameshwari Temple</h3>

<p>
Located about <b>8 km from Kukke Temple</b>, it sits on the banks of the <b>Kotitheertha River</b>
flowing from Shesha Parvata. Surrounded by greenery, it’s believed that feeding the fish here
and praying to the Lord fulfills one’s wishes.
</p>
''',
        'kn': '''
<h3>ಮರಕಥ ದುರ್ಗಾ ಪರಮೇಶ್ವರಿ ದೇವಸ್ಥಾನ</h3>

<p>
ಕುಕ್ಕೇ ದೇವಸ್ಥಾನದಿಂದ ಸುಮಾರು <b>8 ಕಿ.ಮೀ.</b> ದೂರದಲ್ಲಿದ್ದು, ಇದು ಶೇಷಪರ್ವತದಿಂದ ಹರಿಯುವ <b>ಕೋಟೀಥೇರ್ಥ ನದಿ</b> ತೀರದಲ್ಲಿ
ನಿಂತಿದೆ. ಹಸಿರು ಪರಿಸರದಿಂದ ಸುತ್ತಿಕೊಂಡಿರುವ ಈ ಸ್ಥಳದಲ್ಲಿ ಮೀನುಗಳನ್ನು ಆಹಾರ ನೀಡಿ ದೇವರಿಗೆ ಪ್ರಾರ್ಥನೆ ಮಾಡುವುದರಿಂದ
ಮನೋವೀಕ್ಷೆಗಳು ಪೂರಣವಾಗುತ್ತದೆ ಎಂದು ನಂಬಲಾಗುತ್ತದೆ.
</p>
'''
      },
      directionButton: true,
      weblink: 'https://maps.app.goo.gl/vtxNxoQtPBcUyC2P6',
      url: '',
    ),
    // NearByPlaces(
    //   name: 'Shringeri Shree Sharadambe Devi Temple',
    //   images:
    //      [ 'https://www.holidify.com/images/cmsuploads/compressed/1873074727_e470479cfe_b_20170609180808.jpg',],
    //   url: '',
    //   description: '',
    // ),
    // NearByPlaces(
    //   name: 'Subrahmanya Mutt',
    //   images:[ 'https://www.holidify.com/images/cmsuploads/compressed/4623_20200619164848.JPG',]
    //      ,
    //   url: '',
    //   description: '',
    // ),
  ],
  wallpapers: [
    Wallpapers(
      shareTitle: "Subrahmanya",
      shareDescription: "Seek Subrahmanya Blessings",
      image:
          // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759908404/Lord_Venkataramana_nhxtds.png',
          'https://res.cloudinary.com/dftflve8u/image/upload/v1765608954/kukke_god4_niibpa.jpg',
    ),
    Wallpapers(
      shareTitle: "Lord Venkataramana",
      shareDescription: "Seek Balaji's Blessings",
      image:
          // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759908404/Lord_Venkataramana_nhxtds.png',
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759913291/Lord_Venkatesha_debldh.jpg',
    ),
    Wallpapers(
      shareTitle: "Lord Ganesha: Vighnaharta",
      shareDescription:
          "May the Remover of Obstacles, Lord Ganesha, bless your endeavors with success. Om Gan Ganapataye Namaha.",
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759918437/Lord_Ganesha1_as7240.jpg',
    ),
    Wallpapers(
      shareTitle: "Jai Shri Krishna",
      shareDescription:
          "May the enchanting flute of Lord Krishna bring joy, love, and peace to your heart. Jai Shri Krishna!",
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759918464/Lord_Krishna1_mnr40y.jpg',
    ),
    Wallpapers(
      shareTitle: "Goddess Lakshmi Blessings",
      shareDescription:
          "May the divine grace of Goddess Lakshmi fill your life with abundance, prosperity, and good fortune.",
      image:
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759913540/Goddess_Lakshmi_e8os62.jpg',
    ),
  ],
  calender: {
    "shuddaShasti": [
      "03-04-2025",
      "02-05-2025",
      "01-06-2025",
      "01-07-2025",
      "30-07-2025",
      "29-08-2025",
      "28-09-2025",
      "27-10-2025",
      "26-11-2025",
      "26-12-2025",
      "26-12-2025",
      "24-01-2026",
      "22-02-2026",
    ],
    "ashleshanakshathra": [
      "07-04-2025",
      "05-05-2025",
      "01-06-2025",
      "28-06-2025",
      "26-07-2025",
      "22-08-2025",
      "18-09-2025",
      "16-10-2025",
      "12-11-2025",
      "09-12-2025",
      "06-01-2026",
      "02-02-2026",
      "02-03-2026"
    ],
    "yekadashi": [
      "08-04-2025",
      "24-04-2025",
      "08-05-2025",
      "23-05-2025",
      "06-06-2025",
      "07-06-2025",
      "22-06-2025",
      "06-07-2025",
      "21-07-2025",
      "05-08-2025",
      "19-08-2025",
      "03-09-2025",
      "07-09-2025",
      "14-09-2025",
      "17-09-2025",
      "03-10-2025",
      "17-10-2025",
      "02-11-2025",
      "15-11-2025",
      "01-12-2025",
      "15-12-2025",
      "14-01-2026",
      "29-01-2026",
      "13-02-2026",
      "15-02-2026",
      "27-02-2026",
      "03-03-2026",
      "15-03-2026",
    ],
  },
);

//Production
// final templeData = Temple(
//   password: 'Kukke2\$2*?!',
//   privacyPolicy: 'https://sites.google.com/view/yatrify',
//   termsAndCondition: 'https://sites.google.com/view/yatrify-terms-conditions',
//   webLogo:
//       'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760338098/weblogo_bo09n0.png',
//   isSmallBannerShow: true,
//   logo:
//       'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760333124/logo_k8ljmu.png',
//   banner: [
//     TempleBanner(
//       bannerImage:
//           // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
//           // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759465403/banner_lfafdc.jpg',
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759736124/banner1_pfpvjl.jpg',
//       link: '',
//     ),
//   ],
//   smallBanner: [
//     SmallBanner(
//       bannerImage:
//           'https://res.cloudinary.com/dftflve8u/image/upload/v1765721022/Kan_Text_cgfd1w.png',
//       //'https://www.dreamstime.com/photos-images/sweets-mithai-diwali-banner.html',
//       link: 'https://sites.google.com/view/yatrify-terms-conditions',
//     ),
//     SmallBanner(
//       bannerImage:
//           'https://res.cloudinary.com/dftflve8u/image/upload/v1765721260/English_mxjagv.png',
//       link: 'https://sites.google.com/view/yatrify-terms-conditions',
//     ),
//     // SmallBanner(
//     //   bannerImage:
//     //       'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760003436/small_banner2_nwjugj.jpg',
//     //   link: '',
//     // ),
//     // SmallBanner(
//     //   bannerImage:
//     //       'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760003435/small_banner3_epyaba.jpg',
//     //   link: 'https://www.kantisweets.com/branch',
//     // ),
//   ],
//   services: [
//     Services(
//       details: {
//         'en': '',
//         'kn': '',
//       },
//       isCalendar: true,
//       id: 'SarpaSamskara',
//       name: {
//         'en': 'Sarpa Samskara',
//         'kn': 'ಸರ್ಪ ಸಂಸ್ಕಾರ',
//       },
//       icon:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893680/sarpa_samskara_ifsyf1.png',
//       purpose: {
//         'en': '''
// <p>
//   <strong>Relief from Sarpa/Naga Dosha</strong> – This pooja removes the negative effects that come from harming or killing snakes knowingly or unknowingly, in this life or past lives.
//   <br><br>
//   <strong>Ancestral Peace (Pitru Dosha)</strong> – It helps to clear ancestral curses and brings peace to forefathers, which in turn brings their blessings to the family.
//   <br><br>
//   <strong>Marriage &amp; Children Blessings</strong> – The pooja helps remove obstacles in marriage, solves issues of late marriage, and blesses couples who are struggling to have children.
// </p>
// ''',
//         'kn': '''
// <p>
//   <strong>ಸರ್ಪ/ನಾಗ ದೋಷದಿಂದ ಮುಕ್ತಿ</strong> – ಈ ಪೂಜೆ ಜಾಣ್ಮೆಯಿಂದ ಅಥವಾ ಅಜಾಣ್ಮೆಯಿಂದ ಸರ್ಪಗಳಿಗೆ ಹಾನಿ ಮಾಡಿದ ಅಥವಾ ಕೊಂದ ಪರಿಣಾಮಗಳಿಂದ ಉಂಟಾಗುವ ನಕಾರಾತ್ಮಕ ಪರಿಣಾಮಗಳನ್ನು ನಿವಾರಿಸುತ್ತದೆ, ಈ ಜೀವನದಲ್ಲಿ ಅಥವಾ ಹಿಂದಿನ ಜೀವನಗಳಲ್ಲಿ.
//   <br><br>
//   <strong>ಪೂರ್ವಜರ ಶಾಂತಿ (ಪಿತೃ ದೋಷ)</strong> – ಇದು ಪೂರ್ವಜರ ಶಾಪಗಳನ್ನು ಶುದ್ಧಗೊಳಿಸಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ ಮತ್ತು ಪೂರ್ವಜರಿಗೆ ಶಾಂತಿ ನೀಡುತ್ತದೆ, ಇದರಿಂದ ಕುಟುಂಬಕ್ಕೆ ಅವರ ಆಶೀರ್ವಾದಗಳು ಬರುತ್ತವೆ.
//   <br><br>
//   <strong>ವಿವಾಹ &amp; ಮಕ್ಕಳ ಆಶೀರ್ವಾದ</strong> – ಈ ಪೂಜೆ ವಿವಾಹದಲ್ಲಿ ಅಡಚಣೆಗಳನ್ನು ತೆಗೆದುಹಾಕಲು, ವಿಳಂಬ ವಿವಾಹದ ಸಮಸ್ಯೆಗಳನ್ನು ಪರಿಹರಿಸಲು ಮತ್ತು ಮಕ್ಕಳಾಗಲು ಹೋರಾಡುತ್ತಿರುವ ದಂಪತಿಗಳನ್ನು ಆಶೀರ್ವದಿಸಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ.
// </p>
// '''
//       },
//       images: [
//         'https://res.cloudinary.com/dftflve8u/image/upload/v1765695183/Sarpa_Samskara2_lqmutc.png',
//         'https://res.cloudinary.com/dftflve8u/image/upload/v1765695182/Kaala-Sarpa-Shanti-Homa.png_jzgtlo.webp',
//         'https://res.cloudinary.com/dftflve8u/image/upload/v1765695956/Pooja-Services-1_wxjcie.webp',
//       ],
//       bookNowButton: true,
//       weblink:
//           'https://itms.kar.nic.in/ticketing/service_collection.php?tid=21&scode=21&sscode=1&target_type=&fees_slno=204256&group_id=4&action=P',
//       rituals: {
//         'en': '''
// <p>
// Sarpa Samskara is a 2-day pooja. Devotees are advised to visit the temple one day early.  
// Take a holy bath in the <b>Kumaradhara River</b> before entering the temple for the pooja, and wear simple, traditional clothes.
// </p>

// <h4>Day 1 – Main Steps</h4>
// <ol>
//   <li><b>Registration & Seating</b> – Show your ticket, complete registration, and sit in your assigned place inside the mantap.</li>
//   <li><b>Sankalpa (Prayer of Intention)</b> – The devotee or family states their name and purpose for the pooja with the help of the priest.</li>
//   <li><b>Sarpa Samskara Ritual</b> – A special Homa and other rites are performed to seek forgiveness for harming snakes knowingly or unknowingly, in this or past lives.</li>
// </ol>

// <h4>Day 2 – Final Steps</h4>
// <ol>
//   <li><b>Morning Abhisheka to Lord Subrahmanya</b> – The main deity is bathed with milk, water, and panchamruta, followed by prayers.</li>
//   <li><b>Naga Pooja / Nagapratishtha</b> – Snake idols are worshipped with milk, flowers, turmeric, and kumkum, and placed as an offering.</li>
// </ol>
// ''',
//         'kn': '''
// <p>
// ಸರ್ಪ ಸಂಸ್ಕಾರವು 2-ದಿನಗಳ ಪೂಜೆ. ಭಕ್ತರು ಒಂದು ದಿನ ಮುಂಚಿತವಾಗಿ ದೇವಸ್ಥಾನಕ್ಕೆ ಬರುವಂತೆ ಸಲಹೆ ನೀಡಲಾಗಿದೆ.  
// ಪೂಜೆಗೆ ದೇವಸ್ಥಾನಕ್ಕೆ ಹೋಗುವ ಮೊದಲು <b>ಕುಮಾರಧಾರಾ ನದಿ</b>ಯಲ್ಲಿ ಪವಿತ್ರ ಸ್ನಾನ ಮಾಡಿ, ಸರಳ, ಪರಂಪರೆಯ ಉಡುಪುಗಳನ್ನು ಧರಿಸಬೇಕು.
// </p>

// <h4>ದಿನ 1 – ಮುಖ್ಯ ಹಂತಗಳು</h4>
// <ol>
//   <li><b>ನೆಂದಾಣಿಕೆ & ಆಸನ</b> – ನಿಮ್ಮ ಟಿಕೆಟ್ ತೋರಿಸಿ, ನೋಂದಣಿಯನ್ನು ಪೂರ್ಣಗೊಳಿಸಿ ಮತ್ತು ಮಂಟಪದ ಒಳಗೆ ನಿಗದಿತ ಸ್ಥಳದಲ್ಲಿ ಕುಳಿತುಕೊಳ್ಳಿ.</li>
//   <li><b>ಸಂಕಲ್ಪ (ಪ್ರಾರ್ಥನೆಯ ಉದ್ದೇಶ)</b> – ಭಕ್ತರು ಅಥವಾ ಕುಟುಂಬವು ಪೂಜೆಯ ಉದ್ದೇಶವನ್ನು ಅರ್ಚಕರ ಸಹಾಯದಿಂದ ತಮ್ಮ ಹೆಸರು ಹೇಳುತ್ತಾರೆ.</li>
//   <li><b>ಸರ್ಪ ಸಂಸ್ಕಾರ ವಿಧಿ</b> – ಜಾಣ್ಮೆಯಿಂದ ಅಥವಾ ಅಜಾಣ್ಮೆಯಿಂದ ಸರ್ಪಗಳಿಗೆ ಹಾನಿ ಮಾಡಿದ ಮೇಲೆ ಕ್ಷಮೆ ಕೇಳಲು ವಿಶೇಷ ಹೊಮ ಮತ್ತು ಇತರ ವಿಧಿಗಳನ್ನು ನಡೆಸಲಾಗುತ್ತದೆ, ಈ ಅಥವಾ ಹಿಂದಿನ ಜೀವನಗಳಲ್ಲಿ.</li>
// </ol>

// <h4>ದಿನ 2 – ಅಂತಿಮ ಹಂತಗಳು</h4>
// <ol>
//   <li><b>ಶ್ರೀ ಸುಬ್ರಹ್ಮಣ್ಯನಿಗೆ ಬೆಳಗಿನ ಅಭಿಷೇಕ</b> – ಮುಖ್ಯ ದೇವತೆಯನ್ನು ಹಾಲು, ನೀರು, ಪಂಚಾಮೃತದಿಂದ ಸ್ನಾನ ಮಾಡಿಸಲಾಗುತ್ತದೆ, ಬಳಿಕ ಪ್ರಾರ್ಥನೆಗಳು ನಡೆಯುತ್ತವೆ.</li>
//   <li><b>ನಾಗ ಪೂಜೆ / ನಾಗ ಪ್ರತಿಷ್ಠಾ</b> – ಹಾಲು, ಹೂವುಗಳು, ಹಾಲದಿ, ಕುಂಕುಮದಿಂದ ನാഗ ಮೂರ್ತಿಗಳನ್ನು ಆರಾಧಿಸಿ, ಅರ್ಪಣೆ ಮಾಡಲಾಗುತ್ತದೆ.</li>
// </ol>
// '''
//       },
//       howToBook: {
//         'en': '''
// <p>
// Booking for the Sarpa Samskara Pooja is done <b>online only</b> through the official <b>Kukke Subrahmanya Temple</b> website.
// </p>

// <ol>
//   <li>Visit the official Kukke Subrahmanya Temple website and check the available calendar.</li>
//   <li>Note: On <b>Ekadashi days</b>, the pooja will not be performed.</li>
//   <li>Click on the <b>“Book Now”</b> button, select your preferred date, and fill in the required details.</li>
//   <li>Pay the <b>₹4200</b> fee directly to the temple through the website to confirm your booking.</li>
//   <li>Carry the booking receipt and a valid <b>ID proof</b> when you visit the temple for the pooja.</li>
// </ol>
// ''',
//         'kn': '''
// <p>
// ಸರ್ಪ ಸಂಸ್ಕಾರ ಪೂಜೆಯ ಬುಕಿಂಗ್ ಅನ್ನು ಅಧಿಕೃತ <b>ಕುಕ್ಕೆ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನ</b> ವೆಬ್‌ಸೈಟ್ ಮೂಲಕ <b>ಆನ್ಲೈನ್ ಮಾತ್ರ</b> ಮಾಡಲಾಗುತ್ತದೆ.
// </p>

// <ol>
//   <li>ಅಧಿಕೃತ ಕುಕ್ಕೆ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನ ವೆಬ್‌ಸೈಟ್‌ಗೆ ಭೇಟಿ ನೀಡಿ ಮತ್ತು ಲಭ್ಯವಿರುವ ಕ್ಯಾಲೆಂಡರ್ ಅನ್ನು ಪರಿಶೀಲಿಸಿ.</li>
//   <li>ಸೂಚನೆ: <b>एकोದಶಿ ದಿನಗಳಲ್ಲಿ</b>, ಪೂಜೆ ನಡೆಯುವುದಿಲ್ಲ.</li>
//   <li><b>“ಬುಕ್ ನೌ”</b> ಬಟನ್ ಅನ್ನು ಕ್ಲಿಕ್ ಮಾಡಿ, ನಿಮ್ಮ ಇಚ್ಛಿತ ದಿನಾಂಕವನ್ನು ಆಯ್ಕೆ ಮಾಡಿ, ಅಗತ್ಯವಿರುವ ವಿವರಗಳನ್ನು ಭರ್ತಿ ಮಾಡಿ.</li>
//   <li>ನಿಮ್ಮ ಬುಕಿಂಗ್ ದೃಢೀಕರಿಸಲು ವೆಬ್‌ಸೈಟ್ ಮೂಲಕ <b>₹4200</b> ಶುಲ್ಕವನ್ನು ನೇರವಾಗಿ ದೇವಸ್ಥಾನಕ್ಕೆ ಪಾವತಿಸಿ.</li>
//   <li>ಪೂಜೆಗೆ ಭೇಟಿ ನೀಡುವಾಗ ಬುಕಿಂಗ್ ರಸೀದಿ ಮತ್ತು ಮಾನ್ಯ <b>ID ಪ್ರೂಫ್</b> ಅನ್ನು ತರಬೇಕು.</li>
// </ol>
// '''
//       },
//       tips: {
//         'en': '''
// <style>
//   ul, ol, p { margin: 0; padding: 0; }
//   li { margin-bottom: 6px; }
// </style>

// <ul>
//   <li>Carry a valid <b>ID card</b>.</li>
//   <li><b>Note:</b> No pooja is performed on <b>Ekadashi</b> days.</li>
// </ul>
// ''',
//         'kn': '''
// <style>
//   ul, ol, p { margin: 0; padding: 0; }
//   li { margin-bottom: 6px; }
// </style>

// <ul>
//   <li>ಮಾನ್ಯ <b>ID ಕಾರ್ಡ್</b> ಅನ್ನು ತರುತ್ತಿರಿ.</li>
//   <li><b>ಸೂಚನೆ:</b> <b>एकोದಶಿ ದಿನಗಳಲ್ಲಿ</b> ಯಾವುದೇ ಪೂಜೆ ನಡೆಯುವುದಿಲ್ಲ.</li>
// </ul>
// '''
//       },
//       unavailableDateIds: [
//         'yekadashi',
//       ],
//       availableDateIds: [],
//       calendarMaxDate: "31-03-2026",
//     ),
//     Services(
//       details: {
//         'en': '',
//         'kn': '',
//       },
//       id: 'AshleshaBali',
//       name: {
//         'en': 'Ashlesha Bali',
//         'kn': 'ಅಶ್ಲೇಷ ಬಲಿ',
//       },
//       icon:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893679/ashlesha_bali_fydhmn.png',
//       purpose: {
//         'en': '''
// <p>To remove Sarpa Dosha (serpent curse) from one’s jataka (horoscope).</p>
// <p>Brings relief from obstacles in marriage, childbirth, and family life.</p>
// <p>Helps overcome ancestral karmic issues, financial instability, and health problems caused by Naga Dosha.</p>
// ''',
//         'kn': '''
// <p>ಸ್ವಂತ ಜಾತಕ (ಹೋರೋಸ್ಕೋಪ್) ನಿಂದ ಸರ್ಪ ದೋಷ (ಹುಲಿಯ ಶಾಪ) ತೆಗೆದುಹಾಕಲು.</p>
// <p>ವಿವಾಹ, ಸಂತಾನೋತ್ಪತ್ತಿ ಮತ್ತು ಕುಟುಂಬ ಜೀವನದ ಅಡ್ಡಿಗಳಿಂದ ಮುಕ್ತಿ ನೀಡುತ್ತದೆ.</p>
// <p>ಪಿತೃ ದೋಷದಿಂದ ಉಂಟಾಗುವ ಪೂರಕ ಸಮಸ್ಯೆಗಳು, ಹಣಕಾಸಿನ ಅಸ್ಥಿರತೆ ಮತ್ತು ಆರೋಗ್ಯ ಸಮಸ್ಯೆಗಳನ್ನು ದಾಟಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ.</p>
// '''
//       },
//       images: [
//         'https://res.cloudinary.com/dftflve8u/image/upload/v1765695415/Ashlesha_Bali_eyiriv.png',
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760338286/AshleshaBali2_jmtpqo.png',
//       ],
//       bookNowButton: true,
//       weblink:
//           'https://itms.kar.nic.in/ticketing/service_collection.php?tid=21&scode=21&sscode=1&target_type=&fees_slno=214319&group_id=4&action=P',
//       rituals: {
//         'en': '''
// <p><strong>Sankalpa:</strong> Devotee’s name, gotra, and purpose are declared.</p>
// <p>Pooja will be done in Ashlesha Bali Mantapa. Once done, you will be given the prasada.</p>
// <p><strong>Pooja duration:</strong> ~1.5 to 2 hours.</p>
// <p>Best performed on Ashlesha Nakshatra days.</p>
// ''',
//         'kn': '''
// <p><strong>ಸಂಕಲ್ಪ:</strong> ಭಕ್ತರ ಹೆಸರು, ಗೊತ್ರ ಮತ್ತು ಉದ್ದೇಶ ಘೋಷಿಸಲಾಗುತ್ತದೆ.</p>
// <p>ಪೂಜೆಯನ್ನು ಅಶ್ಲೇಷ ಬಾಳಿ ಮಂಟಪದಲ್ಲಿ ನಡೆಸಲಾಗುತ್ತದೆ. ಪೂಜೆ ನಂತರ, ನಿಮಗೆ ಪ್ರಸಾದ ನೀಡಲಾಗುತ್ತದೆ.</p>
// <p><strong>ಪೂಜೆ ಅವಧಿ:</strong> ~1.5 ರಿಂದ 2 ಗಂಟೆಗಳು.</p>
// <p>ಅಶ್ಲೇಷ ನಕ್ಷತ್ರ ದಿನಗಳಲ್ಲಿ ಅತ್ಯುತ್ತಮವಾಗಿ ನಡೆಸಲಾಗುತ್ತದೆ.</p>
// '''
//       },
//       howToBook: {
//         'en': '''
// <p>Book online via the official <strong>Kukke Subrahmanya Temple</strong> website.</p>
// <p>Tickets also available at the temple counter (subject to slot availability).</p>
// <p><strong>Cost:</strong> ₹400–₹500 per person (basic).</p>
// <p>Advance booking recommended, especially on <strong>Ashlesha Nakshatra</strong> days.</p>
// <p>Click the <strong>Book Now</strong> button below to proceed.</p>
// <p><strong>Yatrify</strong> redirects you to the official temple website for secure booking.</p>
// ''',
//         'kn': '''
// <p>ಅಧಿಕೃತ <strong>ಕುಕ್ಕೇ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನ</strong> ವೆಬ್‌ಸೈಟ್ ಮೂಲಕ ಆನ್ಲೈನ್‌ನಲ್ಲಿ ಬುಕ್ ಮಾಡಿ.</p>
// <p>ಟಿಕೆಟ್‌ಗಳು ದೇವಸ್ಥಾನದ ಕೌಂಟರ್‌ನಲ್ಲಿ ಕೂಡ ಲಭ್ಯವಿವೆ (ಸ್ಲಾಟ್ ಲಭ್ಯತೆ ಮೇಲೆ ಅವಲಂಬಿತವಾಗಿದೆ).</p>
// <p><strong>ಖರ್ಚು:</strong> ಪ್ರತಿ ವ್ಯಕ್ತಿಗೆ ₹400–₹500 (ಮೂಲ).</p>
// <p>ಮುಂಚಿತ ಬುಕ್ಕಿಂಗ್ ಶಿಫಾರಸು ಮಾಡಲಾಗುತ್ತದೆ, ವಿಶೇಷವಾಗಿ <strong>ಅಶ್ಲೇಷ ನಕ್ಷತ್ರ</strong> ದಿನಗಳಲ್ಲಿ.</p>
// <p>ಮುಂದೆProceed ಮಾಡಲು ಕೆಳಗಿನ <strong>ಬುಕ್ ನೌ</strong> ಬಟನ್ ಕ್ಲಿಕ್ ಮಾಡಿ.</p>
// <p><strong>ಯಾತ್ರಿಫೈ</strong> ಸುರಕ್ಷಿತ ಬುಕ್ಕಿಂಗ್ ಗಾಗಿ ಅಧಿಕೃತ ದೇವಸ್ಥಾನ ವೆಬ್‌ಸೈಟ್‌ಗೆ ರೀಡೈರೆಕ್ಟ್ ಮಾಡುತ್ತದೆ.</p>
// '''
//       },
//       fee: {
//         'en': '',
//         'kn': '',
//       },
//       tips: {
//         'en': '''
// <p><strong>Ashlesha Nakshatra</strong> is the most auspicious day for this pooja.</p>
// <p>Not performed on <strong>Ekadashi</strong>, so check the calendar before booking.</p>
// ''',
//         'kn': '''
// <p><strong>ಅಶ್ಲೇಷ ನಕ್ಷತ್ರ</strong> ಈ ಪೂಜೆಗೆ ಅತ್ಯಂತ ಶುಭದ ದಿನವಾಗಿದೆ.</p>
// <p><strong>ಏಕಾದಶಿ</strong> ದಿನ ಪೂಜೆ ನಡೆಯುವುದಿಲ್ಲ, ಆದ್ದರಿಂದ ಬುಕ್ಕಿಂಗ್ ಮಾಡುವ ಮೊದಲು ಕ್ಯಾಲೆಂಡರ್ ಪರಿಶೀಲಿಸಿ.</p>
// '''
//       },
//       videos: [
//         ServiceVideo(
//             id: 'Kukke Subramanya',
//             name: 'Kukke Subramanya',
//             details: 'Kukke Subramanya ',
//             link: 'https://youtu.be/YmXgWdy74t8'),
//         ServiceVideo(
//             id: 'Kukke Subramanya',
//             name: 'Kukke Subramanya',
//             details: 'Kukke Subramanya ',
//             link: 'https://youtu.be/YmXgWdy74t8'),
//         ServiceVideo(
//             id: 'Kukke Subramanya',
//             name: 'Kukke Subramanya',
//             details: 'Kukke Subramanya ',
//             link: 'https://youtu.be/YmXgWdy74t8'),
//       ],
//       isCalendar: true,
//       availableDateIds: [
//         'shuddaShasti',
//         'ashleshanakshathra',
//       ],
//       unavailableDateIds: [
//         'yekadashi',
//       ],
//       calendarMaxDate: "31-03-2026",
//     ),
//     Services(
//       details: {
//         'en': '',
//         'kn': '',
//       },
//       id: 'NagaPrathishta',
//       name: {
//         'en': 'Naga Prathishta',
//         'kn': 'ನಾಗ ಪ್ರತಿಷ್ಠಾ',
//       },
//       icon:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893679/naga_prathista_x3fczb.png',
//       purpose: {
//         'en': '''
// <p>To remove Sarpa Dosha (afflictions related to serpents) from the horoscope.</p>
// <p>To bring peace, prosperity, and family well-being.</p>
// <p>To seek blessings of serpent deities for health and harmony.</p>
// ''',
//         'kn': '''
// <p>ಜಾತಕ (ಹೋರೋಸ್ಕೋಪ್) ಯಿಂದ ಸರ್ಪ ದೋಷ (ಸರ್ಪಗಳಿಗೆ ಸಂಬಂಧಿಸಿದ ಸಂಕಷ್ಟಗಳು) ತೆಗೆದುಹಾಕಲು.</p>
// <p>ಶಾಂತಿ, ಸಂಪತ್ತು ಮತ್ತು ಕುಟುಂಬದ ಕ್ಷೇಮವನ್ನು ತರಲು.</p>
// <p>ಆರೋಗ್ಯ ಮತ್ತು ಸೌಹಾರ್ಧಕ್ಕಾಗಿ ಸರ್ಪ ದೇವತೆಗಳ ಆಶೀರ್ವಾದವನ್ನು ಪಡೆಯಲು.</p>
// '''
//       },
//       images: [
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759854227/naga_pratista2_j24wd9.png',
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759847682/naga_pratista1_zbtwtp.png',
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759855767/naga_pratista3_dzumsz.png',
//       ],
//       bookNowButton: true,
//       weblink: '',
//       rituals: {
//         'en': '''
// <p>The pooja begins with <b>Sankalpa</b> – devotees/family declare their name, Gotra, and purpose of performing the pooja.</p>

// <p><b>Pratishthapane</b> (installation) is performed for the Naga Vigraha.</p>

// <p>The priests also perform <b>Abhishekam</b> (holy bathing) of the Naga idol with sacred substances.</p>

// <p>Special mantras and offerings are conducted throughout the ceremony.</p>

// <p>The ritual starts at <b>11:00 AM</b> and continues for about 1 hour.</p>
// ''',
//         'kn': '''
// <p>ಪೂಜೆ <b>ಸಂಕಲ್ಪ</b>ದಿಂದ ಪ್ರಾರಂಭವಾಗುತ್ತದೆ – ಭಕ್ತರು/ಕುಟುಂಬ their ಹೆಸರು, ಗೋತ್ರ ಮತ್ತು ಪೂಜೆ ಸಲ್ಲಿಸುವ ಉದ್ದೇಶವನ್ನು ಘೋಷಿಸುತ್ತಾರೆ.</p>

// <p><b>ಪ್ರತಿಷ್ಠಾಪನೆ</b> (ಸ್ಥಾಪನೆ) ನಾಗ ವಿಗ್ರಹಕ್ಕೆ ನಡೆಯುತ್ತದೆ.</p>

// <p>ಪೂಜಾರಿಗಳು ನಾಗ ಪ್ರತಿಮೆ <b>ಅಭಿಷೇಕ</b> (ಪವಿತ್ರ ಸ್ನಾನ) ಅನ್ನು ಪವಿತ್ರ ವಸ್ತುಗಳೊಂದಿಗೆ ನೆರವೇರಿಸುತ್ತಾರೆ.</p>

// <p>ಸಮಾರಂಭದ ಎಲ್ಲಾ ಸಮಯದಲ್ಲಿ ವಿಶೇಷ ಮಂತ್ರಗಳು ಮತ್ತು ಅರ್ಪಣೆಗಳು ನಡೆಯುತ್ತವೆ.</p>

// <p>ಈ ವಿಧಿ <b>ಬೆಳಗ್ಗೆ 11:00 AM</b> ಗೆ ಪ್ರಾರಂಭವಾಗುತ್ತದೆ ಮತ್ತು ಸುಮಾರು 1 ಗಂಟೆಯ ಕಾಲ ಮುಂದುವರಿಯುತ್ತದೆ.</p>
// '''
//       },
//       howToBook: {
//         'en': '''
// <p><strong>No online booking</strong> is available for this pooja.</p>
// <p>Devotees must <strong>register directly at the temple counter</strong> on arrival.</p>
// ''',
//         'kn': '''
// <p><strong>ಈ ಪೂಜೆಗೆ ಯಾವುದೇ ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್</strong> ಲಭ್ಯವಿಲ್ಲ.</p>
// <p>ಭಕ್ತರು ಬಂದಾಗ <strong>ನೇರವಾಗಿ ದೇವಸ್ಥಾನದ ಕೌಂಟರ್‌ನಲ್ಲಿ ನೋಂದಣಿ ಮಾಡಿಕೊಳ್ಳಬೇಕು</strong>.</p>
// '''
//       },
//       fee: {
//         'en': '',
//         'kn': '',
//       },
//       videos: [
//         ServiceVideo(
//             id: 'Kukke Subramanya',
//             name: 'Kukke Subramanya',
//             details: 'Kukke Subramanya ',
//             link: 'https://youtu.be/YmXgWdy74t8'),
//       ],
//       isCalendar: true,
//       availableDateIds: [],
//       unavailableDateIds: [
//         'yekadashi',
//       ],
//       calendarMaxDate: "31-03-2026",
//       tips: {
//         'en': '''
// <p>The pooja is not performed on Ekadashi days.</p>
// ''',
//         'kn': '''
// <p>ಈ ಪೂಜೆಯನ್ನು ಏಕಾದಶಿ ದಿನಗಳಲ್ಲಿ ನಡೆಸುವುದಿಲ್ಲ.</p>
// '''
//       },
//     ),
//     Services(
//       details: {
//         'en': '',
//         'kn': '',
//       },
//       isCalendar: true,
//       id: 'RathosthavaSeva',
//       name: {
//         'en': 'Rathosthava Seva',
//         'kn': 'ರಥೋತ್ಸವ ಸೇವೆ',
//       },
//       icon:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893680/rathosthava_seve_wkp1cb.png',
//       purpose: {
//         'en':
//             'Is an elaborate and grand pooje dedicated to the Nagas or serpent deities. It is performed to gain blessings from the Nagas and to seek protection from snake-related troubles.',
//         'kn':
//             'ನಾಗರು ಅಥವಾ ಹಾವು ದೇವತೆಗಳಿಗೆ ಅರ್ಪಿಸಲಾದ ವಿಶಾಲ ಮತ್ತು ಭವ್ಯ ಪೂಜೆ. ನಾಗರಿಂದ ಆಶೀರ್ವಾದ ಪಡೆಯಲು ಮತ್ತು ಹಾವು ಸಂಬಂಧಿತ ಸಮಸ್ಯೆಗಳಿಂದ ರಕ್ಷಣೆ ಪಡೆಯಲು ಇದನ್ನು ನಡೆಸಲಾಗುತ್ತದೆ.'
//       },
//       images: [
//         'https://res.cloudinary.com/dftflve8u/image/upload/v1765713223/Rath3_psryez.jpg',
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915920/ratostava3_fujkzx.jpg',
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915919/ratostava2_zpywxl.jpg',
//       ],
//       bookNowButton: true,
//       weblink: '',
//       videos: [
//         ServiceVideo(id: '', name: '', details: '', link: ''),
//       ],
//       availableDateIds: [],
//       unavailableDateIds: [],
//       calendarMaxDate: "31-03-2026",
//       rathotsavaSevaList: [
//         RathotsavaSevaList(
//           name: {'en': 'Brahmha Rathotsava', 'kn': 'ಬ್ರಹ್ಮ ರಥೋತ್ಸವ'},
//           description: {
//             'en': '''
// <p>The grand chariot procession featuring <strong>Lord Subrahmanya</strong>.</p>

// <p><strong>When:</strong> Held once every year during <em>Champa Shashti Mahotsava</em>.</p>

// <p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

// <p><strong>Note:</strong> This is the primary and most prominent Rathotsava held during the festival.</p>
//   ''',
//             'kn': '''
// <p><strong>ಲಾರ್ಡ್ ಸುಬ್ರಹ್ಮಣ್ಯ</strong>ರನ್ನು ಸೇರಿಸಿಕೊಂಡ ಭव्य ರಥೋತ್ಸವ ಪ್ರದರ್ಶನ.</p>

// <p><strong>ಯಾವಾಗ:</strong> ಚಂಪಾ ಷಷ್ಟಿ ಮಹೋತ್ಸವದ ವೇಳೆ ವರ್ಷಕ್ಕೆ ಒಂದು ಬಾರಿ ನಡೆಯುತ್ತದೆ.</p>

// <p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

// <p><strong>ಸೂಚನೆ:</strong> ಈ ರಥೋತ್ಸವವು ಉತ್ಸವದ ಪ್ರಮುಖ ಮತ್ತು ಅತ್ಯಂತ ಪ್ರಸಿದ್ಧ ರಥೋತ್ಸವವಾಗಿದೆ.</p>
//   '''
//           },
//           price: '₹25,000',
//         ),
//         RathotsavaSevaList(
//           name: {'en': 'Chikka Rathotsava', 'kn': 'ಚಿಕ್ಕ ರಥೋತ್ಸವ'},
//           description: {
//             'en': '''
// <p>A procession using a smaller chariot, offering a more intimate experience.</p>

// <p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

// <p><strong>Note:</strong> Ideal for those seeking a less crowded participation.</p>
//   ''',
//             'kn': '''
// <p>ಚಿಕ್ಕ ರಥವನ್ನು ಬಳಸಿ ನಡೆದ ರಥೋತ್ಸವ, ಹೆಚ್ಚು ಹತ್ತಿರದ ಅನುಭವವನ್ನು ನೀಡುತ್ತದೆ.</p>

// <p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

// <p><strong>ಸೂಚನೆ:</strong> ಕಡಿಮೆ ಜನಸಂಖ್ಯೆಯ ಭಾಗವಹಿಸುವಿಕೆಯನ್ನು ಇಚ್ಛಿಸುವವರಿಗೆ ಅತ್ಯುತ್ತಮ.</p>
//   '''
//           },
//           price: '₹8,000',
//         ),
//         RathotsavaSevaList(
//           name: {'en': 'Chandramandala Rathothsava', 'kn': 'ಚಂದ್ರಮಂಡಲ ರಥೋತ್ಸವ'},
//           description: {
//             'en': '''
// <p>The deity is taken in a circular procession around the temple streets.</p>

// <p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

// <p><strong>Note:</strong> Devotees can witness the deity’s journey through the town.</p>
//   ''',
//             'kn': '''
// <p>ದೇವತೆ ದೇವಸ್ಥಾನದ ಬೀದಿಗಳ ಸುತ್ತ ಸುತ್ತುವ ರಥಯಾತ್ರೆಯಲ್ಲಿ ನಡೆಸಲ್ಪಡುತ್ತದೆ.</p>

// <p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

// <p><strong>ಸೂಚನೆ:</strong> ಭಕ್ತರು ದೇವತೆಯ ಪಟ್ಟಣದ ಮೂಲಕ ನಡೆದ ಪ್ರಯಾಣವನ್ನು ನೋಡಬಹುದು.</p>
//   '''
//           },
//           price: '₹6,000',
//         ),
//         RathotsavaSevaList(
//           name: {'en': 'Hoovina Rathothsava', 'kn': 'ಹೂವಿನ ರಥೋತ್ಸವ'},
//           description: {
//             'en': '''
// <p>A procession featuring a chariot adorned with flowers, symbolizing beauty and devotion.</p>

// <p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

// <p><strong>Note:</strong> Visually captivating event showcasing the temple's floral offerings.</p>
//   ''',
//             'kn': '''
// <p>ಮಾಲೆಗಳಿಂದ ಅಲಂಕರಿಸಲಾದ ರಥವನ್ನು ಒಳಗೊಂಡ ಯಾತ್ರೆ, ಸುಂದರತೆ ಮತ್ತು ಭಕ್ತಿಯ ಸಂಕೇತವಾಗಿದೆ.</p>

// <p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

// <p><strong>ಸೂಚನೆ:</strong> ದೇವಾಲಯದ ಹೂವಿನ ಅಲಂಕಾರಗಳನ್ನು ಪ್ರದರ್ಶಿಸುವ ದೃಶ್ಯಾವಳಿ ಆಕರ್ಷಕ ಘಟನೆ.</p>
//   '''
//           },
//           price: '₹5,000',
//         ),
//         RathotsavaSevaList(
//           name: {
//             'en': 'Sheshavahana Bhandi Utsava in the Angana',
//             'kn': 'ಅಂಗಣದಲ್ಲಿ ಶೇಷವಾಹನ ಭಂಡಿ ಉತ್ಸವ'
//           },
//           description: {
//             'en': '''
// <p>The deity is placed on the Sheshavahana (serpent vehicle) within the temple courtyard.</p>

// <p><strong>Booking:</strong> Online booking is currently not available; devotees must participate on-site.</p>

// <p><strong>Note:</strong> Symbolizes the deity's association with serpents.</p>
//   ''',
//             'kn': '''
// <p>ದೇವತೆ ದೇವಾಲಯದ ಆವರಣದಲ್ಲಿ ಶೇಷವಾಹನ (ನಾಗ ವಾಹನ) ಮೇಲೆ置ಿಸಲಾಗಿದೆ.</p>

// <p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಆನ್‌ಲೈನ್ ಬುಕ್ಕಿಂಗ್ ಪ್ರಸ್ತುತ ಲಭ್ಯವಿಲ್ಲ; ಭಕ್ತರು ಸ್ಥಳೀಯವಾಗಿ ಪಾಲ್ಗೊಳ್ಳಬೇಕು.</p>

// <p><strong>ಸೂಚನೆ:</strong> ದೇವತೆಯ ನಾಗರ ಸಂಬಂಧವನ್ನು ಪ್ರತಿನಿಧಿಸುತ್ತದೆ.</p>
//   '''
//           },
//           price: '₹3,000',
//         ),
//       ],
//       note: {
//         'en': '''
//          <h2>Important Notes</h2>

// <p><strong>Booking:</strong> Advance registration is typically required for these sevas. Contact the temple authorities for details.</p>

// <p><strong>Availability:</strong> Primarily offered during the annual Rathotsava festival (usually March–April). Dates may vary; check temple announcements.</p>

// <p><strong>Participation:</strong> Devotees are expected to follow the temple’s dress code and conduct guidelines.</p>
//          ''',
//         'kn': '''
//          <h2>ಮುಖ್ಯ ಟಿಪ್ಪಣಿಗಳು</h2>

// <p><strong>ಬುಕ್ಕಿಂಗ್:</strong> ಈ ಸೇವೆಗಳಿಗಾಗಿ ಸಾಮಾನ್ಯವಾಗಿ ಮುಂಚಿತ ನೋಂದಣಿ ಅಗತ್ಯವಿದೆ. ವಿವರಗಳಿಗೆ ದೇವಸ್ಥಾನ ಪ್ರಾಧಿಕಾರಿಗಳ ಸಂಪರ್ಕಕ್ಕೆ ಹೋಗಿ.</p>

// <p><strong>ಲಭ್ಯತೆ:</strong> ಮುಖ್ಯವಾಗಿ ವಾರ್ಷಿಕ ರಥೋತ್ಸವದ ಸಮಯದಲ್ಲಿ (ಸಾಮಾನ್ಯವಾಗಿ ಮಾರ್ಚ್–ಎಪ್ರಿಲ್) ನೀಡಲಾಗುತ್ತದೆ. ದಿನಾಂಕಗಳು ಬದಲಾಗಬಹುದು; ದೇವಸ್ಥಾನ ಪ್ರಕಟಣೆಗಳನ್ನು ಪರಿಶೀಲಿಸಿ.</p>

// <p><strong>ಪಾಲ್ಗೊಳ್ಳುವಿಕೆ:</strong> ಭಕ್ತರು ದೇವಸ್ಥಾನದ ವಸ್ತ್ರ ಧಾರಣೆ ಮತ್ತು ನಡೆರಗಿನ ಮಾರ್ಗಸೂಚಿಗಳನ್ನು ಅನುಸರಿಸಲು ನಿರೀಕ್ಷಿಸಲಾಗುತ್ತದೆ.</p>
//          '''
//       },
//       contactDetails: {
//         'en': '''
//          <h2>Temple Contact</h2>

// <p style="margin:8px 0;">
//     📞 <a href="tel:+918257281224" style="color:#e25a20; text-decoration:none;">
//     +91 8257 281224
//     </a>
//   </p>

//   <p style="margin:4px 0;">
//     ✉️ <a href="mailto:eokukkesubrahmanya@gmail.com" style="color:#e25a20; text-decoration:none;">
//     eokukkesubrahmanya@gmail.com
//     </a>
//   </p>

//          ''',
//         'kn': '''
//          <h2>ದೇವಸ್ಥಾನ ಸಂಪರ್ಕ</h2>

// <p style="margin:8px 0;">
//     📞 <a href="tel:+918257281224" style="color:#e25a20; text-decoration:none;">
//     +91 8257 281224
//     </a>
//   </p>

//   <p style="margin:4px 0;">
//     ✉️ <a href="mailto:eokukkesubrahmanya@gmail.com" style="color:#e25a20; text-decoration:none;">
//     eokukkesubrahmanya@gmail.com
//     </a>
//   </p>

//          '''
//       },
//     ),
//     // Services(
//     //   isCalendar: false,
//     //   id: 'TempleHistory',
//     //   name: 'Temple History',
//     //   purpose: '',
//     //   details:
//     //       '🕉 Kukke Subrahmanya Temple – History \n Location & Significance \n Situated on the banks of the Kumaradhara River at the foothills of Kumara Parvatha in the Western Ghats. One among the seven holy places (Sapta Kshetras) created by Parashurama. \n Mythological Origin \n Lord Kumaraswamy (Subrahmanya) was born to destroy demons. \n He defeated Tharakasura and came to Kumara Parvatha. \n On the banks of the Kumaradhara, Indra offered his daughter Devasena in marriage to Lord Kumaraswamy on Margashira Shuddha Shashti. \n Around the same time, Vasuki, king of serpents, was meditating there. The Lord blessed him and promised to stay eternally at Kukke with Devasena, as the protector of serpents. \n Historical Mentions \n References are found in Skanda Purana and Shankaracharya’s Shankar Vijaya (9th–10th century), where he praises the Lord as “Bhaje Kukkelingam”. \n An inscription of the Bunts (9th century) mentions Kukke. \n The temple is believed to have a history of over 5000 years. \n Beliefs & Significance \n The Lord resides in serpent form in the sanctum. \n Devotees believe worship here grants: \n Progeny (Santana prapti) \n Marital blessings (Mangala bhagya) \n Relief from skin diseases \n Removal of serpent curses (Naga Dosha). \n Temple Rituals & Special Features \n Main prasadam is holy soil (hutta mannu) believed to have divine powers. \n Special poojas: Sarpa Samskara, Ashlesha Bali, Naga Pratishte. \n Sacred rivers Kumaradhara and Darpana Teertha surround the temple. \n Taking a holy dip here is believed to cure skin ailments. \n In 2005, the sanctum (garbhagudi) was renovated. \n During Champashashti festival, soil prasadam is distributed with Vedic rituals. \n Traditional Offerings \n Abhisheka with coconut water and milk. \n Applying turmeric, sandalwood paste to the deity. \n Offerings of banana, jaggery, and flowers continue as tradition.',
//     //   images:
//     //       ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefX9fCIuEQ2LbMkp1Wmy8DCON0olwUwA3pQ&s'],
//     //   bookNowButton: true,
//     //   weblink: '',
//     //   videos: [
//     //     ServiceVideo(id: '', name: '', details: '', link: ''),
//     //   ],
//     // ),
//     Services(
//       details: {
//         'en': '',
//         'kn': '',
//       },
//       isCalendar: false,
//       id: 'OtherServices',
//       name: {
//         'en': 'Other Sevas',
//         'kn': 'ಇತರೆ ಸೇವೆಗಳು',
//       },
//       icon:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893679/other_service_qpkmwu.png',
//       images: [
//         'https://res.cloudinary.com/dftflve8u/image/upload/v1765608787/OtherServices_zo6k1l.png',
//         'https://res.cloudinary.com/dftflve8u/image/upload/v1765697744/God1_c721ai.png',
//       ],
//       bookNowButton: true,
//       weblink: '',
//       otherSevas: {
//         'en': '''
// <center>
//   <h1>Temple Seva Details</h1>
//   <h4><em>Please choose the seva according to your devotion</em></h4>
// </center>

// <hr>

// <fieldset>
//   <legend><h3>Daily Sevas</h3></legend>

//   <table width="100%" cellpadding="12" cellspacing="0">
//     <tr>
//       <th align="left">Seva</th>
//       <th align="right">Offering (₹)</th>
//     </tr>

//     <tr>
//       <td>
//         <strong>Mahapooje</strong><br>
//         <small>Whole Day Seva</small>
//       </td>
//       <td align="right"><strong>400</strong></td>
//     </tr>

//     <tr>
//       <td>
//         <strong>Mahapooje</strong><br>
//         <small>Afternoon Seva</small>
//       </td>
//       <td align="right"><strong>250</strong></td>
//     </tr>

//     <tr><td colspan="2"><hr></td></tr>

//     <tr>
//       <td><strong>Pavamana Panchamrita Abhisheka</strong></td>
//       <td align="right">100</td>
//     </tr>

//     <tr>
//       <td><strong>Kalasha Pooja Panchamrita Abhisheka</strong></td>
//       <td align="right">100</td>
//     </tr>

//     <tr>
//       <td>Panchamrita Abhisheka</td>
//       <td align="right">75</td>
//     </tr>

//     <tr>
//       <td>Rudrabhisheka</td>
//       <td align="right">75</td>
//     </tr>

//     <tr>
//       <td>Ksheerabhisheka</td>
//       <td align="right">50</td>
//     </tr>

//     <tr><td colspan="2"><hr></td></tr>

//     <tr>
//       <td>Sheshaseva</td>
//       <td align="right">100</td>
//     </tr>

//     <tr>
//       <td>Kartika Pooje</td>
//       <td align="right">50</td>
//     </tr>

//     <tr>
//       <td>Pancha Kajjaya</td>
//       <td align="right">20</td>
//     </tr>

//     <tr>
//       <td>Halu Payasa</td>
//       <td align="right">100</td>
//     </tr>

//     <tr>
//       <td>Chitranna Samarpane</td>
//       <td align="right">100</td>
//     </tr>
//   </table>
// </fieldset>

// <br>

// <fieldset>
//   <legend><h3>Harake Sevas</h3></legend>

//   <table width="100%" cellpadding="12" cellspacing="0">
//     <tr>
//       <th align="left">Seva</th>
//       <th align="right">Offering (₹)</th>
//     </tr>

//     <tr>
//       <td>Thulabhara</td>
//       <td align="right">75</td>
//     </tr>

//     <tr>
//       <td>Chavala</td>
//       <td align="right">25</td>
//     </tr>

//     <tr>
//       <td>
//         <strong>Kivi Chuchhuvudu</strong><br>
//         <small>Ear Piercing Ceremony</small>
//       </td>
//       <td align="right">20</td>
//     </tr>

//     <tr>
//       <td>Anna Prashana</td>
//       <td align="right">25</td>
//     </tr>

//     <tr>
//       <td><strong>Namkarana</strong></td>
//       <td align="right"><strong>150</strong></td>
//     </tr>
//   </table>
// </fieldset>

// <hr>

// <center>
//   <p><strong>Note:</strong> Seva offerings are fixed as per temple guidelines.</p>
//   <p><em>Devotees are kindly requested to cooperate with temple staff.</em></p>
// </center>

//   '''
//       },
//       calendarMaxDate: "31-03-2026",
//     ),
//     Services(
//       icon:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1761893679/kp_treck_yywfug.png',
//       details: {
//         'en': '''
// <p>
// Rising to an elevation of <b>1,712 meters</b>, Kumara Parvatha—also known as Pushpagiri—is the 
// <b>second-highest peak in Karnataka</b> and one of the most popular trekking destinations in the Western Ghats.
// </p>

// <p>
// The trek offers a rewarding mix of dense forests, steep climbs, and open grasslands, making it a memorable experience for adventure lovers and nature enthusiasts.
// </p>

// <h3>Trek Routes & Distance Details</h3>

// <div style="display:flex; flex-direction:column; gap:14px;">

//   <!-- Route 1 -->
//   <div style="padding:14px; border:1px solid #e0e0e0; border-radius:10px; background:#fafafa;">
//     <strong>Route 1: Subrahmanya – Sheshaparvatha – Subrahmanya</strong>

//     <ul style="margin-top:8px; padding-left:18px;">
//       <li><b>Start Point:</b> Near Kukke Subrahmanya Temple</li>
//       <li><b>Distance:</b> 14 km (one way) · <b>28 km</b> (round trip)</li>
//       <li><b>Difficulty:</b> Long & Challenging</li>
//       <li><b>Best For:</b> Experienced trekkers</li>
//       <li>
//         <b>Booking Option:</b>  
//         Select <b>District – Kodagu</b> →  
//         <b>Subrahmanya – Sheshaparvatha – Subrahmanya</b>
//       </li>
//     </ul>
//   </div>

//   <!-- Route 2 -->
//   <div style="padding:14px; border:1px solid #e0e0e0; border-radius:10px; background:#f3f8ff;">
//     <strong>Route 2: Beedahalli – Kumara Parvatha – Beedahalli</strong>

//     <ul style="margin-top:8px; padding-left:18px;">
//       <li><b>Start Point:</b> Beedahalli</li>
//       <li><b>Distance:</b> 7 km (one way) · <b>14 km</b> (round trip)</li>
//       <li><b>Difficulty:</b> Easier compared to Subrahmanya route</li>
//       <li><b>Best For:</b> Beginners & moderate trekkers</li>
//       <li>
//         <b>Booking Option:</b>  
//         Select <b>Beedahalli – Kumara Parvatha – Beedahalli</b>
//       </li>
//     </ul>
//   </div>

// </div>

// <h3>Trek Rules & Guidelines</h3>
// <ul>
//   <li>The trek must be <b>completed within a single day</b>.</li>
//   <li><b>Camping is not permitted</b> on either trekking route.</li>
//   <li>All trekkers are advised to start early and follow forest department rules.</li>
// </ul>

// <h3>Why Trek Kumara Parvatha?</h3>
// <ul>
//   <li>One of the highest and most scenic treks in Karnataka</li>
//   <li>Choice of routes for both experienced and moderate-level trekkers</li>
//   <li>Panoramic views from the summit</li>
//   <li>A perfect blend of adventure and nature</li>
// </ul>

// <h3>Quick Info</h3>
// <ul>
//   <li><b>Difficulty:</b> Moderate to Difficult</li>
//   <li><b>Duration:</b> 1 Day</li>
//   <li><b>Best Season:</b> October to February</li>
//   <li><b>Permit & Fees:</b> Entry pass required (₹350 per person) – valid ID proof mandatory</li>
//   <li><b>Booking:</b> Trek permits are available only through the Karnataka Tourism official website</li>
// </ul>

// <p style="color:red; font-size:14px;">
//   <strong>Important:</strong> Avoid trekking during monsoon months, as trails become slippery and leech-prone.
// </p>

// ''',
//         'kn': '''
// <p>
// <b>1,712 ಮೀಟರ್</b> ಎತ್ತರಕ್ಕೆ ಏರಿರುವ ಕುಮಾರ ಪರ್ವತ — ಪುಷ್ಪಗಿರಿ ಎಂದೂ ಕರೆಯಲ್ಪಡುವುದು — 
// <b>ಕರ್ನಾಟಕದ ಎರಡನೇ ಅತಿ ಎತ್ತರದ ಶಿಖರ</b>ವಾಗಿದ್ದು, ಪಶ್ಚಿಮ ಘಟ್ಟಗಳಲ್ಲಿನ ಅತ್ಯಂತ ಜನಪ್ರಿಯ ಟ್ರೆಕ್ಕಿಂಗ್ ಸ್ಥಳಗಳಲ್ಲಿ ಒಂದಾಗಿದೆ.
// </p>

// <p>
// ಈ ಟ್ರೆಕ್ ದಟ್ಟವಾದ ಕಾಡುಗಳು, ತೀವ್ರ ಏರುಬಾಗಿಲುಗಳು ಮತ್ತು ವಿಶಾಲ ಹುಲ್ಲುಮೈದಾನಗಳ ಸಂಯೋಜನೆಯನ್ನು ನೀಡುತ್ತಿದ್ದು, 
// ಸಾಹಸ ಪ್ರಿಯರು ಮತ್ತು ಪ್ರಕೃತಿ ಪ್ರೇಮಿಗಳಿಗೆ ಮರೆಯಲಾಗದ ಅನುಭವವಾಗಿರುತ್ತದೆ.
// </p>

// <h3>ಟ್ರೆಕ್ ಮಾರ್ಗಗಳು ಮತ್ತು ದೂರದ ವಿವರಗಳು</h3>

// <div style="display:flex; flex-direction:column; gap:14px;">

//   <!-- Route 1 -->
//   <div style="padding:14px; border:1px solid #e0e0e0; border-radius:10px; background:#fafafa;">
//     <strong>ಮಾರ್ಗ 1: ಸುಬ್ರಹ್ಮಣ್ಯ – ಶೇಷಪರ್ವತ – ಸುಬ್ರಹ್ಮಣ್ಯ</strong>

//     <ul style="margin-top:8px; padding-left:18px;">
//       <li><b>ಪ್ರಾರಂಭ ಸ್ಥಳ:</b> ಕುಕ್ಕೆ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನದ ಬಳಿ</li>
//       <li><b>ದೂರ:</b> 14 ಕಿಮೀ (ಒಂದು ದಾರಿ) · <b>28 ಕಿಮೀ</b> (ರೌಂಡ್ ಟ್ರಿಪ್)</li>
//       <li><b>ಕಷ್ಟದ ಮಟ್ಟ:</b> ದೀರ್ಘ ಮತ್ತು ಸವಾಲಿನದು</li>
//       <li><b>ಯಾರಿಗೆ ಸೂಕ್ತ:</b> ಅನುಭವಿ ಟ್ರೆಕ್ಕರ್‌ಗಳಿಗೆ</li>
//       <li>
//         <b>ಬುಕಿಂಗ್ ಆಯ್ಕೆ:</b>  
//         <b>ಜಿಲ್ಲೆ – ಕೊಡಗು</b> →  
//         <b>ಸುಬ್ರಹ್ಮಣ್ಯ – ಶೇಷಪರ್ವತ – ಸುಬ್ರಹ್ಮಣ್ಯ</b> ಆಯ್ಕೆಮಾಡಿ
//       </li>
//     </ul>
//   </div>

//   <!-- Route 2 -->
//   <div style="padding:14px; border:1px solid #e0e0e0; border-radius:10px; background:#f3f8ff;">
//     <strong>ಮಾರ್ಗ 2: ಬೀಡಹಳ್ಳಿ – ಕುಮಾರ ಪರ್ವತ – ಬೀಡಹಳ್ಳಿ</strong>

//     <ul style="margin-top:8px; padding-left:18px;">
//       <li><b>ಪ್ರಾರಂಭ ಸ್ಥಳ:</b> ಬೀಡಹಳ್ಳಿ</li>
//       <li><b>ದೂರ:</b> 7 ಕಿಮೀ (ಒಂದು ದಾರಿ) · <b>14 ಕಿಮೀ</b> (ರೌಂಡ್ ಟ್ರಿಪ್)</li>
//       <li><b>ಕಷ್ಟದ ಮಟ್ಟ:</b> ಸುಬ್ರಹ್ಮಣ್ಯ ಮಾರ್ಗಕ್ಕಿಂತ ಸುಲಭ</li>
//       <li><b>ಯಾರಿಗೆ ಸೂಕ್ತ:</b> ಆರಂಭಿಕರು ಮತ್ತು ಮಧ್ಯಮ ಮಟ್ಟದ ಟ್ರೆಕ್ಕರ್‌ಗಳಿಗೆ</li>
//       <li>
//         <b>ಬುಕಿಂಗ್ ಆಯ್ಕೆ:</b>  
//         <b>ಬೀಡಹಳ್ಳಿ – ಕುಮಾರ ಪರ್ವತ – ಬೀಡಹಳ್ಳಿ</b> ಆಯ್ಕೆಮಾಡಿ
//       </li>
//     </ul>
//   </div>

// </div>

// <h3>ಟ್ರೆಕ್ ನಿಯಮಗಳು ಮತ್ತು ಮಾರ್ಗಸೂಚಿಗಳು</h3>
// <ul>
//   <li>ಟ್ರೆಕ್ ಅನ್ನು <b>ಒಂದು ದಿನದಲ್ಲೇ ಪೂರ್ಣಗೊಳಿಸಬೇಕು</b>.</li>
//   <li>ಯಾವುದೇ ಮಾರ್ಗದಲ್ಲಿಯೂ <b>ಶಿಬಿರ ಹೂಡುವುದಕ್ಕೆ ಅನುಮತಿ ಇಲ್ಲ</b>.</li>
//   <li>ಎಲ್ಲಾ ಟ್ರೆಕ್ಕರ್‌ಗಳು ಬೆಳಗ್ಗೆ ಬೇಗ ಆರಂಭಿಸಿ ಅರಣ್ಯ ಇಲಾಖೆಯ ನಿಯಮಗಳನ್ನು ಪಾಲಿಸಬೇಕು.</li>
// </ul>

// <h3>ಏಕೆ ಕುಮಾರ ಪರ್ವತ ಟ್ರೆಕ್?</h3>
// <ul>
//   <li>ಕರ್ನಾಟಕದ ಅತಿ ಎತ್ತರದ ಮತ್ತು ಅತ್ಯಂತ ಸುಂದರ ಟ್ರೆಕ್‌ಗಳಲ್ಲಿ ಒಂದು</li>
//   <li>ಅನುಭವಿ ಹಾಗೂ ಮಧ್ಯಮ ಮಟ್ಟದ ಟ್ರೆಕ್ಕರ್‌ಗಳಿಗೆ ವಿಭಿನ್ನ ಮಾರ್ಗಗಳ ಆಯ್ಕೆ</li>
//   <li>ಶಿಖರದಿಂದ ಕಾಣುವ ಮನಮೋಹಕ ನೋಟಗಳು</li>
//   <li>ಸಾಹಸ ಮತ್ತು ಪ್ರಕೃತಿಯ ಪರಿಪೂರ್ಣ ಸಂಯೋಜನೆ</li>
// </ul>

// <h3>ತ್ವರಿತ ಮಾಹಿತಿ</h3>
// <ul>
//   <li><b>ಕಷ್ಟದ ಮಟ್ಟ:</b> ಮಧ್ಯಮದಿಂದ ಕಠಿಣ</li>
//   <li><b>ಅವಧಿ:</b> 1 ದಿನ</li>
//   <li><b>ಉತ್ತಮ ಕಾಲ:</b> ಅಕ್ಟೋಬರ್‌ನಿಂದ ಫೆಬ್ರವರಿವರೆಗೆ</li>
//   <li><b>ಪರ್ಮಿಟ್ ಮತ್ತು ಶುಲ್ಕ:</b> ಪ್ರವೇಶ ಪಾಸ್ ಅಗತ್ಯ (ಪ್ರತಿ ವ್ಯಕ್ತಿಗೆ ₹350) – ಮಾನ್ಯ ಗುರುತಿನ ಚೀಟಿ ಕಡ್ಡಾಯ</li>
//   <li><b>ಬುಕಿಂಗ್:</b> ಟ್ರೆಕ್ ಪರವಾನಗಿಗಳು ಕರ್ನಾಟಕ ಪ್ರವಾಸೋದ್ಯಮದ ಅಧಿಕೃತ ವೆಬ್‌ಸೈಟ್ ಮೂಲಕ ಮಾತ್ರ ಲಭ್ಯ</li>
// </ul>

// <p style="color:red; font-size:14px;">
//   <strong>ಮುಖ್ಯ ಸೂಚನೆ:</strong> ಮಳೆಗಾಲದ ಸಮಯದಲ್ಲಿ ಟ್ರೆಕ್ಕಿಂಗ್ ತಪ್ಪಿಸಿ, ಏಕೆಂದರೆ ದಾರಿಗಳು ಜಾರಿ ಮತ್ತು ಜಲಾವೃತವಾಗಿರುತ್ತವೆ.
// </p>
// '''
//       },
//       isCalendar: false,
//       id: 'KumaraParvathaTrek',
//       name: {
//         'en': 'Kumara Parvatha Trek',
//         'kn': 'ಕುಮಾರ ಪರ್ವತ ಟ್ರೆಕ್',
//       },
//       purpose: {
//         'en': '',
//         'kn': '',
//       },
//       images: [
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949730/Kumara_Parvatha_rjsekj.jpg',
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949741/Kumara_Parvatha1_ty8yy7.jpg',
//         // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949909/Kumara_Parvatha4_ydpyeo.png',
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949811/Kumara_Parvatha2_jihuxo.jpg',
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949816/Kumara_Parvatha3_bodqcf.jpg',
//       ],
//       bookNowButton: true,
//       weblink:
//           'https://trek.kodaguecotourism.com/trailDetail/14/Subramanya%20-%20Kumaraparvatha',
//       rituals: {
//         'en': '',
//         'kn': '',
//       },
//       howToBook: {
//         'en': '',
//         'kn': '',
//       },
//       fee: {
//         'en': '',
//         'kn': '',
//       },
//       tips: {
//         'en': '',
//         'kn': '',
//       },
//       calendarMaxDate: "31-03-2026",
//     ),
//   ],
//   timings: [
//     Timings(
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
//       day: "Monday",
//       slots: [
//         TimeSlot(from: "6AM", to: "1PM"),
//         TimeSlot(from: "3PM", to: "8PM"),
//       ],
//       lunch: [
//         TimeSlot(from: "1PM", to: "3PM"),
//       ],
//     ),
//     Timings(
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
//       day: "Tuesday",
//       slots: [
//         TimeSlot(from: "6AM", to: "1PM"),
//         TimeSlot(from: "3PM", to: "8PM"),
//       ],
//       lunch: [
//         TimeSlot(from: "1PM", to: "3PM"),
//       ],
//     ),
//     Timings(
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
//       day: "Wednesday",
//       slots: [
//         TimeSlot(from: "6AM", to: "1PM"),
//         TimeSlot(from: "3PM", to: "8PM"),
//       ],
//       lunch: [
//         TimeSlot(from: "1PM", to: "3PM"),
//       ],
//     ),
//     Timings(
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
//       day: "Thursday",
//       slots: [
//         TimeSlot(from: "6AM", to: "1PM"),
//         TimeSlot(from: "3PM", to: "5.25PM"),
//       ],
//       lunch: [
//         TimeSlot(from: "1PM", to: "3PM"),
//       ],
//     ),
//     Timings(
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
//       day: "Friday",
//       slots: [
//         TimeSlot(from: "6AM", to: "1PM"),
//         TimeSlot(from: "3PM", to: "8PM"),
//       ],
//       lunch: [
//         TimeSlot(from: "1PM", to: "3PM"),
//       ],
//     ),
//     Timings(
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
//       day: "Saturday",
//       slots: [
//         TimeSlot(from: "6AM", to: "1PM"),
//         TimeSlot(from: "3PM", to: "8PM"),
//       ],
//       lunch: [
//         TimeSlot(from: "1PM", to: "3PM"),
//       ],
//     ),
//     Timings(
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
//       day: "Sunday",
//       slots: [
//         TimeSlot(from: "6AM", to: "1PM"),
//         TimeSlot(from: "3PM", to: "8PM"),
//       ],
//       lunch: [
//         TimeSlot(from: "1PM", to: "3PM"),
//       ],
//     ),
//   ],
//   videos: [
//     PoojaVideos(
//       name: {'en': 'Morning Pooja', 'kn': 'ಮಾರ್ನಿಂಗ್ ಪೂಜೆ'},
//       image:
//           'https://icctmemphis.org/wp-content/uploads/2023/01/Subramanya_Valli_Devasena-scaled-e1675130620249.jpg',
//       url: 'https://www.youtube.com/shorts/u2m8QZUXXjw',
//       //'https://youtu.be/yXxeQndQYEM',
//     ),
//     PoojaVideos(
//       name: {'en': 'Evening Pooja', 'kn': 'ಸಂಜೆ ಪೂಜೆ'},
//       image:
//           'https://i.pinimg.com/736x/35/16/1a/35161a12f032244c3c78249d726ecb3d.jpg',
//       url: 'https://youtu.be/yXxeQndQYEM',
//     ),
//     PoojaVideos(
//       name: {'en': 'Special Pooja', 'kn': 'ಪ್ರತ್ಯೇಕ ಪೂಜೆ'},
//       image:
//           'https://m.media-amazon.com/images/I/81VkuGYTB2L._UF894,1000_QL80_.jpg',
//       url: 'https://youtu.be/yXxeQndQYEM',
//     ),
//   ],
//   bhajans: [
//     Bhajans(
//       name: {
//         'en': 'Namo Namo Shri',
//         'kn': 'ನಮೋ ನಮೋ ಶ್ರೀ',
//       },
//       image:
//           'https://res.cloudinary.com/dftflve8u/image/upload/c_crop,g_north_west,h_634,w_643,x_90,y_216/Kukke_Devaru3_sfoaya.jpg',
//       url: 'https://youtu.be/8H2WFMXXgZI?si=enUE26paHHWDARqu',
//     ),
//     Bhajans(
//       name: {'en': 'Huthadinda Eddu', 'kn': 'ಹುತ್ತದಿಂದ ಎದ್ದು'},
//       image:
//           'https://res.cloudinary.com/dftflve8u/image/upload/v1765694217/Kukke_Devaru2_pcqpfq.jpg',
//       url: 'https://youtu.be/fqXsdsLd1p0?si=yeUCXSyjIQfRfi1b',
//     ),
//     Bhajans(
//       name: {'en': 'Nagana Roopadi', 'kn': 'ನಾಗನ ರೂಪದಿ'},
//       image:
//           'https://res.cloudinary.com/dftflve8u/image/upload/v1765694217/kukke_Devaru1_ft5d16.jpg',
//       url: 'https://youtu.be/38tgnkkIcRw?si=1ho_VGqqcJ7EVdN5',
//     ),
//   ],
//   nearByPlaces: [
//     NearByPlaces(
//       name: {
//         'en': 'Basaveshwara temple Kulkunda',
//         'kn': 'ಬಸವೇಶ್ವರ ದೇವಸ್ಥಾನ ಕುಲ್ಕುಂಡ'
//       },
//       images: [
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759741561/Basaveshwara_temple_Kulkunda_ade9lh.jpg',
//       ],
//       description: {
//         'en': '''
// <h3>Basaveshwara Temple, Kulkunda</h3>
// <p>
// Located just <b>4 km from Kukke Temple</b>, this <b>800-year-old shrine</b> showcases 
// ancient Hindu architecture with a <b>unique Shivalinga on Nandi’s forehead</b>.
// </p>
//   ''',
//         'kn': '''
// <h3>ಬಸವೇಶ್ವರ ದೇವಸ್ಥಾನ, ಕುಲ್ಕುಂಡ</h3>
// <p>
// ಕುಕ್ಕೆ ದೇವಸ್ಥಾನದಿಂದ ಕೇವಲ <b>4 ಕಿಮೀ</b> ದೂರದಲ್ಲಿರುವ ಈ <b>800 ವರ್ಷಗಳ ಹಳೆಯ ದೇವಾಲಯ</b> ಪ್ರಾಚೀನ ಹಿಂದೂ ವಾಸ್ತುಶಿಲ್ಪವನ್ನು ತೋರಿಸುತ್ತದೆ, <b>ನಂದಿಯ ಮುಚ್ಚಳದ ಮೇಲೆ ವಿಶಿಷ್ಟ ಶಿವಲಿಂಗ</b> ಸಹಿತ.
// </p>
//   '''
//       },
//       directionButton: true,
//       weblink: 'https://maps.app.goo.gl/mp3hEt4ssudMDUhR6',
//       url: '',
//     ),

//     NearByPlaces(
//       name: {
//         'en': 'Somanatheshwara temple',
//         'kn': 'ಸೋಮನಾಥೇಶ್ವರ ದೇವಸ್ಥಾನ',
//       },
//       images: [
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742005/Shri_Somanatheshwara_temple_hgwtja.jpg',
//       ],
//       description: {
//         'en': '''
// <h3>Shri Somanatheshwara Temple</h3>

// <p>
// Located just <b>2 km from Kukke Temple</b>, the <b>Agrahara Somanath Temple</b> is an 
// <b>800-year-old shrine</b> situated on the riverbank, reflecting the grandeur of 
// ancient Hindu architecture.
// </p>
// ''',
//         'kn': '''
// <h3>ಶ್ರೀ ಸೋಮನಾಥೇಶ್ವರ ದೇವಸ್ಥಾನ</h3>

// <p>
// ಕುಕ್ಕೆ ದೇವಸ್ಥಾನದಿಂದ ಕೇವಲ <b>2 ಕಿಮೀ ದೂರದಲ್ಲಿ</b>, <b>ಅಗ್ರಹಾರ ಸೋಮನಾಥ ದೇವಸ್ಥಾನ</b> 
// ಒಂದು <b>800 ವರ್ಷದ ಹಳೆಯ ದೇವಸ್ಥಾನ</b>, ನದಿ ತೀರದಲ್ಲಿ ಸ್ಥಿತವಾಗಿದೆ ಮತ್ತು 
// ಪ್ರಾಚೀನ ಹಿಂದೂ ವಾಸ್ತುಶಿಲ್ಪದ ಮಹತ್ವವನ್ನು ಪ್ರತಿಬಿಂಬಿಸುತ್ತದೆ.
// </p>
// '''
//       },
//       directionButton: true,
//       weblink: 'https://maps.app.goo.gl/9WnpfaDLKqBGmhEz8',
//       url: '',
//     ),
//     NearByPlaces(
//       name: {
//         'en': 'Shankapala Subrahmanya Temple',
//         'kn': 'ಶಂಕಪಾಲ ಸುಬ್ರಹ್ಮಣ್ಯ ದೇವಸ್ಥಾನ',
//       },
//       images: [
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742245/Shri_Shankapala_Subrahmanya_Swami_Temple_cnd92j.jpg',
//       ],
//       description: {
//         'en': '''
// <h3>Shri Shankapala Subrahmanya Swami Temple</h3>

// <p>
// It is located about <b>10 km from Kukke Temple</b>. A unique feature of this temple is 
// the presence of a <b>live anthill (hutta)</b> inside the sanctum.
// </p>
//   ''',
//         'kn': '''
// <h3>ಶ್ರೀ ಶಂಕಪಾಲ ಸುಬ್ರಹ್ಮಣ್ಯ ಸ್ವಾಮಿ ದೇವಸ್ಥಾನ</h3>

// <p>
// ಇದು <b>ಕುಕ್ಕೆ ದೇವಾಲಯದಿಂದ 10 ಕಿಮೀ</b> ದೂರದಲ್ಲಿದೆ. ಈ ದೇವಾಲಯದ ವಿಶೇಷತೆ ಎಂದರೆ 
// ಪ್ರಾರ್ಥನಾ ಕ್ಷೇತ್ರದೊಳಗೆ <b>ಜೀವಂತ ಹುಟ್ಟ (ಹುಟ್ಟ)</b> ಇರುವುದು.
// </p>
//   ''',
//       },
//       directionButton: true,
//       weblink: 'https://maps.app.goo.gl/ccHSTWV5kPniqSEJA',
//       url: '',
//     ),

//     NearByPlaces(
//       name: {
//         'en': 'Marakatha DurgaParameshwari Temple',
//         'kn': 'ಮರಕಥ ದುರ್ಗಾಪರಮೇಶ್ವರಿ ದೇವಸ್ಥಾನ',
//       },
//       images: [
//         'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742425/Marakatha_DurgaParameshwari_Temple_i2glza.jpg',
//       ],
//       description: {
//         'en': '''
// <h3>Marakatha Durga Parameshwari Temple</h3>

// <p>
// Located about <b>8 km from Kukke Temple</b>, it sits on the banks of the <b>Kotitheertha River</b> 
// flowing from Shesha Parvata. Surrounded by greenery, it’s believed that feeding the fish here 
// and praying to the Lord fulfills one’s wishes.
// </p>
// ''',
//         'kn': '''
// <h3>ಮರಕಥ ದುರ್ಗಾ ಪರಮೇಶ್ವರಿ ದೇವಸ್ಥಾನ</h3>

// <p>
// ಕುಕ್ಕೇ ದೇವಸ್ಥಾನದಿಂದ ಸುಮಾರು <b>8 ಕಿ.ಮೀ.</b> ದೂರದಲ್ಲಿದ್ದು, ಇದು ಶೇಷಪರ್ವತದಿಂದ ಹರಿಯುವ <b>ಕೋಟೀಥೇರ್ಥ ನದಿ</b> ತೀರದಲ್ಲಿ 
// ನಿಂತಿದೆ. ಹಸಿರು ಪರಿಸರದಿಂದ ಸುತ್ತಿಕೊಂಡಿರುವ ಈ ಸ್ಥಳದಲ್ಲಿ ಮೀನುಗಳನ್ನು ಆಹಾರ ನೀಡಿ ದೇವರಿಗೆ ಪ್ರಾರ್ಥನೆ ಮಾಡುವುದರಿಂದ 
// ಮನೋವೀಕ್ಷೆಗಳು ಪೂರಣವಾಗುತ್ತದೆ ಎಂದು ನಂಬಲಾಗುತ್ತದೆ.
// </p>
// '''
//       },
//       directionButton: true,
//       weblink: 'https://maps.app.goo.gl/vtxNxoQtPBcUyC2P6',
//       url: '',
//     ),
//     // NearByPlaces(
//     //   name: 'Shringeri Shree Sharadambe Devi Temple',
//     //   images:
//     //      [ 'https://www.holidify.com/images/cmsuploads/compressed/1873074727_e470479cfe_b_20170609180808.jpg',],
//     //   url: '',
//     //   description: '',
//     // ),
//     // NearByPlaces(
//     //   name: 'Subrahmanya Mutt',
//     //   images:[ 'https://www.holidify.com/images/cmsuploads/compressed/4623_20200619164848.JPG',]
//     //      ,
//     //   url: '',
//     //   description: '',
//     // ),
//   ],
//   wallpapers: [
//     Wallpapers(
//       shareTitle: "Subrahmanya",
//       shareDescription: "Seek Subrahmanya Blessings",
//       image:
//           // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759908404/Lord_Venkataramana_nhxtds.png',
//           'https://res.cloudinary.com/dftflve8u/image/upload/v1765608954/kukke_god4_niibpa.jpg',
//     ),
//     Wallpapers(
//       shareTitle: "Lord Venkataramana",
//       shareDescription: "Seek Balaji's Blessings",
//       image:
//           // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759908404/Lord_Venkataramana_nhxtds.png',
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759913291/Lord_Venkatesha_debldh.jpg',
//     ),
//     Wallpapers(
//       shareTitle: "Lord Ganesha: Vighnaharta",
//       shareDescription:
//           "May the Remover of Obstacles, Lord Ganesha, bless your endeavors with success. Om Gan Ganapataye Namaha.",
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759918437/Lord_Ganesha1_as7240.jpg',
//     ),
//     Wallpapers(
//       shareTitle: "Jai Shri Krishna",
//       shareDescription:
//           "May the enchanting flute of Lord Krishna bring joy, love, and peace to your heart. Jai Shri Krishna!",
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759918464/Lord_Krishna1_mnr40y.jpg',
//     ),
//     Wallpapers(
//       shareTitle: "Goddess Lakshmi Blessings",
//       shareDescription:
//           "May the divine grace of Goddess Lakshmi fill your life with abundance, prosperity, and good fortune.",
//       image:
//           'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759913540/Goddess_Lakshmi_e8os62.jpg',
//     ),
//   ],
//   calender: {
//     "shuddaShasti": [
//       "03-04-2025",
//       "02-05-2025",
//       "01-06-2025",
//       "01-07-2025",
//       "30-07-2025",
//       "29-08-2025",
//       "28-09-2025",
//       "27-10-2025",
//       "26-11-2025",
//       "26-12-2025",
//       "26-12-2025",
//       "24-01-2026",
//       "22-02-2026",
//     ],
//     "ashleshanakshathra": [
//       "07-04-2025",
//       "05-05-2025",
//       "01-06-2025",
//       "28-06-2025",
//       "26-07-2025",
//       "22-08-2025",
//       "18-09-2025",
//       "16-10-2025",
//       "12-11-2025",
//       "09-12-2025",
//       "06-01-2026",
//       "02-02-2026",
//       "02-03-2026"
//     ],
//     "yekadashi": [
//       "08-04-2025",
//       "24-04-2025",
//       "08-05-2025",
//       "23-05-2025",
//       "06-06-2025",
//       "07-06-2025",
//       "22-06-2025",
//       "06-07-2025",
//       "21-07-2025",
//       "05-08-2025",
//       "19-08-2025",
//       "03-09-2025",
//       "07-09-2025",
//       "14-09-2025",
//       "17-09-2025",
//       "03-10-2025",
//       "17-10-2025",
//       "02-11-2025",
//       "15-11-2025",
//       "01-12-2025",
//       "15-12-2025",
//       "14-01-2026",
//       "29-01-2026",
//       "13-02-2026",
//       "15-02-2026",
//       "27-02-2026",
//       "03-03-2026",
//       "15-03-2026",
//     ],
//   },
// );
