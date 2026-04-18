import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:frontend_side/core/network/dio_service.dart';
import 'package:frontend_side/core/network/error_handler.dart';
import 'package:frontend_side/features/products/models/model.dart';

class ProductRepository {
  final DioService dio;
  ProductRepository({required this.dio});

  // Fetching All Products
  // Returns the List of products
  Future<Either<Failure, List<ProductModel>>> fetchAllProducts() async {
    try {
      Response res = await dio.dioService().get('products');
      if (res.statusCode == 200 && res.data != null) {
        List products = res.data;
        if (products.isNotEmpty) {
          return Right(products
              .map((toElement) => ProductModel.fromJson(toElement))
              .toList());
        } else {
          return Right([]);
        }
      } else {
        return Left(Failure(res.data.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(e.response?.data.toString() ?? ""));
    }
  }

  // Returns a single Product
  Future<Either<Failure, ProductModel>> fetchSingleProduct(int id) async {
    try {
      Response res = await dio.dioService().get('products/$id');
      if (res.statusCode == 200 && res.data != null) {
        var product = res.data;
        return Right(ProductModel.fromJson(product));
      } else {
        return Left(Failure(res.data.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(e.response?.data.toString() ?? ""));
    }
  }

  // Fetch all Products based on Categories
  Future<Either<Failure, List<ProductModel>>> fetchAllProductsBasedOnCategory(
      int id) async {
    try {
      Response res = await dio.dioService().get('products/category/$id');
      if (res.statusCode == 200 && res.data != null) {
        List products = res.data;
        if (products.isNotEmpty) {
          return Right(products
              .map((toElement) => ProductModel.fromJson(toElement))
              .toList());
        } else {
          return Right([]);
        }
      } else {
        return Left(Failure(res.data.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(e.response?.data.toString() ?? ""));
    }
  }
}
