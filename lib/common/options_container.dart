import 'package:flutter/material.dart';

clickOptions(
    {required String name,
    required String image,
    required double width,
    required double height}) {
  return Column(
    children: [
      Container(
        height: height * 0.1,
        width: width * 0.2,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.33),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Image.asset(
            "assets/image/$image.png",
          ),
        ),
      ),
      const SizedBox(height: 5),
      Text(
        name,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
/**/
