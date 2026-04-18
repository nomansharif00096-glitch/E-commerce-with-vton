import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/common/widgets/widgets.dart';
import 'package:frontend_side/core/routes/app_routes.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/products/bloc/bloc.dart';
import 'package:frontend_side/features/products/models/model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCategoriesView extends StatefulWidget {
  const HomeCategoriesView({super.key});

  @override
  State<HomeCategoriesView> createState() => _HomeCategoriesViewState();
}

class _HomeCategoriesViewState extends State<HomeCategoriesView> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(LoadingCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'All Categories',
                style: GoogleFonts.creteRound(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 115,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state.status == ProductStatus.loading) {
                    return const AppLoadingIndicator(
                      horizontal: true,
                    );
                  } else if (state.categories.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final CategoryModel categoryModel =
                            state.categories[index];
                        return InkWell(
                          onTap: () => context.goNamed(
                              AppRoutes.productsBasedOnCategory.name,
                              extra: categoryModel),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(children: [
                              CircleAvatar(
                                backgroundColor: Palette.blackColor,
                                maxRadius: 30,
                                backgroundImage:
                                    AssetImage('assets/icons/icon$index.png'),
                              ),
                              Chip(
                                  label: Text(
                                categoryModel.name,
                              ))
                            ]),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
