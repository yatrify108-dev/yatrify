import 'package:yatrify/core/models/home_stay.dart';
import 'package:yatrify/core/services/fetch_data.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/features/screens/responsive.dart';
import 'package:yatrify/features/widgets/header_section.dart';
import 'package:yatrify/features/widgets/home_stay_shimmer_card.dart';
import 'package:yatrify/features/widgets/hover_to_expand.dart';
import 'package:yatrify/features/widgets/pg_mobile_card.dart';
import 'package:yatrify/features/widgets/pg_web_card.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeStayHomePage extends StatefulWidget {
  const HomeStayHomePage({super.key});

  @override
  State<HomeStayHomePage> createState() => _HomeStayHomePageState();
}

class _HomeStayHomePageState extends State<HomeStayHomePage> {
  @override
  void initState() {
    super.initState();

    FirebaseManager().logLandedOnListing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ValueListenableBuilder<bool>(
        valueListenable: FirebaseManagerService.isDevelopment,
        builder: (context, isDev, _) {
          return FutureBuilder<HomeStay>(
            key: ValueKey(isDev),
            future: fetchHomeStayData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const HomeStayShimmerList();
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final homeStayData = snapshot.data!;

              return _buildContent(context, homeStayData);
            },
          );
        },
      ),
    );
  }
}

Widget _buildContent(BuildContext context, HomeStay homeStayData) {
  return Scaffold(
    appBar: AppBar(
      // backgroundColor: primaryColor,
      forceMaterialTransparency: true,
      title: Text(homeStayData.headerText),
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        children: [
          // const HeaderSection(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (homeStayData.banners != null &&
                      homeStayData.banners!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    // BannerCarousel(banners: pgData.banners!),
                  ],
                  //const SizedBox(height: 20),
                  Responsive.isMobile(context)
                      ? _buildMobileCards(context, homeStayData)
                      : _buildWebCards(context, homeStayData),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMobileCards(BuildContext context, HomeStay homeStayData) {
  return Column(
    children: [
      ...homeStayData.homeStayDetails.map((homeStay) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: GestureDetector(
              onTap: () {
                FirebaseManager().logStaySelected(
                  hotelName: homeStay.address.first.homeStayName,
                  hotelContactNumber: homeStay.address.first.phoneNo,
                );
                context.push('/home-stay-details', extra: homeStay);
              },
              child: HomeStayMobileCard(homeStayDetails: homeStay),
            ),
          )),
    ],
  );
}

Widget _buildWebCards(BuildContext context, HomeStay homeStayData) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return ConstrainedBox(
        constraints:
            const BoxConstraints(minHeight: 0, maxHeight: double.infinity),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    ...homeStayData.homeStayDetails.map(
                      (homeStay) => GestureDetector(
                        onTap: () {
                          context.push('/home-stay-details', extra: homeStay);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: PgWebCard(
                            homeStayDetails: homeStay,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (Responsive.isDesktop(context)) ...[
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Explore Nearby Places',
                            style: context.style.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          //const Expanded(child: HoverToExpand()),
                        ],
                      )),
                )
              ],
            ],
          ),
        ),
      );
    },
  );
}
