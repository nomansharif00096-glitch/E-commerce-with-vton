import 'package:frontend_side/core/di/injection_container.dart';

import 'package:frontend_side/features/products/products.dart';

import '../bloc/bloc.dart';

Future<void> productInjectionContainer() async {
  locator.registerLazySingleton(() => ProductRepository(dio: locator()));
  locator.registerLazySingleton(() => CategoryRepository(dio: locator()));
  locator.registerFactory(() =>
      ProductBloc(productRepository: locator(), categoryRepository: locator()));
}
