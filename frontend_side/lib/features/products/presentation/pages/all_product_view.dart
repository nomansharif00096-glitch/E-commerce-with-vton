import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/common/widgets/widgets.dart';
import 'package:frontend_side/features/products/bloc/bloc.dart';
import 'package:frontend_side/features/products/models/model.dart';
import 'package:frontend_side/features/products/presentation/presentation.dart';

class AllHomeProductsView extends StatefulWidget {
  const AllHomeProductsView({super.key});

  @override
  State<AllHomeProductsView> createState() => _AllHomeProductsViewState();
}

class _AllHomeProductsViewState extends State<AllHomeProductsView> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(LoadingProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return SliverToBoxAdapter(
              child: Center(child: const AppLoadingIndicator()));
        } else if (state.products.isNotEmpty) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              final ProductModel product = state.products[index];
              return ProductCard(productModel: product);
            }, childCount: state.products.length),
          );
        } else if (state.products.isEmpty) {
          return SliverToBoxAdapter(
              child: NothingFound(title: "No Product Found"));
        }
        return Container();
      },
    );
  }
}
