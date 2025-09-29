class Temple {
  final List<TempleBanner>? banner;
  final List<Services> services;
  final List<Timings> timings;
  final List<PoojaVideos>? videos;
  final List<Bhajans>? bhajans;
  final Map<String, List<String>>? calender;
  final List<NearByPlaces>? nearByPlaces;
  Temple(
      {this.banner,
      required this.services,
      required this.timings,
      this.videos,
      this.bhajans,
      this.calender,
      this.nearByPlaces});

  factory Temple.fromMap(Map<String, dynamic> map) {
    return Temple(
      banner: (map['banner'] as List?)
          ?.map((b) => TempleBanner.fromMap(b))
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
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'banner': banner?.map((b) => b.toMap()).toList(),
      'services': services.map((b) => b.toMap()).toList(),
      'timings': timings.map((b) => b.toMap()).toList(),
      'videos': videos?.map((b) => b.toMap()).toList(),
      'bhajans': bhajans?.map((b) => b.toMap()).toList(),
      'calender': calender,
      'nearByPlaces': nearByPlaces?.map((n) => n.toMap()).toList(),
    };
  }
}

class NearByPlaces {
  final String? name;
  final List<String>? images;
  final String? url;
  final String description;
  final bool bookNowButton;
  final String weblink;

  NearByPlaces({
    this.name,
    this.images,
    this.url,
    required this.description,
    required this.bookNowButton,
    required this.weblink,
  });

  factory NearByPlaces.fromMap(Map<String, dynamic> map) {
    return NearByPlaces(
        name: map['name'], images: List<String>.from(map['images'] ?? []), url: map['url'], description: map['description'],bookNowButton: map['bookNowButton']?.toString().toLowerCase() == 'true',
    
      weblink: map['weblink'] ?? '',);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'images': images, 'url': url, 'description': description, 'bookNowButton': bookNowButton, 'weblink': weblink};
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

class Services {
  final String id;
  final String name;
  final String? purpose;
  final String? details;
  final List<ServiceVideo>? videos;
  final List<String>? availableDateIds;
  final List<String>? unavailableDateIds;
  final List<String> images;
  final bool bookNowButton;
  final String weblink;
  final String? timings;
  final String? dressCode;
  final String? fee;
  final String? tips;
  final bool? isCalendar;
  final List<SevaCategory>? otherSevas;

  Services({
    required this.id,
    required this.name,
    this.purpose,
    this.details,
    this.videos,
    this.availableDateIds,
    this.unavailableDateIds,
    required this.images,
    required this.bookNowButton,
    required this.weblink,
    this.timings,
    this.dressCode,
    this.fee,
    this.tips,
    this.isCalendar,
    this.otherSevas,
  });

  factory Services.fromMap(Map<String, dynamic> map) {
    return Services(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      purpose: map['purpose'] ?? '',
      details: map['details'] ?? '',
      videos: (map['videos'] as List?)
              ?.map((v) => ServiceVideo.fromMap(v))
              .toList() ??
          [],
      availableDateIds: (map['availableDateIds'] as List?)
              ?.map((d) => d is Map<String, dynamic>
                  ? (d['id']?.toString() ?? '')
                  : d.toString())
              .where((d) => d.isNotEmpty)
              .toList() ??
          [],
      unavailableDateIds: (map['unavailableDateIds'] as List?)
              ?.map((d) => d is Map<String, dynamic>
                  ? (d['id']?.toString() ?? '')
                  : d.toString())
              .where((d) => d.isNotEmpty)
              .toList() ??
          [],
      bookNowButton: map['bookNowButton']?.toString().toLowerCase() == 'true',
      images: List<String>.from(map['images'] ?? []),
      weblink: map['weblink'] ?? '',
      timings: map['timings'],
      dressCode: map['dressCode'],
      fee: map['fee'],
      tips: map['tips'],
      isCalendar: map['isCalendar'],
      otherSevas: (map['otherSevas'] as List?)
          ?.map((c) => SevaCategory.fromMap(c))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'purpose': purpose,
      'details': details,
      'videos': videos?.map((videos) => videos.toMap()).toList(),
      'availableDateIds': availableDateIds,
      'unavailableDateIds': unavailableDateIds,
      'bookNowButton': bookNowButton,
      'images': images,
      'weblink': weblink,
      'timings': timings,
      'dressCode': dressCode,
      'fee': fee,
      'tips': tips,
      'isCalendar': isCalendar,
      'otherSevas': otherSevas?.map((c) => c.toMap()).toList(),
    };
  }
}

class SevaCategory {
  final String categoryName; // e.g. "Daily Sevas", "Harake Sevas"
  final List<SevaItem> sevas;

