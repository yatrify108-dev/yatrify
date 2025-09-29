import 'package:bookstay/core/models/base_banner.dart';
import 'package:bookstay/features/widgets/banner_carousel.dart';
import 'package:bookstay/features/widgets/info_widget.dart';
import 'package:bookstay/features/widgets/service_detail_card.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import '../../core/models/temple.dart';
import '../widgets/app_button.dart';

class ServicesDetailsView extends StatelessWidget {
  const ServicesDetailsView({
    super.key,
    required this.service,
    required this.calendar,
  });

  final Services service;
  final Map<String, List<String>>? calendar;

  @override
  Widget build(BuildContext context) {
    List<DateTime> parseDateList(List<String>? dateStrings) {
      if (dateStrings == null) return [];
      final dates = <DateTime>[];
      for (final dateString in dateStrings) {
        try {
          final parts = dateString.split('-');
          if (parts.length != 3) continue;
          int day, month, year;
          if (parts[0].length == 4) {
            year = int.parse(parts[0]);
            month = int.parse(parts[1]);
            day = int.parse(parts[2]);
          } else {
            day = int.parse(parts[0]);
            month = int.parse(parts[1]);
            year = int.parse(parts[2]);
          }
          dates.add(DateTime(year, month, day));
        } catch (_) {}
      }
      return dates;
    }

    bool isSameDay(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

// Helper: collect dates for a list of ids from the calendar map
    List<DateTime> datesForIds(
        Map<String, List<String>>? calendar, List<String>? ids) {
      if (calendar == null || ids == null) return const [];
      final out = <DateTime>[];
      for (final id in ids) {
        out.addAll(parseDateList(calendar[id]));
      }
      return out;
    }

// Fast lookup key (yyyymmdd)
    int k(DateTime d) => d.year * 10000 + d.month * 100 + d.day;

    final label = context.labels;

// ✅ Use ONLY the current service’s ids
    final availableList = datesForIds(calendar, service.availableDateIds);
    final unavailableList = datesForIds(calendar, service.unavailableDateIds);

// Sets for O(1) membership
    final availableSet = availableList.map(k).toSet();
    final unavailableSet = unavailableList.map(k).toSet();

// “All day available” when both id lists are empty
    final allDayAvailable = (service.availableDateIds?.isEmpty ?? true) &&
        (service.unavailableDateIds?.isEmpty ?? true);

    final now = DateTime.now();
    final minDate = DateTime(now.year, now.month, 1);
    final maxDate = DateTime(now.year, now.month + 2, 0);
    // final validVideos =
    //     service.videos!.where((v) => v.link.isNotEmpty).toList();

    // bool isSameDay(DateTime date1, DateTime date2) {
    //   return date1.year == date2.year &&
    //       date1.month == date2.month &&
    //       date1.day == date2.day;

    // }

    // final label = context.labels;
    final availableDates = parseDateList(
      calendar?.values.expand((dates) => dates).toList(),
    );
    final unavailableDates = parseDateList(service.unavailableDateIds);
    List<DateTime> cleanAvailableDates(
        List<DateTime> available, List<DateTime> unavailable) {
      return available.where((date) {
        return !unavailable.any((unavDate) => isSameDay(date, unavDate));
      }).toList();
    }

    final cleanedAvailableDates =
        cleanAvailableDates(availableDates, unavailableDates);
    // final now = DateTime.now();
    // final minDate = DateTime(now.year, now.month, 1);
    // final maxDate = DateTime(now.year, now.month + 2, 0);
    // final validVideos =
    //     service.videos!.where((v) => v.link.isNotEmpty).toList();

    // Color palette
    final Color redBg = Colors.red;
    // final Color redTx = Colors.red;
    final Color blackTx = Colors.black;

    final Color greenBg = Colors.green.shade800; // light fill
    // final Color greenTx =
    //     Colors.green.shade800; // dark green text (your “dark green”)

    // final Color grayBg = Colors.grey.shade200; // light gray
    final Color grayTx = Colors.grey;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          service.name,
          style: context.style.titleLarge!
              .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar:
          (service.bookNowButton && service.weblink.isNotNullOrEmpty)
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  child: AppButton(
                    label: label.bookNow,
                    onPressed: () {
                      service.weblink.launch();
                    },
                  ),
                )
              : const SizedBox.shrink(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ClipRRect(
            //   child: CachedNetworkImage(
            //     imageUrl: service.images.first,
            //     height: MediaQuery.of(context).size.height * 0.3,
            //     fit: BoxFit.cover,
            //     width: double.infinity,
            //     placeholder: (context, url) => const Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   ),
            // ),
            BannerCarousel(
              screenHeightValue: MediaQuery.of(context).size.height * 0.4,
              autoPlay: true,
              banners: service.images
                  .map((url) => BaseBanner(bannerImage: url, link: null))
                  .toList(),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: HtmlWidget(
            //     service.details,
            //     textStyle: context.style.titleMedium,
            //     enableCaching: true,
            //   ),
            // ),
            if (service.details!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: HtmlWidget(
                  service.details!,
                  textStyle: context.style.bodyMedium!.copyWith(fontSize: 16),
                  enableCaching: true,
                ),
              ),
            ],
            if (service.purpose!.isNotEmpty) ...[
              const SizedBox(height: 16),
              ServiceDetailCard(
                  title: label.purpose,
                  details: service.purpose!,
                  icon: FontAwesomeIcons.solidStar)
            ],
            if (service.otherSevas != null &&
                service.otherSevas!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: service.otherSevas!.map((category) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.categoryName,
                          style: context.style.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...category.sevas.map((seva) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                seva.title,
                                style: context.style.bodyMedium!
                                    .copyWith(fontSize: 16),
                              ),
                            )),
                        const SizedBox(height: 12),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],

            // if (service.videos != null &&
            //     service.videos!.isNotEmpty &&
            //     validVideos.isNotEmpty) ...[
            //   //const SizedBox(height: 20),
            //   SizedBox(
            //     height: 180,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: validVideos.length,
            //       padding: const EdgeInsets.symmetric(horizontal: 16),
            //       itemBuilder: (context, index) {
            //         final video = validVideos[index];
            //         if (video.link.isEmpty) return const SizedBox.shrink();

            //         final videoId = YoutubePlayer.convertUrlToId(video.link)!;
            //         final thumbnailUrl = YoutubePlayer.getThumbnail(
            //           videoId: videoId,
            //           quality: ThumbnailQuality.high,
            //         );

            //         return GestureDetector(
            //           onTap: () {
            //             context.push('/video-player', extra: video.link);
            //           },
            //           child: Container(
            //             margin: const EdgeInsets.only(right: 12, top: 20),
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(16),
            //               child: Stack(
            //                 alignment: Alignment.center,
            //                 children: [
            //                   CachedNetworkImage(
            //                     imageUrl: thumbnailUrl,
            //                     fit: BoxFit.cover,
            //                     height: 140,
            //                     width: 180,
            //                   ),
            //                   Container(
            //                     decoration: const BoxDecoration(
            //                       color: Colors.black54,
            //                       shape: BoxShape.circle,
            //                     ),
            //                     padding: const EdgeInsets.all(8),
            //                     child: const Icon(
            //                       Icons.play_arrow,
            //                       color: Colors.white,
            //                       size: 40,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ],

            if (service.timings != null && service.timings!.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              ServiceDetailCard(
                  title: label.timings,
                  details: service.timings!,
                  icon: FontAwesomeIcons.solidClock)
            ],
            if (service.dressCode != null && service.dressCode!.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              ServiceDetailCard(
                  title: label.dressCode,
                  details: service.dressCode!,
                  icon: FontAwesomeIcons.shirt)
            ],
            if (service.fee != null && service.fee!.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              ServiceDetailCard(
                  title: label.fee,
                  details: service.fee!,
                  icon: FontAwesomeIcons.indianRupeeSign)
            ],
            if (service.tips != null && service.tips!.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              ServiceDetailCard(
                  title: label.tips,
                  details: service.fee!,
                  icon: FontAwesomeIcons.solidLightbulb)
            ],
            if (service.isCalendar!) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  label.availableDates,
                  style: context.style.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    InfoWidget(
                      color: greenBg,
                      title: 'Available',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InfoWidget(
                      color: redBg,
                      title: 'Unavailable',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Sun",
                      style: context.style.titleSmall,
                    ),
                    Text(
                      "Mon",
                      style: context.style.titleSmall,
                    ),
                    Text(
                      "Tue",
                      style: context.style.titleSmall,
                    ),
                    Text(
                      "Wed",
                      style: context.style.titleSmall,
                    ),
                    Text(
                      "Thu",
                      style: context.style.titleSmall,
                    ),
                    Text(
                      "Fri",
                      style: context.style.titleSmall,
                    ),
                    Text(
                      "Sat",
                      style: context.style.titleSmall,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                height: 610,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: PagedVerticalCalendar(
                  physics: const NeverScrollableScrollPhysics(),
                  minDate: minDate,
                  maxDate: maxDate,
                  initialDate: DateTime.now(),
                  onDayPressed: (date) {
                    if (availableDates.any((d) => isSameDay(d, date))) {}
                  },
                  monthBuilder: (context, month, year) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '${_getMonthName(month)} $year',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  dayBuilder: (context, date) {
                    final key = k(date);

                    Color bgColor;
                    Color textColor;

                    if (allDayAvailable) {
                      // both id lists empty → everything green
                      bgColor = greenBg;
                      textColor = blackTx;
                    } else if (unavailableSet.contains(key)) {
                      // Yekadashi → red (highest priority)
                      bgColor = redBg;
                      textColor = blackTx;
                    } else if (availableSet.contains(key)) {
                      // Ashlesha Nakshathra / Shudha Shasti (ids in available) → green
                      bgColor = greenBg;

                      textColor = blackTx;
                    } else {
                      // Rest → light gray
                      bgColor = Colors.transparent;
                      textColor = grayTx;
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            height: 2), // spacing between text & circle
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: bgColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    );

                    // return Container(
                    //   margin: const EdgeInsets.all(4),
                    //   decoration: BoxDecoration(
                    //     color: bgColor,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       '${date.day}',
                    //       style: TextStyle(
                    //         color: textColor,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullCalendarPage(
                          availableDates: cleanedAvailableDates,
                          unavailableDates: unavailableList,
                          allDayAvailable: allDayAvailable,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    label.viewMore,
                    style: context.style.titleMedium!.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

class FullCalendarPage extends StatelessWidget {
  final List<DateTime> availableDates;
  final List<DateTime> unavailableDates;
  final bool allDayAvailable;

  const FullCalendarPage({
    super.key,
    required this.availableDates,
    required this.unavailableDates,
    required this.allDayAvailable,
  });

  // Fast lookup key
  int k(DateTime d) => d.year * 10000 + d.month * 100 + d.day;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    // Build sets (same as in ServicesDetailsView)
    final availableSet = availableDates.map(k).toSet();
    final unavailableSet = unavailableDates.map(k).toSet();
    final Color redBg = Colors.red;
    // final Color redTx = Colors.red;
    final Color blackTx = Colors.black;

    final Color greenBg = Colors.green.shade800; // light fill
    // final Color greenTx =
    //     Colors.green.shade800; // dark green text (your “dark green”)

    //  final Color grayBg = Colors.grey.shade200; // light gray
    final Color grayTx = Colors.grey;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(label.availableDates),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                InfoWidget(
                  color: greenBg,
                  title: 'Available',
                ),
                const SizedBox(
                  width: 20,
                ),
                InfoWidget(
                  color: redBg,
                  title: 'Unavailable',
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Sun", style: context.style.titleMedium),
                Text("Mon", style: context.style.titleMedium),
                Text("Tue", style: context.style.titleMedium),
                Text("Wed", style: context.style.titleMedium),
                Text("Thu", style: context.style.titleMedium),
                Text("Fri", style: context.style.titleMedium),
                Text("Sat", style: context.style.titleMedium),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PagedVerticalCalendar(
                minDate: DateTime.now(),
                maxDate: DateTime.now().add(const Duration(days: 365)),
                initialDate: DateTime.now(),
                monthBuilder: (context, month, year) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${_getMonthName(month)} $year',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                dayBuilder: (context, date) {
                  final key = k(date);

                  Color bgColor;
                  Color textColor;

                  if (allDayAvailable) {
                    // both id lists empty → everything green
                    bgColor = greenBg;
                    textColor = blackTx;
                  } else if (unavailableSet.contains(key)) {
                    // Yekadashi → red (highest priority)
                    bgColor = redBg;
                    textColor = blackTx;
                  } else if (availableSet.contains(key)) {
                    // Ashlesha Nakshathra / Shudha Shasti (ids in available) → green
                    bgColor = greenBg;

                    textColor = blackTx;
                  } else {
                    // Rest → light gray
                    bgColor = Colors.transparent;
                    textColor = grayTx;
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
