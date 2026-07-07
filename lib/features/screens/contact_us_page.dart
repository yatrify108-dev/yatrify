import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({
    super.key,
    required this.contactUs,
  });

  final String contactUs;

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return regex.hasMatch(email);
  }

  Future<void> _sendMail() async {
    if (!_formKey.currentState!.validate()) return;
    final label = context.labels;

    final name = nameController.text.trim();
    // final email = emailController.text.trim();
    final message = messageController.text.trim();

    final subject = Uri.encodeComponent("Contact Us - Yatrify");
    final body =
        //Uri.encodeComponent("Name: $name\nEmail: $email\n\nMessage:\n$message");
        Uri.encodeComponent("Name: $name\n\nMessage:\n$message");
    final Uri emailUri =
        Uri.parse("mailto:${widget.contactUs}?subject=$subject&body=$body");

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
        
      } else {
        context.message(label.noEmailAppFound);
      }
    } catch (e) {
      context.message("${label.failedToOpenMail} $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.38,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: contactBarGradient,
                        begin: Alignment.topLeft,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: whiteColor,
                      size: 28,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.12,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: whiteColor.withOpacity(0.75),
                              blurRadius: 25,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.mail,
                          color: whiteColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        label.getInTouch,
                        style: context.style.titleMedium!
                            .copyWith(color: whiteColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 60),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildTextField(label.name, nameController,
                              validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return label.nameIsRequired;
                            }
                            return null;
                          }),
                          const SizedBox(height: 16),
                          // _buildTextField(
                          //   label.email,
                          //   emailController,
                          //   validator: (value) {
                          //     if (value == null || value.trim().isEmpty) {
                          //       return "Email is required";
                          //     }
                          //     if (!isValidEmail(value.trim())) {
                          //       return "Enter valid email";
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // const SizedBox(height: 16),
                          _buildTextField(
                            label.message,
                            messageController,
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return label.messageCannotBeEmpty;
                              }
                              if (value.trim().length < 5) {
                                return label.messageTooShort;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                nameController.clear();
                                messageController.clear();
                               // context.message(label.formCleared);
                              },
                              icon: const Icon(Icons.clear,color: primaryColor,),
                              label:  Text(label.clear, style: const TextStyle(color: primaryColor),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -20,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: whiteColor,
                              padding: const EdgeInsets.all(18),
                            ),
                            onPressed: () {
                              _sendMail();
                            },
                            icon: const Icon(Icons.send_sharp, size: 24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //path.lineTo(0, 0);

    path.lineTo(0, size.height - 30);

    path.quadraticBezierTo(
      size.width * 0.5,
      size.height + 30,
      size.width,
      size.height - 110,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
