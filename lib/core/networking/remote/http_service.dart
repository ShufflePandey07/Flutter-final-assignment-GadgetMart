import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_error_interceptor.dart';

final httpServiceProvider = Provider<Dio>(
  (ref) => HttpService(Dio()).dio,
);

class HttpService {
  final Dio _dio;

  Dio get dio => _dio;

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndPoints.baseUrl
      ..options.connectTimeout = ApiEndPoints.connectionTimeout
      ..options.receiveTimeout = ApiEndPoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }
}
