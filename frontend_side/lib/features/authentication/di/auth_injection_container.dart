import 'package:frontend_side/core/di/injection_container.dart';
import 'package:frontend_side/features/authentication/authentication.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> authInjectionContainer() async {
  Hive.registerAdapter<UserData>(UserDataAdapter());
  await Hive.openBox<UserData>('user');
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepository(dio: locator()));
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerLazySingleton(
      () => AuthBloc(authRepository: locator(), authService: locator()));
}
