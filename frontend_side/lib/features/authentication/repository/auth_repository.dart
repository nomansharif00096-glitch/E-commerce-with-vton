import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:frontend_side/core/network/dio_service.dart';
import 'package:frontend_side/core/network/error_handler.dart';
import 'package:frontend_side/features/authentication/authentication.dart';

class AuthRepository {
  final DioService dio;
  AuthRepository({required this.dio});
  Future<Either<Failure, bool>> register(SignupParams param) async {
    try {
      Response res =
          await dio.dioService().post("auth/signup", data: param.toJson());
      if (res.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(Failure(res.data.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(e.response?.data.toString() ?? ""));
    }
  }

  Future<Either<Failure, UserResponse>> login(Loginparam param) async {
    try {
      Response res =
          await dio.dioService().post("auth/login", data: param.toJson());
      if (res.statusCode == 201) {
        return Right(UserResponse.fromJson(res.data));
      } else {
        return Left(Failure(res.data.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(e.response?.data.toString() ?? ""));
    }
  }
}
