import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     // width: MediaQuery.of(context).size.width,
      //color: whiteColor,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          'My Location',
          style: context.style.titleMedium!
              .copyWith(color: kFontColor, fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text(
              'Kadekar, Udupi',
              style: context.style.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Icon(
              Icons.arrow_drop_down,
              size: 30,
            )
          ],
        ),
        trailing: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(16)),
            child: const Icon(
              Icons.person,
              size: 30,
            )),
      ),
    );
  }
}
