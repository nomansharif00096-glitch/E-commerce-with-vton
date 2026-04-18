import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:frontend_side/core/network/dio_service.dart';
import 'package:frontend_side/core/network/error_handler.dart';
import 'package:frontend_side/features/products/models/model.dart';

class CategoryRepository {
  final DioService dio;
  CategoryRepository({required this.dio});
  // Fetching Categories of Product
  // Returns the List of categories
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      Response res = await dio.dioService().get('category');
      if (res.statusCode == 200 && res.data != null) {
        List categories = res.data;
        if (categories.isNotEmpty) {
          return Right(categories
              .map((toElement) => CategoryModel.fromJson(toElement))
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
