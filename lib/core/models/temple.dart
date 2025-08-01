class Temple {
  final List<Banner>? banner;
  final List<Services> services;
  final List<Timings> timings;
  final List<PoojaVideos>? videos;
  final List<Bhajans>? bhajans;
  Temple(
      {this.banner,
      required this.services,
      required this.timings,
      this.videos,
      this.bhajans});
}

class Banner {
  final String? bannerImage;
  final String? link;

  Banner({
    this.bannerImage,
    this.link,
  });
}

class Services {
  final String name;
  final String description;
  final List<String> date;
  final String image;

  Services({
    required this.name,
    required this.description,
    required this.date,
    required this.image,
  });
}

class Timings {
  final String day;
  final List<TimeSlot> slots;

  Timings({
    required this.day,
    required this.slots,
  });
}

class TimeSlot {
  final String from;
  final String to;

  TimeSlot({
    required this.from,
    required this.to,
  });
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
}

final templeData = Temple(
  banner: [
    Banner(
      bannerImage:
          'https://thetempleguru.com/wp-content/uploads/2024/07/Kukke-Shree-Subramanya-Temple-16.jpg',
      link: '',
    ),
    Banner(
      bannerImage:
          'https://media-cdn.tripadvisor.com/media/photo-m/1280/18/19/e6/67/photo5jpg.jpg',
      link: '',
    ),
    Banner(
      bannerImage:
          'https://media-cdn.tripadvisor.com/media/photo-s/0e/4b/5e/ed/adi-subramanya-temple.jpg',
      link: '',
    ),
    Banner(
      bannerImage: 'https://pbs.twimg.com/media/ErQ-Dh5VoAMTvjR.png',
      link: '',
    ),
  ],
  services: [
    Services(
      name: 'Sarpa Samskara',
      description:
          'Is a significant pooje performed to overcome the negative effects of serpent-related doshas or afflictions. It is believed to bring relief from various health issues, including those related to fertility and progeny.',
      date: ['02-08-2025', '03-08-2025', '04-08-2025', '05-08-2025'],
      image:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjK4XTybBTDUmCYedBN5wwqRoX3FIk3-541uCdy80JUE81Hgk0Rg4rjAJnRJL5wvd_iX5gGo9DTbc5UvLzgEpSM3pug4htBtyujSnN9GlOuWxUN1xsgeBq_Ege-6wHht7vBciIH5t-uZ4Ld/w1200-h630-p-k-no-nu/Kukke+Subrahmanya_Moola_Devaru.jpg',
    ),
    Services(
      name: 'Aslesha Bali',
      description:
          'A special pooje conducted to negate the adverse effects of planet Rahu and to seek protection against snake-related afflictions. It is performed in the temple courtyard on all Ashlesha Nakshatra days.',
      date: ['02-08-2025', '03-08-2025', '04-08-2025', '05-08-2025'],
      image:
          'https://www.nagapratishta.com/uploads/202303250759097146134_202205230308102263234_dhosam6.jpg',
    ),
    Services(
      name: 'Nagapratishta',
      description:
          'Is an elaborate and grand pooje dedicated to the Nagas or serpent deities. It is performed to gain blessings from the Nagas and to seek protection from snake-related troubles.',
      date: ['02-08-2025', '03-08-2025', '04-08-2025', '05-08-2025'],
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefX9fCIuEQ2LbMkp1Wmy8DCON0olwUwA3pQ&s',
    ),
    Services(
      name: 'Temple History',
      description:
          'The Kukke Subramanya Swamy Temple is a famous Hindu temple located in the village of Kukke / Subramanya in the Sullia Taluk of Karnataka, India. This temple is dedicated to Lord Subramanya, who is also known as Lord Murugan or Kartikeya, the younger son of Lord Shiva and Parvati and younger brother of Lord Sri Ganesha. Lord Subramanya is the presiding deity of the temple and is worshipped as the lord of serpents.',
      date: ['02-08-2025', '03-08-2025', '04-08-2025', '05-08-2025'],
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefX9fCIuEQ2LbMkp1Wmy8DCON0olwUwA3pQ&s',
    ),
    Services(
      name: 'Other Services',
      description:
          'The Kukke Subramanya Swamy Temple is a famous Hindu temple located in the village of Kukke / Subramanya in the Sullia Taluk of Karnataka, India. This temple is dedicated to Lord Subramanya, who is also known as Lord Murugan or Kartikeya, the younger son of Lord Shiva and Parvati and younger brother of Lord Sri Ganesha. Lord Subramanya is the presiding deity of the temple and is worshipped as the lord of serpents.',
      date: ['02-08-2025', '03-08-2025', '04-08-2025', '05-08-2025'],
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefX9fCIuEQ2LbMkp1Wmy8DCON0olwUwA3pQ&s',
    ),
  ],
  timings: [
    Timings(
      day: "Monday",
      slots: [
        TimeSlot(from: "6:30 AM", to: "1:30 PM"),
        TimeSlot(from: "3:30 PM", to: "8:30 PM"),
      ],
    ),
    Timings(
      day: "Tuesday",
      slots: [
        TimeSlot(from: "6:30 AM", to: "1:30 PM"),
        TimeSlot(from: "3:30 PM", to: "8:30 PM"),
      ],
    ),
    
  ],
  videos:[
    PoojaVideos(
      name: 'Morning Pooja',
      image: 'https://www.shutterstock.com/image-photo/stock-photo-brass-pooja-room-260nw-1601585596.jpg',
      url: '',
    ),
    PoojaVideos(
      name: 'Evening Pooja',
      image: 'https://staticimg.amarujala.com/assets/images/2024/08/04/pooja-thali_aa3942f583f08b85ae3271abdc0f561a.jpeg?w=414&dpr=1.0&q=80',
      url: '',
    ),
  ],
  bhajans: [
    Bhajans(
      name: 'Devotional Song 1',
      image: '',
      url: '',
    ),
    Bhajans(
      name: 'Devotional Song 2',
      image: '',
      url: '',
    ),
  ]
);
