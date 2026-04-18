import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/common/widgets/widgets.dart';
import 'package:frontend_side/core/routes/app_routes.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/cart/cart.dart';
import 'package:frontend_side/features/products/bloc/bloc.dart';
import 'package:frontend_side/features/products/models/model.dart';
import 'package:frontend_side/features/products/presentation/presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductDetails extends StatefulWidget {
  final String id;
  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  CartCubit get cubit => BlocProvider.of<CartCubit>(context);
  bool added = false;
  void checkCart() {
    var found =
        cubit.state.any((element) => element.productId == int.parse(widget.id));
    if (found) {
      setState(() {
        added = true;
      });
    } else {
      setState(() {
        added = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkCart();
    BlocProvider.of<ProductBloc>(context)
        .add(LoadingProduct(id: int.parse(widget.id)));
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    final cartCubit = context.read<CartCubit>();
    final ProductModel? product =
        context.select((ProductBloc bloc) => bloc.state.product);
    void submitToCart() {
      if (product != null) {
        var cartData = CartItem(
            productId: product.id,
            name: product.name,
            price: double.parse(product.price),
            image: (product.images != null && product.images!.isNotEmpty)
                ? product.images!.first.url
                : 'assets/images/noImage.jpg',
            quantity: 1);
        cartCubit.addToCart(cartData);
        setState(() {
          added = true;
        });

        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "${product.name} added to cart",
            backgroundColor: customColors.mainColor,
            textStyle: TextStyle(
                color: Palette.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            icon: SizedBox.shrink(),
          ),
          displayDuration: Duration(seconds: 1),
        );
      }
    }

    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        height: 70,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocSelector<ProductBloc, ProductState, String?>(
                selector: (state) {
                  return state.product?.price ?? "";
                },
                builder: (context, state) {
                  return Text(
                    'Rs.$state',
                    style: TextStyle(
                      color: customColors.blackAndWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: AppButton(
                    btnColor: !added ? customColors.mainColor : Colors.grey,
                    textColor: !added ? Colors.white : Colors.black,
                    tap: () => !added ? submitToCart() : null,
                    btnTitle: !added ? 'Add to cart' : 'added'),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loading) {
            return Center(child: const AppLoadingIndicator());
          } else if (state.status == ProductStatus.failure) {
            return const Center(child: NothingFound(title: 'No Product Found'));
          } else if (state.product != null) {
            final ProductModel product = state.product!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  floating: true,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Palette.blackColor, shape: BoxShape.circle),
                      child: BackButton(
                        onPressed: () =>
                            context.goNamed(AppRoutes.homeView.name),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black38))),
                    child: FlexibleSpaceBar(
                      background: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return buildProductImage(product.images![index].url);
                        },
                        itemCount: product.images?.length ?? 0,
                        loop: false,
                        pagination: SwiperPagination(
                            margin: const EdgeInsets.all(0.0),
                            builder: SwiperCustomPagination(builder:
                                (BuildContext context,
                                    SwiperPluginConfig config) {
                              return ConstrainedBox(
                                  constraints:
                                      BoxConstraints.expand(height: 25),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "${config.activeIndex + 1}/${config.itemCount}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: customColors.mainColor),
                                    ),
                                  ));
                            })),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 14,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Product',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: customColors.blackAndWhite),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 14,
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${product.name.substring(0, 1).toUpperCase()}${product.name.substring(1)}',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: customColors.blackAndWhite),
                  ),
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 14,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: customColors.blackAndWhite),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 14,
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${product.description.substring(0, 1).toUpperCase()}${product.description.substring(1)}',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: customColors.blackAndWhite),
                  ),
                )),
              ],
            );
          }
          return Container();
        },
      )),
    );
  }
}
