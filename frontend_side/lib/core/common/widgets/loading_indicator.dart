import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend_side/core/utils/utils.dart';

class AppLoadingIndicator extends StatelessWidget {
  final bool horizontal;
  final double size;
  const AppLoadingIndicator(
      {super.key, this.horizontal = false, this.size = 110});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return horizontal
        ? SpinKitThreeBounce(
            size: 45,
            color: customColors.mainColor,
          )
        : SpinKitRipple(
            size: size,
            color: customColors.mainColor,
          );
  }
}