  SevaCategory({
    required this.categoryName,
    required this.sevas,
  });

  factory SevaCategory.fromMap(Map<String, dynamic> map) {
    return SevaCategory(
      categoryName: map['categoryName'] ?? '',
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
  final String title;

  SevaItem({
    required this.title,
  });

  factory SevaItem.fromMap(Map<String, dynamic> map) {
    return SevaItem(
      title: map['title'] ?? '',
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

  Timings({required this.day, required this.slots, required this.lunch,  this.image});

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
  final String? name;
  final String? image;
  final String? url;

  PoojaVideos({
    this.name,
    this.image,
    this.url,
  });

  factory PoojaVideos.fromMap(Map<String, dynamic> map) {
    return PoojaVideos(name: map['name'], image: map['image'], url: map['url']);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'image': image, 'url': url};
  }
}

class Bhajans {
  final String? name;
  final String? image;
  final String? url;

  Bhajans({
    this.name,
    this.image,
    this.url,
  });

  factory Bhajans.fromMap(Map<String, dynamic> map) {
    return Bhajans(name: map['name'], image: map['image'], url: map['url']);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'image': image, 'url': url};
  }
}

final templeData = Temple(banner: [
  TempleBanner(
    bannerImage:
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
    link: '',
  ),
  // TempleBanner(
  //   bannerImage:
  //       'https://media-cdn.tripadvisor.com/media/photo-m/1280/18/19/e6/67/photo5jpg.jpg',
  //   link: '',
  // ),
  // TempleBanner(
  //   bannerImage:
  //       'https://media-cdn.tripadvisor.com/media/photo-s/0e/4b/5e/ed/adi-subramanya-temple.jpg',
  //   link: '',
  // ),
  // TempleBanner(
  //   bannerImage: 'https://pbs.twimg.com/media/ErQ-Dh5VoAMTvjR.png',
  //   link: '',
  // ),
], services: [
  Services(
    details: '',
    isCalendar: false,
    id: 'SarpaSamskara',
    name: 'Sarpa Samskara',
    purpose:
        '🐍 Relief from Sarpa/Naga Dosha – This pooja removes the negative effects that come from harming or killing snakes knowingly or unknowingly, in this life or past lives. \n\n🙏 Ancestral Peace (Pitru Dosha) – It helps to clear ancestral curses and brings peace to forefathers, which in turn brings their blessings to the family. \n\n👨‍👩‍👧‍👦 Marriage & Children Blessings – The pooja helps remove obstacles in marriage, solves issues of late marriage, and blesses couples who are struggling to have children. \n\nRituals: \nSarpa samskara is the 2 days pooja advised to visit temple one day early \n\nTake a holy bath in the Kumaradhara river before entering the temple for the pooja. \n\nWear simple, traditional clothes. \n\nDay 1 – Main Steps \n\n1. Registration & Seating – Show your ticket, complete registration, and sit in your assigned place inside the mantap. \n\n2. Sankalpa (Prayer of Intention) – The devotee or family states their name and purpose for the pooja with the help of the priest. \n\n3. Sarpa Samskara Ritual – A special Homa and other rites are done to ask forgiveness for harming snakes knowingly or unknowingly, in this or past lives. \n\nDay 2 – Final Steps \n\n1. Morning Abhisheka to Lord Subrahmanya – The main deity is bathed with milk, water, and panchamruta, followed by prayers. \n\n2. Naga Pooja / Nagapratishtha – Snake idols are worshipped with milk, flowers, turmeric, and kumkum, and placed as an offering. \n\n📝 How to Book Sarpa Samskara Pooja: \nBooking is done online only through the official Kukke Subrahmanya Temple website. \n\nCheck the available calendar shown on the site. Note that on Ekadashi days, the pooja will not be performed. \n\nClick on the “Book Now” button, select your date, and complete the details. \n\nPay the ₹4200 fee directly to the temple through the website to confirm your booking. \n\nCarry the booking receipt and a valid ID proof when you come for the pooja.',
    images:
        ['https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjK4XTybBTDUmCYedBN5wwqRoX3FIk3-541uCdy80JUE81Hgk0Rg4rjAJnRJL5wvd_iX5gGo9DTbc5UvLzgEpSM3pug4htBtyujSnN9GlOuWxUN1xsgeBq_Ege-6wHht7vBciIH5t-uZ4Ld/w1200-h630-p-k-no-nu/Kukke+Subrahmanya_Moola_Devaru.jpg'],
    bookNowButton: true,
    weblink:
        'https://itms.kar.nic.in/ticketing/service_collection.php?tid=21&scode=21&sscode=1&target_type=&fees_slno=204256&group_id=4&action=P',
    timings:
        "The Sarpa Samskara pooja at Kukke Subrahmanya Temple is a two-day ritual, with the first day's pooja typically scheduled from 8:30 AM to 12:00 PM and the second day's pooja from 6:00 AM to 8:00 AM",
    dressCode:
        "For the Sarpa Samskara pooja at the Kukke Subramanya Temple, men are generally expected to be without their shirts and vests, while women should wear a traditional outfit like a saree or chudidhar to ensure they are dressed decently.",
    fee: "Sarpa Samskara puja at Kukke Subramanya Temple is INR 4,200",
    tips:
        "Sarpa Samskara Pooja at Kukke Subramanya Temple, you should book in advance, understand it's a two-day ritual, adhere to a traditional dress code (saree/chudidar for women), avoid other rituals or temple visits on pooja days, and be aware it's performed for those with Sarpa Dosha (snake-related afflictions)",
  ),
  Services(
    details: '',
    id: 'AshsheshaBali',
    name: 'Aslesha Bali',
    purpose:
        "Kukke Subramanya Ashlesha Bali Puja is the puja to please the nagas in this most potent way. If someone has killed a snake in his previous birth, this Kukke Subramanya Ashlesha Bali Pooja resolves the ill effects of this. Devotees perform the sarpa samskara pooja in kukke Subramanya temple.\n Kukke Subramanya Ashlesha Bali Pooja will help people remove the sarpa dosha from their horoscope. This article will explain the Kukke Subramanya Ashlesha Bali Pooja procedure, and how to do kukke Subramanya Ashlesha Bali pooja booking. What are the benefits and best dates to perform ashlesha Bali pooja in kukke? \n Kukke Subramanya Ashlesha Bali Pooja & Sarpa Samskara are the two important types of pooja that are especially performed to remove the sarpa dosha performed in Kukke Subramanya temple. Ashlesha Bali pooja in kukke has been performed for the last couple of hours. Kukke Subramanya temple sarpa samskara pooja online bookings are also available through online portals. \n The priests perform the Kukke Subramanya Ashlesha Bali Puja, also known as sarpa samskara puja, in Ashlesha nakshatra because conducting this puja on other days will not yield any benefits or power. Kukke Subramanya Ashlesha Bali Pooja is very famous and one of the most popular Kaal sarpa dosh puja performed at Kukke Subramanya temple. Performing the sarpa samskara in kukke Subramanya temple that the Lord Subramanya is the protector of Kaal sarpa and Kuja dosha. Kukke Subramanya temple is popular for Ashlesha Bali Pooja and sarpa dosha puja.",
    images:
        ['https://www.nagapratishta.com/uploads/202303250759097146134_202205230308102263234_dhosam6.jpg'],
    bookNowButton: true,
    weblink:
        'https://itms.kar.nic.in/ticketing/service_collection.php?tid=21&scode=21&sscode=1&target_type=&fees_slno=202255&group_id=4&action=P',
    timings:
        "Ashlesha Bali Pooja at Kukke Subramanya Temple is typically performed twice a day, at 7:00 AM and 9:15 AM. Devotees need to report to the temple with their Purohita (priest) at these designated times to participate in the pooja.",
    dressCode:
        "For the Ashlesha Bali pooja at the Kukke Subramanya Temple, men should wear a Dhoti or Pancha and are not allowed to wear a shirt or vest. Men can use an upper cloth. Women should wear a Saree or Chudidhar with Dupatta. It is also advised that men remove their shirts and vests before entering the temple, and devotees should always wear decent and traditional Hindu attire.",
    fee:
        "The official fee for the Ashlesha Bali pooja at Kukke Subramanya Temple is not readily available through general search results, with some online sources showing a cost of around Rs. 400 per ticket, while others provide broader packages or mention that the pooja is performed on specific dates and requires prior booking",
    tips:
        "In Yekadashi days - No pooja Ashslesha Nakshathra, Shudha Shasti and Ashlesha Nakshathra Days very good / Special Day for pooja",
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
  ),
  Services(
    details: '',
    id: 'nagaprathiste',
    name: 'Naga Prathiste',
    purpose:
        "Naga Prathista is the puja done to neutralize all the issues related to fertility, child birth, marriage ..etc in one’s life. The procedure mainly involves installation of Stone Naga Idol. \n This is an Individual Puja performed at the Kukke Subramanya – Narasimha Swamy Temple Mutt, adjacent to Kukke Subramanya Temple. Each and every devotee’s puja will be performed by a dedicated Priest. \n BENEFITS OF THIS PUJA : \n It helps in getting rid of the Sarpa / Naga Dosha caused by presiding deity, Naga devada \n All Sarpa related Doshas are nullified \n It paves the way for marriage and child birth by removing the obstacles due to the Sarpa Dosha.",
    images:
        [
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915793/nagaprathiste2_itlmpl.jpg',
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915793/nagaprathiste3_y7ixob.jpg',
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915793/nagaprathiste1_x8bqdm.jpg',
        ],
    bookNowButton: true,
    weblink: '',
    timings:
        "In Kukke Subramanya Temple, Naga Pratishta Pooja is performed daily around 12 PM. You must arrive and report with your purohit (priest) earlier, as tickets are sold only on the day of the pooja and the ticket counter opens at 9 AM. The pooja is conducted inside the temple by installing a small carved stone idol.",
    dressCode:
        "For the Naga Pratishta pooja at the Kukke Subramanya Temple, men should wear traditional attire like a white pancha, dhoti, or kurta-pyjama, and women should wear Indian traditional costumes, such as sarees or salwar kameez. Devotees are required to bathe before entering the temple premises and are not allowed to wear shirts, coats, caps, vests, or footwear inside the temple.",
    fee:
        "sarpa samskara which includes naga pprathista too and cost will be 3500 and you can book in online as per the dates available.",
    videos: [
      ServiceVideo(
          id: 'Kukke Subramanya',
          name: 'Kukke Subramanya',
          details: 'Kukke Subramanya ',
          link: 'https://youtu.be/YmXgWdy74t8'),
    ],
    isCalendar: true,
    availableDateIds: [
    ],
    unavailableDateIds: [
      'yekadashi',
    ],
  ),
  Services(
    details: '',
    isCalendar: true,
    id: 'RathosthavaSeva',
    name: 'Rathosthava Seva',
    purpose:
        'Is an elaborate and grand pooje dedicated to the Nagas or serpent deities. It is performed to gain blessings from the Nagas and to seek protection from snake-related troubles.',
    images:
        [
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915920/ratostava1_uclppf.jpg',
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
  ),
  Services(
    isCalendar: false,
    id: 'TempleHistory',
    name: 'Temple History',
    purpose: '',
    details:
        '🕉 Kukke Subrahmanya Temple – History \n Location & Significance \n Situated on the banks of the Kumaradhara River at the foothills of Kumara Parvatha in the Western Ghats. One among the seven holy places (Sapta Kshetras) created by Parashurama. \n Mythological Origin \n Lord Kumaraswamy (Subrahmanya) was born to destroy demons. \n He defeated Tharakasura and came to Kumara Parvatha. \n On the banks of the Kumaradhara, Indra offered his daughter Devasena in marriage to Lord Kumaraswamy on Margashira Shuddha Shashti. \n Around the same time, Vasuki, king of serpents, was meditating there. The Lord blessed him and promised to stay eternally at Kukke with Devasena, as the protector of serpents. \n Historical Mentions \n References are found in Skanda Purana and Shankaracharya’s Shankar Vijaya (9th–10th century), where he praises the Lord as “Bhaje Kukkelingam”. \n An inscription of the Bunts (9th century) mentions Kukke. \n The temple is believed to have a history of over 5000 years. \n Beliefs & Significance \n The Lord resides in serpent form in the sanctum. \n Devotees believe worship here grants: \n Progeny (Santana prapti) \n Marital blessings (Mangala bhagya) \n Relief from skin diseases \n Removal of serpent curses (Naga Dosha). \n Temple Rituals & Special Features \n Main prasadam is holy soil (hutta mannu) believed to have divine powers. \n Special poojas: Sarpa Samskara, Ashlesha Bali, Naga Pratishte. \n Sacred rivers Kumaradhara and Darpana Teertha surround the temple. \n Taking a holy dip here is believed to cure skin ailments. \n In 2005, the sanctum (garbhagudi) was renovated. \n During Champashashti festival, soil prasadam is distributed with Vedic rituals. \n Traditional Offerings \n Abhisheka with coconut water and milk. \n Applying turmeric, sandalwood paste to the deity. \n Offerings of banana, jaggery, and flowers continue as tradition.',
    images:
        ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefX9fCIuEQ2LbMkp1Wmy8DCON0olwUwA3pQ&s'],
    bookNowButton: true,
    weblink: '',
    videos: [
      ServiceVideo(id: '', name: '', details: '', link: ''),
    ],
  ),
  Services(
    details: '',
      isCalendar: false,
      id: 'OtherServices',
      name: 'Other Services',
      images:
          ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefX9fCIuEQ2LbMkp1Wmy8DCON0olwUwA3pQ&s'],
      bookNowButton: true,
      weblink: '',
      otherSevas: [
        SevaCategory(
          categoryName: "Daily Sevas",
          sevas: [
            SevaItem(title: "1.Mahapooje (Whole day included) - ₹400"),
            SevaItem(title: "2.Mahapooje (Afternoon included) - ₹250", ),
            SevaItem(title: "3.Pavamana Panchamrita Abhisheka - ₹100", ),
            SevaItem(title: "4.Kalasha pooja Panchamrita Abhisheka - ₹100",),
            SevaItem(title: "5.Panchamrita Abhisheka - ₹75", ),
            SevaItem(title: "6.Rudrabhisheka - ₹75", ),
            SevaItem(title: "7.Ksheerabhisheka - ₹50", ),
            SevaItem(title: "8.Sheshaseva - ₹100", ),
            SevaItem(title: "9.Kartika pooje - ₹50", ),
            SevaItem(title: "10.Pancha Kajjaya - ₹20", ),
            SevaItem(title: "11.Halu Payasa - ₹100", ),
            SevaItem(title: "12.Chitranna samarpane - ₹100", ),
          ],
        ),
        SevaCategory(
          categoryName: "Harake Sevas",
          sevas: [
            SevaItem(title: "1.Thulabhara - ₹75", ),
            SevaItem(title: "2.Chavala - ₹25", ),
            SevaItem(title: "3.Kivi chuchhuvudu (Ear piercing) - ₹20",),
            SevaItem(title: "4.Anna Prashana - ₹25", ),
            SevaItem(title: "5.Namkarana - ₹150", ),
          ],
        ),
      ]),
], timings: [
  Timings(
    image: 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
    day: "Monday",
    slots: [
      TimeSlot(from: "6AM", to: "1PM"),
      TimeSlot(from: "3PM", to: "8PM"),
    ],
    lunch: [
      TimeSlot(from: "1PM", to: "3PM"),
    ],
  ),
  Timings(image: 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
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
    image: 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
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
    image: 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
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
    image: 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
    day: "Friday",
    slots: [
      TimeSlot(from: "6AM", to: "1PM"),
      TimeSlot(from: "3PM", to: "8PM"),
    ],
    lunch: [
      TimeSlot(from: "1PM", to: "3PM"),
    ],
  ),
  Timings(
    image: 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
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
    image: 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
    day: "Sunday",
    slots: [
      TimeSlot(from: "6AM", to: "1PM"),
      TimeSlot(from: "3PM", to: "8PM"),
    ],
    lunch: [
      TimeSlot(from: "1PM", to: "3PM"),
    ],
  ),
], videos: [
  PoojaVideos(
    name: 'Morning Pooja',
    image:
        'https://icctmemphis.org/wp-content/uploads/2023/01/Subramanya_Valli_Devasena-scaled-e1675130620249.jpg',
    url: 'https://youtu.be/yXxeQndQYEM',
  ),
  PoojaVideos(
    name: 'Evening Pooja',
    image:
        'https://i.pinimg.com/736x/35/16/1a/35161a12f032244c3c78249d726ecb3d.jpg',
    url: 'https://youtu.be/yXxeQndQYEM',
  ),
  PoojaVideos(
    name: 'Special Pooja',
    image:
        'https://m.media-amazon.com/images/I/81VkuGYTB2L._UF894,1000_QL80_.jpg',
    url: 'https://youtu.be/yXxeQndQYEM',
  ),
], bhajans: [
  Bhajans(
    name: 'Devotional Song 1',
    image:
        'https://img.freepik.com/premium-photo/lakshmi-goddess-realistic-black-background-generative-ai_849906-13186.jpg',
    url: 'https://www.youtube.com/watch?v=V4BpHv4pFGA',
  ),
  Bhajans(
    name: 'Devotional Song 2',
    image:
        'https://img.freepik.com/premium-photo/portrait-lakshmi-goddess-realistic-black-background-generative-ai_849906-13185.jpg',
    url: 'https://www.youtube.com/watch?v=fGw9Lr7Kh4c',
  ),
  Bhajans(
    name: 'Devotional Song 3',
    image:
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhUgDpu4hHZnQBgYZJR-EbOLrxMrrA1hfctptZ9ZVGJUTlGiloYAzdLxrQmg4LKanU1znD0nrktzakRGad5eU-DKehTzSopevLf6CDiCb5NI7itGRQDX19smmp9d_CzmRe-Li5AsQxwUX4/s1600/Goddess+Lakshmi+Devi+images++(2).jpeg',
    url: 'https://www.youtube.com/watch?v=ECgPq22vQkc',
  ),
], nearByPlaces: [
  NearByPlaces(
    name: 'Kumara Parvatha Trek',
    images:[
      'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949730/Kumara_Parvatha_rjsekj.jpg',
      'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949741/Kumara_Parvatha1_ty8yy7.jpg',
      'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949909/Kumara_Parvatha4_ydpyeo.png',
      'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949811/Kumara_Parvatha2_jihuxo.jpg',
      'https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949816/Kumara_Parvatha3_bodqcf.jpg',
    
      ],
    description: '''
<h2>🌄 Kumara Parvatha Trek (Pushpagiri Peak)</h2>

<p>
Rising to <b>1,712 m</b>, Kumara Parvatha is Karnataka’s second-highest peak and one of the most sought-after treks in the Western Ghats — a mix of dense forests, rolling grasslands, and breathtaking summit views.
</p>

<h3>🚩 Trek Routes</h3>
<ul>
  <li><b>Somvarpet Side</b> – Shorter (7 km), steep and ideal for experienced trekkers.</li>
  <li><b>Kukke Subrahmanya Side</b> – Longer (14 km), the classic trail starting near Kukke temple with an overnight halt at Bhattaramane (forest checkpoint & campsite).</li>
</ul>

<h3>⭐ Why Trek Here?</h3>
<ul>
  <li>Mist-covered forests & vibrant grasslands</li>
  <li>Campsite experience at Bhattaramane</li>
  <li>Stunning sunrise & sunset from the peak</li>
</ul>

<h3>📌 Quick Info</h3>
<ul>
  <li><b>Difficulty:</b> Moderate – Difficult</li>
  <li><b>Duration:</b> 2 Days / 1 Night</li>
  <li><b>Best Season:</b> October – February</li>
  <li><b>Permit & Fees:</b> Entry pass required (₹350 per person) – carry valid ID proof</li>
  <li><b>Booking:</b> Permits are now available only through the Karnataka Tourism website. Click below to book online.</li>
</ul>

<p style="color:red;">
⚠️ Avoid monsoon months — trails turn slippery and leech-prone.
</p>
''',
bookNowButton: true,
    weblink:
        '',
        
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
], calender: {
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
    "29-08-2025",
  ],
});
