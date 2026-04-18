import 'package:flutter/material.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/homescreen/presentation/widgets/widgets.dart';

import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      drawer: DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: customColors.mainColor,
        unselectedItemColor: customColors.blackAndWhite,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_mall_outlined), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: _onTap,
      ),
      body: navigationShell,
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(index,
        initialLocation: index == navigationShell.currentIndex);
  }
}
