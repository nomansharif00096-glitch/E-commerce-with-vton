import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/theme/theme.dart';

class ToggleThemeSwitcher extends StatelessWidget {
  const ToggleThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final currentTheme = context.read<ThemeBloc>().state.themeData.brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            (currentTheme == Brightness.dark) ? 'Dark Mode' : 'Light Mode',
            style: TextStyle(fontSize: 20),
          ),
          GestureDetector(
            onTap: () {
              themeBloc.add(ChangeThemeEvent(currentTheme == Brightness.light
                  ? AppTheme.dark
                  : AppTheme.light));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 64,
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: (currentTheme == Brightness.dark)
                    ? const Color(0xFF183153)
                    : const Color(0xFF73C0FC),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Sun
                  Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedRotation(
                      duration: const Duration(seconds: 15),
                      turns: (currentTheme == Brightness.dark) ? 0 : 5,
                      child: const Icon(
                        Icons.wb_sunny,
                        color: Color(0xFFFFD43B),
                        size: 22,
                      ),
                    ),
                  ),
                  // Moon
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.dark_mode,
                      color: Color(0xFF73C0FC),
                      size: 22,
                    ),
                  ),
                  // Knob
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    alignment: (currentTheme == Brightness.dark)
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE8E8E8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
