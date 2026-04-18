abstract class ThemeEvent {}

enum AppTheme { light, dark }

class ChangeThemeEvent extends ThemeEvent {
  final AppTheme appTheme;
  ChangeThemeEvent(this.appTheme);
}
