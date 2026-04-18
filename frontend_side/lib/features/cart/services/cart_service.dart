import 'package:frontend_side/features/cart/cart.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartService {
  Future<CartItem> saveCart(CartItem cart) async {
    Box<CartItem> cartbox = Hive.box<CartItem>('cart');
    await cartbox.add(cart);
    cart.save();
    return cart;
  }

  Future<List<CartItem>> getAllCarts() async {
    Box<CartItem> cartbox = Hive.box<CartItem>('cart');
    List<CartItem> cartModelList = cartbox.values.toList();
    return cartModelList;
  }

  Future<void> updateCartItem(CartItem cart) async {
    Box<CartItem> cartbox = Hive.box<CartItem>('cart');
    cartbox.put(cart.key, cart);
    cart.save();
  }

  Future<void> deleteCartItem(int index) async {
    Box<CartItem> cartbox = Hive.box<CartItem>('cart');
    cartbox.deleteAt(index);
  }

  Future<void> deleteAllCarts() async {
    Box<CartItem> cartbox = Hive.box<CartItem>('cart');
    cartbox.clear();
  }
}
