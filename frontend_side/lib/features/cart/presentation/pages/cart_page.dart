import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/di/injection_container.dart';
import 'package:frontend_side/core/routes/app_routes.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/authentication/authentication.dart';
import 'package:frontend_side/features/cart/cart.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final cartCubit = context.watch<CartCubit>();
    // HANDLES CHECKOUT
    void handleCheckout() async {
      final authService = locator<AuthService>();
      final userInfo = await authService.getUserData();
      if (userInfo != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Your are Logged In")));
      } else {
        context.goNamed(AppRoutes.auth.name);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
              color: customColors.blackAndWhite, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => context.goNamed(AppRoutes.homeView.name),
          color: customColors.blackAndWhite,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart,
              color: customColors.blackAndWhite,
            ),
          )
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.4)),
        ),
        height: 110,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                      'Rs. ${cartCubit.calculateTotalPrice().toStringAsFixed(0)}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ],
              ),
              CheckoutButton(tap: handleCheckout),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BlocListener<CartCubit, List<CartItem>>(
          listener: (context, state) {
            if (cartCubit.state.isEmpty) {
              context.goNamed(AppRoutes.homeView.name);
            }
          },
          child: ListView.builder(
              itemCount: cartCubit.state.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 15),
                  child: CartItemCard(index: index),
                );
              }),
        ),
      ),
    );
  }
}
