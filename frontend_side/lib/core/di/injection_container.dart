import 'package:frontend_side/core/network/dio_service.dart';
import 'package:frontend_side/core/network/logger.dart';
import 'package:frontend_side/core/network/network_logger.dart';
import 'package:frontend_side/core/routes/app_router.dart';
import 'package:frontend_side/core/theme/theme_bloc.dart';
import 'package:frontend_side/features/authentication/authentication.dart';
import 'package:frontend_side/features/cart/di/cart_inection_container.dart';
import 'package:frontend_side/features/products/products.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

final locator = GetIt.instance;
Future<void> init() async {
  // HIVE
  await Hive.initFlutter();
  // ROUTER
  locator.registerLazySingleton(() => AppRouter());
  // NETWORK
  locator.registerSingleton(Dio());
  locator.registerSingleton(DioService());
  locator.registerSingleton(logger);
  locator.registerSingleton(Logging());
  // PRODUCT INJECTION
  await productInjectionContainer();
  // CART INJECTION
  await cartInjectionContainer();
  // THEME
  locator.registerSingleton(ThemeBloc());
  // AUTHENTICATION
  await authInjectionContainer();
}
