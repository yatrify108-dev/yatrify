import 'package:bookstay/features/widgets/redirect_widget.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class RedirectPage extends StatefulWidget {
  final String url;
  const RedirectPage({super.key, required this.url});

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    final uri = Uri.parse(widget.url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not launch ${widget.url}")),
        );
      }
    }

    // Close redirect screen after launching
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      //   elevation: 0,
      // ),
      body: 
      
       RedirectWidget(
          icon: Icons.open_in_browser,
          title: label.openingWebsite,
          subtitle: label.redirectingToWebsite,
        ),
    );
  }
}

