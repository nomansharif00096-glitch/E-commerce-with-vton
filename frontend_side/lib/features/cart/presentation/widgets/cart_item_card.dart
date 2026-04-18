import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/cart/cart.dart';

class CartItemCard extends StatelessWidget {
  final int index;
  const CartItemCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final cartCubit = context.watch<CartCubit>();
    final item = cartCubit.state[index];
    return Container(
      padding: EdgeInsets.all(5),
      height: 105,
      decoration: BoxDecoration(
          color: customColors.itemCard,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            )
          ]),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.35,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/vectors/loading2.gif',
              image: item.image,
              height: 85,
              fit: BoxFit.cover,
              width: double.maxFinite,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/noImage.jpg',
                  height: 100,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                );
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.03,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.name.substring(0, 1).toUpperCase()}${item.name.substring(1)}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: customColors.blackAndWhite),
                    ),
                    InkWell(
                      onTap: () => cartCubit.removeItem(index),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        size: 25,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.18,
                      child: Text(
                        item.price.toString(),
                        style: TextStyle(color: customColors.blackAndWhite),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.03,
                    ),
                    QuantityButton(
                        tap: () {
                          if (item.quantity > 1) {
                            cartCubit.updateQuantity(
                                index, item.quantity - 1, item);
                          } else {
                            cartCubit.removeItem(index);
                          }
                        },
                        symbol: '-'),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.03,
                    ),
                    Text(
                      item.quantity.toString(),
                      style: TextStyle(color: customColors.blackAndWhite),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.03,
                    ),
                    QuantityButton(
                        tap: () {
                          cartCubit.updateQuantity(
                              index, item.quantity + 1, item);
                        },
                        symbol: '+'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
