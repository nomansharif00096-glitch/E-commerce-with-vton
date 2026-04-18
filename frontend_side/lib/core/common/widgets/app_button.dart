import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color? textColor;
  final Color? btnColor;
  final VoidCallback tap;
  final String btnTitle;
  const AppButton(
      {super.key,
      required this.btnTitle,
      required this.tap,
      this.textColor,
      this.btnColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 45,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: btnColor,
        ),
        child: Center(
          child: Text(
            btnTitle,
            style: TextStyle(fontSize: 18, color: textColor),
          ),
        ),
      ),
    );
  }
}
