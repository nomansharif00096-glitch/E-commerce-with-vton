import 'package:dio/dio.dart';
import 'package:frontend_side/core/network/network_logger.dart';

class DioService {
  Dio dioService() {
    Dio dio = Dio();
    dio.options.baseUrl = "http://10.253.96.9:3002/";
    dio.interceptors.add(Logging());
    dio.options.headers = {"Content-Type": "application/json"};
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    return dio;
  }
}
