import 'package:flutter/material.dart';
import '../../utils/color.schemes.g.dart';

class GenderBadge extends StatelessWidget {
  const GenderBadge({super.key, required this.gender});

  final String gender;

  @override
  Widget build(BuildContext context) {
    final isFemale = gender.toLowerCase() == 'female';
    final isMale = gender.toLowerCase() == 'male';

    // final icon = isFemale ? "assets/icon/female.png" : isMale ? "assets/icon/male.png" : "assets/icon/male.png" "assets/icon/female.png";
    final fontColor = isFemale
        ? Colors.pink
        : isMale
            ? Colors.blue
            : Colors.black;
    final bgColor = isFemale
        ? Colors.pink[50]
        : isMale
            ? Colors.blue[50]
            : uniSexColor;

    return Container(
      padding: const EdgeInsets.all(4).copyWith(right: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (isFemale || isMale)
            Image.asset(
              isFemale ? "assets/icon/female.png" : "assets/icon/male.png",
              height: 20,
              width: 20,
              color: fontColor,
            )
          else ...[
            Image.asset(
              "assets/icon/male.png",
              height: 20,
              width: 20,
              color: fontColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Image.asset(
              "assets/icon/female.png",
              height: 20,
              width: 20,
              color: fontColor,
            )
          ],
          Text(
            gender,
            style: TextStyle(
              color: fontColor,
            ),
          ),
        ],
      ),
    );
  }
}
