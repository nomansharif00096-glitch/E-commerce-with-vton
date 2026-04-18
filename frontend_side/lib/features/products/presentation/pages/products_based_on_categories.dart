import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/common/widgets/widgets.dart';
import 'package:frontend_side/core/routes/app_routes.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/products/bloc/bloc.dart';
import 'package:frontend_side/features/products/models/model.dart';
import 'package:frontend_side/features/products/presentation/presentation.dart';

import 'package:go_router/go_router.dart';

class ProductsBasedOnCategories extends StatefulWidget {
  final CategoryModel categoryModel;
  const ProductsBasedOnCategories({
    super.key,
    required this.categoryModel,
  });

  @override
  State<ProductsBasedOnCategories> createState() =>
      _ProductsBasedOnCategoriesState();
}

class _ProductsBasedOnCategoriesState extends State<ProductsBasedOnCategories> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context)
        .add(LoadProductsByCategory(categoryId: widget.categoryModel.id));
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () =>
              context.pushReplacementNamed(AppRoutes.homeView.name),
          color: customColors.blackAndWhite,
        ),
        title: Text(
          widget.categoryModel.name,
          style: TextStyle(color: customColors.blackAndWhite),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state.status == ProductStatus.loading) {
            return const AppLoadingIndicator();
          } else if (state.categoriesProducts.isNotEmpty) {
            return GridView.builder(
                itemCount: state.categoriesProducts.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 3.0,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final ProductModel product = state.categoriesProducts[index];
                  return ProductCard(productModel: product);
                });
          }
          return Center(child: NothingFound(title: "No Product Found"));
        }),
      ),
    );
  }
}
