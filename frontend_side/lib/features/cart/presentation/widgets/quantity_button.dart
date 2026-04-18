import 'package:flutter/material.dart';
import 'package:frontend_side/core/utils/utils.dart';

class QuantityButton extends StatelessWidget {
  final VoidCallback tap;
  final String symbol;
  const QuantityButton({super.key, required this.tap, required this.symbol});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return InkWell(
      onTap: tap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.09,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: customColors.mainColor)),
        child: Center(
          child: Text(
            symbol,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: customColors.blackAndWhite),
          ),
        ),
      ),
    );
  }
}
