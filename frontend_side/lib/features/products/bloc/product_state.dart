import 'package:equatable/equatable.dart';
import 'package:frontend_side/features/products/models/model.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductModel> products;
  final ProductModel? product;
  final List<CategoryModel> categories;
  final List<ProductModel> categoriesProducts;
  final String? error;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.product,
    this.categories = const [],
    this.categoriesProducts = const [],
    this.error,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<ProductModel>? products,
    ProductModel? product,
    List<CategoryModel>? categories,
    List<ProductModel>? categoriesProducts,
    String? error,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      product: product ?? this.product,
      categories: categories ?? this.categories,
      categoriesProducts: categoriesProducts ?? this.categoriesProducts,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        product,
        categories,
        categoriesProducts,
        error,
      ];
}
