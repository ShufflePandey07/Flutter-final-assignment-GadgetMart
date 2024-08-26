import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'Something went wrong';

    if (err.response != null) {
      // Handle server errors
      if (err.response!.statusCode! >= 300) {
        errorMessage = err.response!.data['message'] ??
            err.response!.statusMessage ??
            errorMessage;
      }
    } else {
      // Handle connection errors
      errorMessage = 'Connection error';
    }

    DioException dioException = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: errorMessage,
      type: err.type,
    );

    super.onError(dioException, handler);
  }
}
