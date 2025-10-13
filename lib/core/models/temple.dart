// ignore_for_file: public_member_api_docs, sort_constructors_first
class Temple {
  final String? logo;
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

  Temple({
    this.logo,
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
  });

  factory Temple.fromMap(Map<String, dynamic> map) {
    return Temple(
      logo: map['logo'] ?? '',
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
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'logo': logo,
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
  final String? name;
  final List<String>? images;
  final String? url;
  final String description;
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
    return NearByPlaces(
      name: map['name'],
      images: List<String>.from(map['images'] ?? []),
      url: map['url'],
      description: map['description'],
      directionButton:
          map['directionButton']?.toString().toLowerCase() == 'true',
      weblink: map['weblink'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'images': images,
      'url': url,
      'description': description,
      'directionButton': directionButton,
      'weblink': weblink
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
  final String? rituals;
  final String? howToBook;
  final String? fee;
  final String? tips;
  final bool? isCalendar;
  final List<SevaCategory>? otherSevas;
  final String calendarMaxDate;

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
    this.rituals,
    this.howToBook,
    this.fee,
    this.tips,
    this.isCalendar,
    this.otherSevas,
    required this.calendarMaxDate,
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
      rituals: map['rituals'],
      howToBook: map['howToBook'],
      fee: map['fee'],
      tips: map['tips'],
      isCalendar: map['isCalendar'],
      otherSevas: (map['otherSevas'] as List?)
          ?.map((c) => SevaCategory.fromMap(c))
          .toList(),
      calendarMaxDate: map['calendarMaxDate'] ?? '',
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
      'rituals': rituals,
      'howToBook': howToBook,
      'fee': fee,
      'tips': tips,
      'isCalendar': isCalendar,
      'otherSevas': otherSevas?.map((c) => c.toMap()).toList(),
      'calendarMaxDate': calendarMaxDate,
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

final templeData = Temple(
    isSmallBannerShow: true,
    logo:
        'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759736409/Logo_2_phnznp.png',
    banner: [
      TempleBanner(
        bannerImage:
            // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757914268/home_banner_rtarip.jpg',
            // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759465403/banner_lfafdc.jpg',
            'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759736124/banner1_pfpvjl.jpg',
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
    ],
    smallBanner: [
      SmallBanner(
        bannerImage:
            'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760003435/small_banner1_yygtpl.jpg',
        link: '',
      ),
      SmallBanner(
        bannerImage:
            'https://res.cloudinary.com/dblhl2rcq/image/upload/v1760003435/small_banner4_bpd4pz.jpg',
        link: '',
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
    services: [
      Services(
        details: '',
        isCalendar: true,
        id: 'SarpaSamskara',
        name: 'Sarpa Samskara',
        purpose: '''
<style>
  ul, ol, p { margin: 0; padding: 0; }
  li { margin-bottom: 6px; }
</style>

<ul>
  <li><strong>Relief from Sarpa/Naga Dosha</strong> – This pooja removes the negative effects that come from harming or killing snakes knowingly or unknowingly, in this life or past lives.</li>
  <li><strong>Ancestral Peace (Pitru Dosha)</strong> – It helps to clear ancestral curses and brings peace to forefathers, which in turn brings their blessings to the family.</li>
  <li><strong>Marriage &amp; Children Blessings</strong> – The pooja helps remove obstacles in marriage, solves issues of late marriage, and blesses couples who are struggling to have children.</li>
</ul>
''',
        images: [
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjK4XTybBTDUmCYedBN5wwqRoX3FIk3-541uCdy80JUE81Hgk0Rg4rjAJnRJL5wvd_iX5gGo9DTbc5UvLzgEpSM3pug4htBtyujSnN9GlOuWxUN1xsgeBq_Ege-6wHht7vBciIH5t-uZ4Ld/w1200-h630-p-k-no-nu/Kukke+Subrahmanya_Moola_Devaru.jpg'
        ],
        bookNowButton: true,
        weblink:
            'https://itms.kar.nic.in/ticketing/service_collection.php?tid=21&scode=21&sscode=1&target_type=&fees_slno=204256&group_id=4&action=P',
        rituals: '''
            <p>
Sarpa Samskara is a 2-day pooja. Devotees are advised to visit the temple one day early.  
Take a holy bath in the <b>Kumaradhara River</b> before entering the temple for the pooja, and wear simple, traditional clothes.
</p>

<h4>Day 1 – Main Steps</h4>
<ol>
  <li><b>Registration & Seating</b> – Show your ticket, complete registration, and sit in your assigned place inside the mantap.</li>
  <li><b>Sankalpa (Prayer of Intention)</b> – The devotee or family states their name and purpose for the pooja with the help of the priest.</li>
  <li><b>Sarpa Samskara Ritual</b> – A special Homa and other rites are performed to seek forgiveness for harming snakes knowingly or unknowingly, in this or past lives.</li>
</ol>

<h4>Day 2 – Final Steps</h4>
<ol>
  <li><b>Morning Abhisheka to Lord Subrahmanya</b> – The main deity is bathed with milk, water, and panchamruta, followed by prayers.</li>
  <li><b>Naga Pooja / Nagapratishtha</b> – Snake idols are worshipped with milk, flowers, turmeric, and kumkum, and placed as an offering.</li>
</ol>
            ''',
        howToBook: '''
           <p>
Booking for the Sarpa Samskara Pooja is done <b>online only</b> through the official <b>Kukke Subrahmanya Temple</b> website.
</p>

<ol>
  <li>Visit the official Kukke Subrahmanya Temple website and check the available calendar.</li>
  <li>Note: On <b>Ekadashi days</b>, the pooja will not be performed.</li>
  <li>Click on the <b>“Book Now”</b> button, select your preferred date, and fill in the required details.</li>
  <li>Pay the <b>₹4200</b> fee directly to the temple through the website to confirm your booking.</li>
  <li>Carry the booking receipt and a valid <b>ID proof</b> when you visit the temple for the pooja.</li>
</ol>
            ''',
        tips: '''
<style>
  ul, ol, p { margin: 0; padding: 0; }
  li { margin-bottom: 6px; }
</style>

<ul>
  <li>Carry a valid <b>ID card</b>.</li>
  <li><b>Note:</b> No pooja is performed on <b>Ekadashi</b> days.</li>
</ul>
''',
        unavailableDateIds: [
          'yekadashi',
        ],
        availableDateIds: [],
        calendarMaxDate: "31-03-2026",
      ),
      Services(
        details: '',
        id: 'AshleshaBali',
        name: 'Ashlesha Bali',
        purpose: '''
<p>To remove Sarpa Dosha (serpent curse) from one’s jataka (horoscope).</p>
<p>Brings relief from obstacles in marriage, childbirth, and family life.</p>
<p>Helps overcome ancestral karmic issues, financial instability, and health problems caused by Naga Dosha.</p>

            ''',
        images: [
          'https://www.nagapratishta.com/uploads/202303250759097146134_202205230308102263234_dhosam6.jpg'
        ],
        bookNowButton: true,
        weblink:
            'https://itms.kar.nic.in/ticketing/service_collection.php?tid=21&scode=21&sscode=1&target_type=&fees_slno=214319&group_id=4&action=P',
        rituals: '''
<p><strong>Sankalpa:</strong> Devotee’s name, gotra, and purpose are declared.</p>
<p>Pooja will be done in Ashlesha Bali Mantapa. Once done, you will be given the prasada.</p>
<p><strong>Pooja duration:</strong> ~1.5 to 2 hours.</p>
<p>Best performed on Ashlesha Nakshatra days.</p>

            ''',
        howToBook: '''
            <p>Book online via the official <strong>Kukke Subrahmanya Temple</strong> website.</p>
<p>Tickets also available at the temple counter (subject to slot availability).</p>
<p><strong>Cost:</strong> ₹400–₹500 per person (basic).</p>
<p>Advance booking recommended, especially on <strong>Ashlesha Nakshatra</strong> days.</p>
<p>Click the <strong>Book Now</strong> button below to proceed.</p>
<p><strong>Yatrify</strong> redirects you to the official temple website for secure booking.</p>
            ''',
        fee: "",
        tips: '''
            <p><strong>Ashlesha Nakshatra</strong> is the most auspicious day for this pooja.</p>
<p>Not performed on <strong>Ekadashi</strong>, so check the calendar before booking.</p>
            ''',
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
        details: '',
        id: 'NagaPrathishta',
        name: 'Naga Prathishta',
        purpose: '''
            <p>To remove Sarpa Dosha (afflictions related to serpents) from the horoscope.</p>
<p>To bring peace, prosperity, and family well-being.</p>
<p>To seek blessings of serpent deities for health and harmony.</p>
            ''',
        images: [
          // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915793/nagaprathiste2_itlmpl.jpg',
          // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915793/nagaprathiste3_y7ixob.jpg',
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759854227/naga_pratista2_j24wd9.png',
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759847682/naga_pratista1_zbtwtp.png',
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759855767/naga_pratista3_dzumsz.png',
          // 'https://res.cloudinary.com/dblhl2rcq/image/upload/v1757915793/nagaprathiste1_x8bqdm.jpg',
        ],
        bookNowButton: true,
        weblink: '',
        rituals: '''
            <p>The pooja begins with <b>Sankalpa</b> – devotees/family declare their name, Gotra, and purpose of performing the pooja.</p>

<p><b>Pratishthapane</b> (installation) is performed for the Naga Vigraha.</p>

<p>The priests also perform <b>Abhishekam</b> (holy bathing) of the Naga idol with sacred substances.</p>

<p>Special mantras and offerings are conducted throughout the ceremony.</p>

<p>The ritual starts at <b>11:00 AM</b> and continues for about 1 hour.</p>

            ''',
        howToBook: '''
            <p><strong>No online booking</strong> is available for this pooja.</p>
<p>Devotees must <strong>register directly at the temple counter</strong> on arrival.</p>
            ''',
        fee: '',
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
        tips: '''
            <p>The pooja is not performed on Ekadashi days.</p>
            ''',
      ),
      Services(
        details: '',
        isCalendar: true,
        id: 'RathosthavaSeva',
        name: 'Rathosthava Seva',
        purpose:
            'Is an elaborate and grand pooje dedicated to the Nagas or serpent deities. It is performed to gain blessings from the Nagas and to seek protection from snake-related troubles.',
        images: [
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
        calendarMaxDate: "31-03-2026",
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
        details: '',
        isCalendar: false,
        id: 'OtherServices',
        name: 'Other Services',
        images: [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefX9fCIuEQ2LbMkp1Wmy8DCON0olwUwA3pQ&s'
        ],
        bookNowButton: true,
        weblink: '',
        otherSevas: [
          SevaCategory(
            categoryName: "Daily Sevas",
            sevas: [
              SevaItem(title: "1.Mahapooje (Whole day included) - ₹400"),
              SevaItem(
                title: "2.Mahapooje (Afternoon included) - ₹250",
              ),
              SevaItem(
                title: "3.Pavamana Panchamrita Abhisheka - ₹100",
              ),
              SevaItem(
                title: "4.Kalasha pooja Panchamrita Abhisheka - ₹100",
              ),
              SevaItem(
                title: "5.Panchamrita Abhisheka - ₹75",
              ),
              SevaItem(
                title: "6.Rudrabhisheka - ₹75",
              ),
              SevaItem(
                title: "7.Ksheerabhisheka - ₹50",
              ),
              SevaItem(
                title: "8.Sheshaseva - ₹100",
              ),
              SevaItem(
                title: "9.Kartika pooje - ₹50",
              ),
              SevaItem(
                title: "10.Pancha Kajjaya - ₹20",
              ),
              SevaItem(
                title: "11.Halu Payasa - ₹100",
              ),
              SevaItem(
                title: "12.Chitranna samarpane - ₹100",
              ),
            ],
          ),
          SevaCategory(
            categoryName: "Harake Sevas",
            sevas: [
              SevaItem(
                title: "1.Thulabhara - ₹75",
              ),
              SevaItem(
                title: "2.Chavala - ₹25",
              ),
              SevaItem(
                title: "3.Kivi chuchhuvudu (Ear piercing) - ₹20",
              ),
              SevaItem(
                title: "4.Anna Prashana - ₹25",
              ),
              SevaItem(
                title: "5.Namkarana - ₹150",
              ),
            ],
          ),
        ],
        calendarMaxDate: "31-03-2026",
      ),
      Services(
        details: '''
<h3>Kumara Parvatha Trek (Pushpagiri Peak)</h3>

<p>
Rising to <b>1,712 m</b>, Kumara Parvatha is Karnataka’s second-highest peak and one of the most sought-after treks in the Western Ghats — a mix of dense forests, rolling grasslands, and breathtaking summit views.
</p>

<img 
  src="https://res.cloudinary.com/dblhl2rcq/image/upload/v1758949909/Kumara_Parvatha4_ydpyeo.png" 
  alt="Kumara Parvatha" 
  style="display:block; width:MediaQuery.of(context).size.width; height:340px; object-fit:cover; border-radius:12px;" 
/>

<h3>Trek Routes</h3>
<ul>
  <li><b>Somvarpet Side</b> – Shorter (7 km), steep and ideal for experienced trekkers.</li>
  <li><b>Kukke Subrahmanya Side</b> – Longer (14 km), the classic trail starting near Kukke temple with an overnight halt at Bhattaramane (forest checkpoint & campsite).</li>
</ul>

<h3>Why Trek Here?</h3>
<ul>
  <li>Mist-covered forests & vibrant grasslands</li>
  <li>Campsite experience at Bhattaramane</li>
  <li>Stunning sunrise & sunset from the peak</li>
</ul>

<h3>Quick Info</h3>
<ul>
  <li><b>Difficulty:</b> Moderate – Difficult</li>
  <li><b>Duration:</b> 2 Days / 1 Night</li>
  <li><b>Best Season:</b> October – February</li>
  <li><b>Permit & Fees:</b> Entry pass required (₹350 per person) – carry valid ID proof</li>
  <li><b>Booking:</b> Permits are now available only through the Karnataka Tourism website. Click below to book online.</li>
</ul>

<p style="color:red;">
 Avoid monsoon months — trails turn slippery and leech-prone.
</p>
''',
        isCalendar: false,
        id: 'KumaraParvathaTrek',
        name: 'Kumara Parvatha Trek',
        purpose: '',
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
        rituals: '',
        howToBook: '',
        fee: '',
        tips: '',
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
    ],
    bhajans: [
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
    ],
    nearByPlaces: [
      NearByPlaces(
        name: 'Basaveshwara temple Kulkunda',
        images: [
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759741561/Basaveshwara_temple_Kulkunda_ade9lh.jpg',
        ],
        description: '''
<h3>Basaveshwara Temple, Kulkunda</h3>
<p>
Located just <b>4 km from Kukke Temple</b>, this <b>800-year-old shrine</b> showcases 
ancient Hindu architecture with a <b>unique Shivalinga on Nandi’s forehead</b>.
</p>
        ''',
        directionButton: true,
        weblink: 'https://maps.app.goo.gl/mp3hEt4ssudMDUhR6',
        url: '',
      ),

      NearByPlaces(
        name: 'Shri Somanatheshwara temple',
        images: [
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742005/Shri_Somanatheshwara_temple_hgwtja.jpg',
        ],
        description: '''
<h3>Shri Somanatheshwara Temple</h3>

<p>
Located just <b>2 km from Kukke Temple</b>, the <b>Agrahara Somanath Temple</b> is an 
<b>800-year-old shrine</b> situated on the riverbank, reflecting the grandeur of 
ancient Hindu architecture.
</p>

        ''',
        directionButton: true,
        weblink: 'https://maps.app.goo.gl/9WnpfaDLKqBGmhEz8',
        url: '',
      ),
      NearByPlaces(
        name: 'Shri Shankapala Subrahmanya Swami Temple',
        images: [
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742245/Shri_Shankapala_Subrahmanya_Swami_Temple_cnd92j.jpg',
        ],
        description: '''
<h3>Shri Shankapala Subrahmanya Swami Temple</h3>

<p>
It is located about <b>10 km from Kukke Temple</b>. A unique feature of this temple is 
the presence of a <b>live anthill (hutta)</b> inside the sanctum.
</p>
        ''',
        directionButton: true,
        weblink: 'https://maps.app.goo.gl/ccHSTWV5kPniqSEJA',
        url: '',
      ),

      NearByPlaces(
        name: 'Marakatha DurgaParameshwari Temple',
        images: [
          'https://res.cloudinary.com/dblhl2rcq/image/upload/v1759742425/Marakatha_DurgaParameshwari_Temple_i2glza.jpg',
        ],
        description: '''
<h3>Marakatha Durga Parameshwari Temple</h3>

<p>
Located about <b>8 km from Kukke Temple</b>, it sits on the banks of the <b>Kotitheertha River</b> 
flowing from Shesha Parvata. Surrounded by greenery, it’s believed that feeding the fish here 
and praying to the Lord fulfills one’s wishes.
</p>

        ''',
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
    });
