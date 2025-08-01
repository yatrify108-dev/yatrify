import 'package:bookstay/features/screens/pg_details_view.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key, required this.about, required this.pgName});

  final String about;
  final String pgName;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text('${label.about} $pgName',style: context.style.titleMedium!.copyWith(fontSize: 20),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: about.isNotEmpty
              ? HtmlWidget(
                  about,
                  textStyle: context.style.titleMedium,
                  enableCaching: true,
                )
              : Center(
                  child: Text(
                  label.noData,
                  style: context.style.titleMedium,
                )),
        ),
      ),
    );
  }
}
