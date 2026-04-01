import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/widgets/app_button.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    this.privacyPolicy,
    this.termsAndCondition,
    this.password,
    this.contactUs,
  });

  final String? privacyPolicy;
  final String? termsAndCondition;
  final String? password;
  final String? contactUs;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
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
        title: Text(label.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (contactUs != null && contactUs!.isNotEmpty) ...[
              GestureDetector(
                onTap: () {
                  context.push('/contact-us', extra: contactUs);
                },
                child: SettingsWidget(
                  icon: Icons.contact_page_rounded,
                  title: label.contactUs,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
            GestureDetector(
              onTap: () {
                showLanguageDialog(context);
              },
              child: SettingsWidget(
                icon: Icons.language,
                title: label.appLanguage,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                if (privacyPolicy != null && privacyPolicy!.isNotEmpty) {
                  launchUrlLink(privacyPolicy!);
                }
              },
              child: SettingsWidget(
                icon: Icons.privacy_tip,
                title: label.privacyPolicy,
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
              child: SettingsWidget(
                icon: Icons.text_snippet,
                title: label.termsAndConditions,
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
                    String versionTest = label.loading;
                    if (snapshot.hasData) {
                      final info = snapshot.data!;
                      versionTest = '${label.appVersion} - ${info.version}';
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

void showLanguageDialog(BuildContext context) {
  final ValueNotifier<String> selectedLang =
      ValueNotifier(LocaleService.localeNotifier.value.languageCode);
  final label = context.labels;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ValueListenableBuilder<String>(
            valueListenable: selectedLang,
            builder: (context, value, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label.selectAppLanguage,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),

                  const SizedBox(height: 12),

                  RadioTheme(
                    data: RadioThemeData(
                      fillColor:
                          WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.selected)) {
                          return primaryColor; // selected
                        }
                        return Colors.grey; // unselected
                      }),
                    ),
                    child: RadioGroup<String>(
                      groupValue: value,
                      onChanged: (val) {
                        if (val != null) selectedLang.value = val;
                      },
                      child: const Column(
                        children: [
                          RadioListTile(
                            radioScaleFactor: 1.2,
                            value: 'en',
                            title: Text(
                              'English',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          RadioListTile(
                            radioScaleFactor: 1.2,
                            value: 'kn',
                            title: Text(
                              'ಕನ್ನಡ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: label.apply,
                      onPressed: () {
                        LocaleService.setLocale(selectedLang.value);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

void showDebugDialog(BuildContext context, String password) {
  final TextEditingController controller = TextEditingController();
  final label = context.labels;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(label.debug, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label.pleaseEnterPassword, textAlign: TextAlign.center),
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
          child: Text(
            label.cancel,
            style: const TextStyle(color: primaryColor),
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
                          label.developerMode,
                          style:
                              context.style.titleMedium!.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              label.debugMode,
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
              context.message(label.wrongPassword);
              controller.clear();
            }
          },
          child: Text(
            label.ok,
            style: const TextStyle(color: primaryColor),
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
