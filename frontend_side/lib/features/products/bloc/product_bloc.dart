import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/features/products/repository/repository.dart';

import './bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  ProductBloc({
    required this.productRepository,
    required this.categoryRepository,
  }) : super(const ProductState()) {
    on<LoadingProducts>(onGetProducts);
    on<LoadingProduct>(onGetProduct);
    on<LoadingCategories>(onGetCategories);
    on<LoadProductsByCategory>(onGetProductsByCategories);
  }
  Future<void> onGetProducts(
    LoadingProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading, products: []));
    try {
      final res = await productRepository.fetchAllProducts();
      res.fold((ifLeft) {
        emit(state.copyWith(
            error: ifLeft.message, status: ProductStatus.failure));
      }, (ifRight) {
        emit(state.copyWith(products: ifRight, status: ProductStatus.success));
      });
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.failure, error: e.toString()));
    }
  }

  Future<void> onGetProduct(
    LoadingProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading, product: null));
    try {
      final res = await productRepository.fetchSingleProduct(event.id);
      res.fold((ifLeft) {
        emit(state.copyWith(
            error: ifLeft.message, status: ProductStatus.failure));
      }, (ifRight) {
        emit(state.copyWith(product: ifRight, status: ProductStatus.success));
      });
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.failure, error: e.toString()));
    }
  }

  Future<void> onGetCategories(
    LoadingCategories event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading, categories: []));
    try {
      final res = await categoryRepository.fetchCategories();
      res.fold((ifLeft) {
        emit(state.copyWith(
            error: ifLeft.message, status: ProductStatus.failure));
      }, (ifRight) {
        emit(
            state.copyWith(categories: ifRight, status: ProductStatus.success));
      });
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.failure, error: e.toString()));
    }
  }

  Future<void> onGetProductsByCategories(
    LoadProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading, categoriesProducts: []));
    try {
      final res = await productRepository.fetchAllProductsBasedOnCategory(
        event.categoryId,
      );
      res.fold((ifLeft) {
        emit(state.copyWith(
            error: ifLeft.message, status: ProductStatus.failure));
      }, (ifRight) {
        emit(state.copyWith(
            categoriesProducts: ifRight, status: ProductStatus.success));
      });
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.failure, error: e.toString()));
    }
  }
}
