import 'package:flutter/material.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/homescreen/presentation/widgets/widgets.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: customColors.mainColor,
              ),
              child: Center(
                child: Text(
                  "Menu",
                  style: TextStyle(
                      color: customColors.blackAndWhite,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          ToggleThemeSwitcher(),
          Divider()
        ],
      ),
    );
  }
}
