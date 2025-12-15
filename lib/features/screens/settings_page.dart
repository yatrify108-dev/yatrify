import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage(
      {super.key, this.privacyPolicy, this.termsAndCondition, this.password});

  final String? privacyPolicy;
  final String? termsAndCondition;
  final String? password;

  @override
  Widget build(BuildContext context) {
    Future<void> launchUrlLink(String url) async {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    int tapCount = 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (privacyPolicy != null && privacyPolicy!.isNotEmpty) {
                  launchUrlLink(privacyPolicy!);
                }
              },
              child: const SettingsWidget(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                if (termsAndCondition != null &&
                    termsAndCondition!.isNotEmpty) {
                  launchUrlLink(termsAndCondition!);
                }
              },
              child: const SettingsWidget(
                icon: Icons.text_snippet,
                title: 'Terms and Conditions',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                tapCount++;
                if (tapCount == 10 && password!.isNotEmpty) {
                  tapCount = 0;
                  showDebugDialog(context, password!);
                }
              },
              child: FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    String versionTest = 'Loading...';
                    if (snapshot.hasData) {
                      final info = snapshot.data!;
                      versionTest = 'App Version - ${info.version}';
                    }
                    return SettingsWidget(
                      icon: Icons.system_update,
                      title: versionTest,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

void showDebugDialog(BuildContext context, String password) {
  final TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Debug', textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Please enter password to enter debug mode.",
              textAlign: TextAlign.center),
          const SizedBox(
            height: 10,
          ),
          TextField(
            cursorColor: primaryColor,
            controller: controller,
           // obscureText: true,
            //  textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text(
            "CANCEL",
            style: TextStyle(color: primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            if (controller.text == password) {
              context.pop();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                // shape: const RoundedRectangleBorder(
                //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                // ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Center(
                        //   child: Container(
                        //     width: 40,
                        //     height: 4,
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey.shade400,
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                        Text(
                          "Developer Mode",
                          style:
                              context.style.titleMedium!.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Debug Mode",
                              style: context.style.bodyLarge,
                            ),
                            ValueListenableBuilder(
                              valueListenable:
                                  FirebaseManagerService.isDevelopment,
                              builder: (context, value, _) {
                                return SwitchTheme(
                                  data: const SwitchThemeData(
                                    trackOutlineColor: WidgetStatePropertyAll(
                                        Colors.transparent),
                                  ),
                                  child: Switch(
                                    value: value,
                                    activeThumbColor: Colors.green,
                                    inactiveThumbColor: Colors.grey,
                                    onChanged: (newValue) {
                                      FirebaseManagerService
                                          .isDevelopment.value = newValue;
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              );
            } else {
              context.message("Wrong password");
              controller.clear();
            }
          },
          child: const Text(
            "OK",
            style: TextStyle(color: primaryColor),
          ),
        ),
      ],
    ),
  );
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.2),
                // borderRadius: BorderRadius.circular(8),
                shape: BoxShape.circle),
            child: Icon(
              icon,
              color: primaryColor,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: context.style.titleMedium!.copyWith(fontSize: 18),
          )
        ],
      ),
    );
  }
}
