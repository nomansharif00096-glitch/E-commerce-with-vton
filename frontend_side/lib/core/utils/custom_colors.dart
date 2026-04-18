import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color mainColor;
  final Color blackAndWhite;
  final Color itemCard;

  CustomColors(
      {required this.mainColor,
      required this.blackAndWhite,
      required this.itemCard});

  @override
  CustomColors copyWith(
      {Color? mainColor, Color? blackAndWhite, Color? itemCard}) {
    return CustomColors(
        mainColor: mainColor ?? this.mainColor,
        blackAndWhite: blackAndWhite ?? this.blackAndWhite,
        itemCard: itemCard ?? this.itemCard);
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      mainColor: Color.lerp(mainColor, other.mainColor, t)!,
      blackAndWhite: Color.lerp(blackAndWhite, other.blackAndWhite, t)!,
      itemCard: Color.lerp(itemCard, other.itemCard, t)!,
    );
  }
}
