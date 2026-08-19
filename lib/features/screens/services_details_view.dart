import 'package:cached_network_image/cached_network_image.dart';
import 'package:yatrify/core/models/base_banner.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/features/widgets/banner_carousel.dart';
import 'package:yatrify/features/widgets/info_widget.dart';
import 'package:yatrify/features/widgets/official_link_widget.dart';
import 'package:yatrify/features/widgets/rathosthava_seva_widget.dart';
import 'package:yatrify/features/widgets/service_detail_card.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../core/models/temple.dart';
import '../widgets/app_button.dart';

class ServicesDetailsView extends StatefulWidget {
  const ServicesDetailsView({
    super.key,
    required this.service,
    required this.calendar,
    required this.webLogo,
  });

  final Services service;
  final Map<String, List<String>>? calendar;
  final String webLogo;

  @override
  State<ServicesDetailsView> createState() => _ServicesDetailsViewState();
}

class _ServicesDetailsViewState extends State<ServicesDetailsView> {
  @override
  void initState() {
    super.initState();
    FirebaseManager()
        .setCurrentScreen('LandedOn${widget.service.name}ViewScreen');
  }

  @override
  Widget build(BuildContext context) {
    final labels = context.labels;
    // List<DateTime> parseDateList(List<String>? dateStrings) {
    //   if (dateStrings == null) return [];
    //   final dates = <DateTime>[];
    //   for (final dateString in dateStrings) {
    //     try {
    //       final parts = dateString.split('-');
    //       if (parts.length != 3) continue;
    //       int day, month, year;
    //       if (parts[0].length == 4) {
    //         year = int.parse(parts[0]);
    //         month = int.parse(parts[1]);
    //         day = int.parse(parts[2]);
    //       } else {
    //         day = int.parse(parts[0]);
    //         month = int.parse(parts[1]);
    //         year = int.parse(parts[2]);
    //       }
    //       dates.add(DateTime(year, month, day));
    //     } catch (_) {}
    //   }
    //   return dates;
    // }

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

          // Create date
          final date = DateTime(year, month, day);

          // Validate original Firebase date
          if (date.year == year && date.month == month && date.day == day) {
            dates.add(date);
          }
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
    final availableList =
        datesForIds(widget.calendar, widget.service.availableDateIds);
    final unavailableList =
        datesForIds(widget.calendar, widget.service.unavailableDateIds);

// Sets for O(1) membership
    final availableSet = availableList.map(k).toSet();
    final unavailableSet = unavailableList.map(k).toSet();

// “All day available” when both id lists are empty
    final allDayAvailable =
        (widget.service.availableDateIds?.isEmpty ?? true) &&
            (widget.service.unavailableDateIds?.isEmpty ?? true);

    final now = DateTime.now();
    final minDate = DateTime(now.year, now.month, 1);
    final maxDate = DateTime(now.year, now.month + 2, 0);
    final safeInitialDate = now.isAfter(maxDate) ? maxDate : now;

    final availableDates = parseDateList(
      widget.calendar?.values.expand((dates) => dates).toList(),
    );
    final unavailableDates = parseDateList(widget.service.unavailableDateIds);
    List<DateTime> cleanAvailableDates(
        List<DateTime> available, List<DateTime> unavailable) {
      return available.where((date) {
        return !unavailable.any((unavDate) => isSameDay(date, unavDate));
      }).toList();
    }

    final cleanedAvailableDates =
        cleanAvailableDates(availableDates, unavailableDates);

    // Color palette
    const Color redBg = Colors.red;
    // final Color redTx = Colors.red;
    const Color blackTx = Colors.black;

    final Color yellowBg = Colors.yellow.shade700;
    final Color greenlightBg = Colors.green.shade300;

    final Color grayTx = Colors.grey;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          LocaleService.getLocalized(widget.service.name),
          style: context.style.titleLarge!
              .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: (widget.service.bookNowButton &&
              widget.service.weblink.isNotNullOrEmpty)
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
                  try {
                    if (widget.service.id.toLowerCase() ==
                        'kumaraparvathatrek') {
                      widget.service.weblink.launch();
                    } else {
                      context.push(
                        '/redirect-page',
                        extra: {
                          'url': widget.service.weblink,
                          'title': labels.openingTemplesOfficialPage,
                          'subTitle': labels.yourSpiritual,
                          'webLogo': widget.webLogo,
                        },
                      );
                    }
                    FirebaseManager().logEvent(
                      FirebaseEvent.buttonClick,
                      parameters: {
                        'button_name': '${widget.service.name}_book_now'
                      },
                    );
                  } catch (e, stackTrace) {
                    FirebaseManager().reportError(
                      e,
                      stackTrace,
                    );
                  }
                  // service.weblink.launch();
                },
              ),
            )
          : const SizedBox.shrink(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerCarousel(
              screenHeightValue: MediaQuery.of(context).size.height * 0.4,
              autoPlay: true,
              banners: widget.service.images
                  .map((url) => BaseBanner(bannerImage: url, link: null))
                  .toList(),
            ),
            widget.service.id.toLowerCase() == 'rathosthavaseva'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RathosthavaSevaWidget(
                      rathotsavaSevaList:
                          widget.service.rathotsavaSevaList ?? [],
                      note: LocaleService.getLocalized(widget.service.note),
                      contactDetails: LocaleService.getLocalized(
                          widget.service.contactDetails),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if ((LocaleService.getLocalized(widget.service.details!))
                          .isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: HtmlWidget(
                            LocaleService.getLocalized(widget.service.details!),
                            enableCaching: true,
                            textStyle: context.style.bodyMedium!
                                .copyWith(fontSize: 16),
                            customWidgetBuilder: (element) {
                              if (element.localName == 'img') {
                                final src = element.attributes['src'];
                                double? height;
                                final style = element.attributes['style'] ?? '';
                                if (style.contains('height')) {
                                  final heightStr = style
                                      .split('height:')[1]
                                      .split('px')[0]
                                      .trim();
                                  height = double.tryParse(heightStr);
                                }

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: src ?? '',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: height,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                      if ((LocaleService.getLocalized(widget.service.purpose!))
                          .isNotEmpty) ...[
                        const SizedBox(height: 12),
                        ServiceDetailCard(
                            title: label.purpose,
                            details: LocaleService.getLocalized(
                                widget.service.purpose!),
                            icon: FontAwesomeIcons.solidStar)
                      ],
                      if (widget.service.otherSevas != null &&
                          (LocaleService.getLocalized(
                                  widget.service.otherSevas!))
                              .isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: HtmlWidget(
                            (LocaleService.getLocalized(
                                widget.service.otherSevas)),
                            textStyle: context.style.bodyMedium!
                                .copyWith(fontSize: 15),
                            enableCaching: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (widget.service.rituals != null &&
                          (LocaleService.getLocalized(widget.service.rituals!))
                              .isNotEmpty) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        ServiceDetailCard(
                            title: label.rituals,
                            details: LocaleService.getLocalized(
                                widget.service.rituals!),
                            icon: FontAwesomeIcons.dharmachakra)
                      ],
                      if (widget.service.howToBook != null &&
                          (LocaleService.getLocalized(
                                  widget.service.howToBook!))
                              .isNotEmpty) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        ServiceDetailCard(
                            title: label.howToBook,
                            details: LocaleService.getLocalized(
                                widget.service.howToBook!),
                            icon: FontAwesomeIcons.calendarCheck)
                      ],
                      if (widget.service.bookingUrl != null &&
                          widget.service.bookingUrl!.isNotEmpty) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        OfficialLinkWidget(
                          bookingUrl: widget.service.bookingUrl!,
                          bookingLinkTitle: widget.service.bookingLinkTitle != null ? LocaleService.getLocalized(
                              widget.service.bookingLinkTitle!) : '',
                        ),
                      ],
                      if (widget.service.fee != null &&
                          (LocaleService.getLocalized(widget.service.fee!))
                              .isNotEmpty) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        ServiceDetailCard(
                            title: label.fee,
                            details:
                                LocaleService.getLocalized(widget.service.fee!),
                            icon: FontAwesomeIcons.indianRupeeSign)
                      ],
                      if (widget.service.tips != null &&
                          (LocaleService.getLocalized(widget.service.tips!))
                              .isNotEmpty) ...[
                        const SizedBox(
                          height: 8,
                        ),
                        ServiceDetailCard(
                            title: label.tips,
                            details: LocaleService.getLocalized(
                                widget.service.tips!),
                            icon: FontAwesomeIcons.solidLightbulb)
                      ],
                      if (widget.service.isCalendar!) ...[
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            label.availableDates,
                            style: context.style.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Wrap(
                            spacing: 24,
                            runSpacing: 4,
                            children: [
                              if (availableSet.isNotEmpty)
                                InfoWidget(
                                  color: yellowBg,
                                  title: label.specialDay,
                                ),
                              InfoWidget(
                                color: greenlightBg,
                                title: label.available,
                              ),

                              InfoWidget(
                                color: redBg,
                                title: label.ekadashi,
                              ),

                              //    InfoWidget(
                              //   color: redBg,
                              //   title: 'Unavailable',
                              // )
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
                          margin:
                              const EdgeInsets.all(16.0).copyWith(bottom: 0),
                          height: 660,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: PagedVerticalCalendar(
                            physics: const NeverScrollableScrollPhysics(),
                            minDate: minDate,
                            maxDate: maxDate,
                            initialDate: safeInitialDate,
                            startWeekWithSunday: true,
                            onDayPressed: (date) {
                              if (availableDates
                                  .any((d) => isSameDay(d, date))) {}
                            },
                            monthBuilder: (context, month, year) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                bgColor = greenlightBg;
                                textColor = blackTx;
                              } else if (unavailableSet.contains(key)) {
                                // Yekadashi → red (highest priority)
                                bgColor = redBg;
                                textColor = blackTx;
                              } else if (availableSet.contains(key)) {
                                // Ashlesha Nakshathra / Shudha Shasti (ids in available) → green
                                bgColor = yellowBg;

                                textColor = blackTx;
                              } else {
                                // Rest → light gray
                                // bgColor = Colors.transparent;
                                // textColor = grayTx;
                                bgColor = greenlightBg;
                                textColor = blackTx;
                              }
                              return GestureDetector(
                                onTap: () {
                                  if (bgColor == redBg) {
                                    showAlert(
                                      QuickAlertType.custom,
                                      context,
                                      label.poojaNotAvailable,
                                      label.pleaseSelectAnotherDate,
                                      3,
                                      label.okay,
                                      null,
                                      widget.webLogo,
                                      widget.service.bookNowButton &&
                                          widget
                                              .service.weblink.isNotNullOrEmpty,
                                    );
                                  } else if (bgColor == yellowBg) {
                                    showAlert(
                                      QuickAlertType.custom,
                                      context,
                                      label.specialPoojaDay,
                                      label.ashleshaNakshatraSpecialPooja,
                                      2,
                                      label.bookNow,
                                      widget.service.weblink,
                                      widget.webLogo,
                                      widget.service.bookNowButton &&
                                          widget
                                              .service.weblink.isNotNullOrEmpty,
                                    );
                                  } else if (bgColor == greenlightBg) {
                                    showAlert(
                                      QuickAlertType.custom,
                                      context,
                                      label.poojaAvailable,
                                      label.youCanBookPooja,
                                      1,
                                      label.bookNow,
                                      widget.service.weblink,
                                      widget.webLogo,
                                      widget.service.bookNowButton &&
                                          widget
                                              .service.weblink.isNotNullOrEmpty,
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.transparent,
                                  child: Column(
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
                                          height:
                                              2), // spacing between text & circle
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                          color: bgColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // List<String> parts =
                              //     widget.service.calendarMaxDate.split('-');
                              // DateTime parsedDate = DateTime.now();

                              // if (parts.length == 3) {
                              //   // int day = int.parse(parts[0]);
                              //   // int month = int.parse(parts[1]);
                              //   // int year = int.parse(parts[2]);

                              //   // parsedDate = DateTime(year, month, day);
                              //   int day = int.parse(parts[0]);
                              //   int month = int.parse(parts[1]);
                              //   int year = int.parse(parts[2]);

                              //   final tempDate = DateTime(year, month, day);

                              //   // Validate Firebase date
                              //   if (tempDate.year == year &&
                              //       tempDate.month == month &&
                              //       tempDate.day == day) {
                              //     parsedDate = tempDate;
                              //   } else {
                              //     debugPrint(
                              //         "Invalid calendarMaxDate: ${widget.service.calendarMaxDate}");
                              //   }
                              // }
                              List<String> parts =
                                  widget.service.calendarMaxDate.split('-');

                              DateTime parsedDate = DateTime.now();

                              if (parts.length == 3) {
                                int day = int.parse(parts[0]);
                                int month = int.parse(parts[1]);
                                int year = int.parse(parts[2]);

                                final lastDayOfMonth =
                                    DateTime(year, month + 1, 0).day;

                                if (day > lastDayOfMonth) {
                                  // Invalid date like 31-09-2026
                                  parsedDate =
                                      DateTime(year, month, lastDayOfMonth);

                                  debugPrint(
                                    "Invalid date ${widget.service.calendarMaxDate}, using $parsedDate",
                                  );
                                } else {
                                  parsedDate = DateTime(year, month, day);
                                }
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FullCalendarPage(
                                    availableDates: availableList,
                                    unavailableDates: unavailableList,
                                    allDayAvailable: allDayAvailable,
                                    maxDate: parsedDate,
                                    url: widget.service.weblink,
                                    webLogo: widget.webLogo,
                                    showBookButton: widget
                                            .service.bookNowButton &&
                                        widget.service.weblink.isNotNullOrEmpty,
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

void showAlert(
  QuickAlertType quickAlertType,
  BuildContext context,
  String title,
  String subTitle,
  int num,
  String buttonText,
  String? url,
  String webLogo,
  bool showBookButton,
) {
  QuickAlert.show(
    context: context,
    confirmBtnColor: primaryColor,
    type: quickAlertType,
    confirmBtnText: buttonText,
    showConfirmBtn: showBookButton,
    widget: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline,
            color: (num == 1)
                ? Colors.green
                : (num == 2)
                    ? Colors.yellow.shade700
                    : Colors.red,
            size: 60),
        const SizedBox(height: 16),
        Text(
          title,
          style: context.style.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          subTitle,
          style: context.style.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    onConfirmBtnTap: showBookButton
        ? () {
            if (url != null && url.isNotEmpty) {
              context.pop();
              context.push(
                '/redirect-page',
                extra: {
                  'url': url,
                  'title': context.labels.openingTemplesOfficialPage,
                  'subTitle': context.labels.yourSpiritual,
                  'webLogo': webLogo,
                },
              );
            } else {
              context.pop();
            }
          }
        : null,
  );
}

class FullCalendarPage extends StatelessWidget {
  final List<DateTime> availableDates;
  final List<DateTime> unavailableDates;
  final bool allDayAvailable;
  final DateTime maxDate;
  final String url;
  final String webLogo;
  final bool showBookButton;

  const FullCalendarPage({
    super.key,
    required this.availableDates,
    required this.unavailableDates,
    required this.allDayAvailable,
    required this.maxDate,
    required this.url,
    required this.webLogo,
    required this.showBookButton,
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

    final Color yellowBg = Colors.yellow.shade700;
    final Color greenlightBg = Colors.green.shade300;

    final Color grayTx = Colors.grey;
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final safeMaxDate = maxDate.isBefore(today) ? today : maxDate;

    final safeInitialDate = today.isAfter(safeMaxDate) ? safeMaxDate : today;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(label.availableDates),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Wrap(
              spacing: 24,
              runSpacing: 4,
              children: [
                if (availableSet.isNotEmpty)
                  InfoWidget(
                    color: yellowBg,
                    title: label.specialDay,
                  ),
                InfoWidget(
                  color: greenlightBg,
                  title: label.available,
                ),
                InfoWidget(
                  color: redBg,
                  title: label.ekadashi,
                ),
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
                minDate: today,
                maxDate: safeMaxDate,
                initialDate: safeInitialDate,
                startWeekWithSunday: true,
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
                    bgColor = greenlightBg;
                    textColor = blackTx;
                  } else if (unavailableSet.contains(key)) {
                    // Yekadashi → red (highest priority)
                    bgColor = redBg;
                    textColor = blackTx;
                  } else if (availableSet.contains(key)) {
                    // Ashlesha Nakshathra / Shudha Shasti (ids in available) → green
                    bgColor = yellowBg;

                    textColor = blackTx;
                  } else {
                    // Rest → light gray
                    // bgColor = Colors.transparent;
                    // textColor = grayTx;
                    bgColor = greenlightBg;
                    textColor = blackTx;
                  }
                  return GestureDetector(
                    onTap: () {
                      if (bgColor == redBg) {
                        showAlert(
                            QuickAlertType.custom,
                            context,
                            label.poojaNotAvailable,
                            label.pleaseSelectAnotherDate,
                            3,
                            label.okay,
                            null,
                            webLogo,
                            showBookButton);
                      } else if (bgColor == yellowBg) {
                        showAlert(
                            QuickAlertType.custom,
                            context,
                            label.specialPoojaDay,
                            label.ashleshaNakshatraSpecialPooja,
                            2,
                            label.bookNow,
                            url,
                            webLogo,
                            showBookButton);
                      } else if (bgColor == greenlightBg) {
                        showAlert(
                            QuickAlertType.custom,
                            context,
                            label.poojaAvailable,
                            label.youCanBookPooja,
                            1,
                            label.bookNow,
                            url,
                            webLogo,
                            showBookButton);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.transparent,
                      child: Column(
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
                      ),
                    ),
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
