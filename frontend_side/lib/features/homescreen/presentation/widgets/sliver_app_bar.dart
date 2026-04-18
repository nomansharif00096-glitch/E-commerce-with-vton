import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/routes/app_routes.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/cart/cubit/cart_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return SliverAppBar(
      pinned: true,
      expandedHeight: 50.0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Discover',
              style: GoogleFonts.eduNswActFoundation(
                  fontSize: 26, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () => cartCubit.state.isEmpty
                  ? null
                  : context.goNamed(AppRoutes.cartView.name),
              child: badges.Badge(
                  badgeStyle:
                      badges.BadgeStyle(badgeColor: customColors.mainColor),
                  badgeContent: Text(
                    cartCubit.getTotalItemsInCart().toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: customColors.blackAndWhite,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
