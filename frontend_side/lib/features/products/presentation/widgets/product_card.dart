import 'package:flutter/material.dart';
import 'package:frontend_side/core/common/widgets/widgets.dart';
import 'package:frontend_side/core/routes/app_routes.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/products/models/model.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return InkWell(
      onTap: () => context.goNamed(AppRoutes.productDetail.name,
          queryParameters: {'id': productModel.id.toString()}),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height * 0.2),
            child: ImageWrapper(
              image: (productModel.images?.isNotEmpty ?? false)
                  ? productModel.images!.first.url
                  : 'assets/images/noImage.jpg',
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '${productModel.name.substring(0, 1).toUpperCase()}${productModel.name.substring(1)}',
            style: TextStyle(
                color: customColors.blackAndWhite,
                fontWeight: FontWeight.w800,
                letterSpacing: 1),
          ),
          Text(
            'Stock: ${productModel.stock}',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                'Rs.',
                style: GoogleFonts.mogra(
                    color: customColors.mainColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              Text(
                productModel.price,
                style: GoogleFonts.mogra(
                    color: customColors.mainColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
