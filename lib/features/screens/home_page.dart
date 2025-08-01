import 'package:bookstay/core/models/pg.dart';
import 'package:bookstay/features/providers/router_provider.dart';
import 'package:bookstay/features/screens/pg_details_view.dart';
import 'package:bookstay/features/screens/responsive.dart';
import 'package:bookstay/features/widgets/banner_carousel.dart';
import 'package:bookstay/features/widgets/header_section.dart';
import 'package:bookstay/features/widgets/hover_to_expand.dart';
import 'package:bookstay/features/widgets/pg_mobile_card.dart';
import 'package:bookstay/features/widgets/pg_web_card.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getResponsiveHorizontalPadding(context)),
          child: Column(
            children: [
              const HeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (pgData.banners != null &&
                          pgData.banners!.isNotEmpty) ...[
                        const SizedBox(
                          height: 16,
                        ),
                        BannerCarousel(banners: pgData.banners!),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      Responsive.isMobile(context)
                          ? _buildMobileCards(context)
                          : _buildWebCards(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMobileCards(BuildContext context) {
  return Column(
    children: [
      ...pgData.pgDetails.map((pg) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: GestureDetector(
              onTap: (){
                context.push('/pg-details',extra: pg);
              },
              child: PgMobileCard(pgDetails: pg),
            ),
          )),
    ],
  );
}

Widget _buildWebCards(BuildContext context) {
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
                    ...pgData.pgDetails.map(
                      (pg) => GestureDetector(
                        onTap: (){
                          context.push('/pg-details',extra: pg);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: PgWebCard(
                            pgDetails: pg,
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
                        const SizedBox(height: 4,),
                        Text('Explore Nearby Places', style: context.style.titleLarge,),
                        const SizedBox(height: 16,),
                       const Expanded(child:  HoverToExpand()),
                      ],
                    )
                  ),
                )
              ],
            ],
          ),
        ),
      );
    },
  );
}
