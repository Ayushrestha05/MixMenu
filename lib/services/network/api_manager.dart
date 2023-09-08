import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiManager {

  ApiManager() {

    final options = BaseOptions(
      baseUrl: "",
      validateStatus: (status) {
        return status! < 500;
      },
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      contentType: Headers.jsonContentType,
      headers: {
        "Accept": "application/json",
      },
    );

    dio = Dio(options);


    // if any error occurred, display error with response
    dio!.interceptors.add(
      PrettyDioLogger(
        requestHeader: false,
        responseBody: false,
        requestBody: false,
        responseHeader: false,
        compact: false,
      ),
    );
  }

  final Duration _connectTimeout = Duration(minutes: 2);
  final Duration _receiveTimeout = Duration(minutes: 3);

  Dio? dio;
}
