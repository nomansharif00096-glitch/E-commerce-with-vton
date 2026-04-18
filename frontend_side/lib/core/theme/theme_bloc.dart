import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/theme/theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: appThemeData[AppTheme.light]!)) {
    on<ChangeThemeEvent>((event, emit) {
      emit(ThemeState(themeData: appThemeData[event.appTheme]!));
    });
  }
}
