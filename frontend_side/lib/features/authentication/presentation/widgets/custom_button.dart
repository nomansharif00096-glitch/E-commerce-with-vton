import 'package:flutter/material.dart';
import 'package:frontend_side/core/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback tap;
  final double height;
  final double width;
  final Color textColor;
  final double fontSize;
  const CustomButton(
      {super.key,
      required this.text,
      required this.tap,
      required this.height,
      required this.textColor,
      required this.fontSize,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Palette.mainColorLightMode,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
