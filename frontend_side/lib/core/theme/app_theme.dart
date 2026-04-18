import 'package:flutter/material.dart';
import 'package:frontend_side/core/theme/theme_event.dart';
import 'package:frontend_side/core/utils/utils.dart';

final appThemeData = {
  AppTheme.light: ThemeData(extensions: [
    CustomColors(
        mainColor: Palette.mainColorLightMode,
        blackAndWhite: Palette.blackColor,
        itemCard: Palette.itemCardLightMode)
  ]),
  AppTheme.dark: ThemeData(brightness: Brightness.dark, extensions: [
    CustomColors(
        mainColor: Palette.mainColordarkMode,
        blackAndWhite: Palette.whiteColor,
        itemCard: Palette.itemCardDarkMode)
  ])
};
