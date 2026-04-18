import 'package:frontend_side/core/di/injection_container.dart';
import 'package:frontend_side/features/cart/cart.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> cartInjectionContainer() async {
  Hive.registerAdapter<CartItem>(CartItemAdapter());
  await Hive.openBox<CartItem>('cart');

  locator.registerLazySingleton(CartService.new);
  locator.registerFactory<CartCubit>(
      () => CartCubit(cartService: locator<CartService>()));
}
