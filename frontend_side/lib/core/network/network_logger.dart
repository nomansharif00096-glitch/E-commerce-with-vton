import 'package:dio/dio.dart';
import 'package:frontend_side/core/network/logger.dart';

class Logging extends InterceptorsWrapper {
  Logging();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers["Accept"] = "Application/json";
    if (options.headers["Content-Type"] == "") {
      options.headers["Content-Type"] = "Application/json";
    }
    logger.i(
      '\x1B[34m📤 REQUEST[${options.method}] => '
      'PATH: ${options.baseUrl}${options.path}\n'
      'DATA: ${options.data}\n'
      'QUERY PARAMS: ${options.queryParameters}\n'
      'HEADERS: ${options.headers}\x1B[0m',
    );
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    logger.i(
      '\x1B[32m📥 RESPONSE[${response.statusCode}] => '
      'PATH: ${response.requestOptions.path}\n'
      'DATA: ${response.data}\x1B[0m',
    );
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    logger.e(
      '\x1B[31m❌ ERROR[${err.type}] => '
      'MESSAGE: ${err.message}\n'
      'PATH: ${err.requestOptions.path}\n'
      'RESPONSE: ${err.response}\x1B[0m',
    );
    return handler.next(err);
  }
}
