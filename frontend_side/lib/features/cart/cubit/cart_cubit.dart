import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/features/cart/cart.dart';

class CartCubit extends Cubit<List<CartItem>> {
  final CartService cartService;
  CartCubit({required this.cartService}) : super([]);

  void addToCart(CartItem item) {
    cartService.saveCart(item).then((_) {
      cartService.getAllCarts().then((value) {
        final newState = List<CartItem>.from(value);
        emit(newState);
      });
    });
  }

  void readAllCarts() {
    cartService.getAllCarts().then((value) {
      if (value.isNotEmpty) {
        emit(value);
      }
    });
  }

  int getTotalItemsInCart() {
    int totalItems = 0;
    // ignore:unused_local_variable
    for (final item in state) {
      totalItems++;
    }
    return totalItems;
  }

  void updateQuantity(int index, int newQuantity, CartItem item) {
    final newState = List<CartItem>.from(state);
    newState[index].quantity = newQuantity;
    emit(newState);
    var cartItem =
        newState.firstWhere((element) => element.productId == item.productId);
    cartService.updateCartItem(cartItem);
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (final item in state) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  void removeItem(int index) {
    cartService.getAllCarts().then((value) {
      final newState = List<CartItem>.from(value);
      newState.removeAt(index);
      cartService.deleteCartItem(index);
      emit(newState);
    });
  }

  void clearCart() {
    cartService.deleteAllCarts();
  }
}
