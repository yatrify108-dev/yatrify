import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key, required this.about, required this.homeStayName});

  final String about;
  final String homeStayName;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text('${label.about} $homeStayName',style: context.style.titleMedium!.copyWith(fontSize: 20),),
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
