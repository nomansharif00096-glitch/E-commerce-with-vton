import 'package:flutter/material.dart';
import 'package:frontend_side/core/utils/utils.dart';

class CheckoutButton extends StatelessWidget {
  final VoidCallback tap;
  const CheckoutButton({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return InkWell(
      onTap: tap,
      child: Container(
        height: 45,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: customColors.mainColor,
        ),
        child: Center(
          child: Text(
            'Check Out',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
