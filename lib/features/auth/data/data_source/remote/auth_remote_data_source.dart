import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/users_shared_prefs.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    authApiModel: ref.watch(authApiModelProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({
    required this.userSharedPrefs,
    required this.dio,
    required this.authApiModel,
  });

  Future<Either<Failure, bool>> registerUser(AuthEntity authEntity) async {
    try {
      Response response = await dio.post(
        ApiEndPoints.registerUser,
        data: authApiModel.fromEntity(authEntity).toJson(),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(ApiEndPoints.loginUser,
          data: {'email': email, 'password': password});

      if (response.statusCode == 201) {
        final token = response.data['token'];
        print(token);
        await userSharedPrefs.setUserToken(token);

        return const Right(true);
      }

      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> verifyUser() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndPoints.verifyUser,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, AuthEntity>> getMe() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndPoints.getMe,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return Right(AuthApiModel.fromJson(response.data['user']).toEntity());
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> fingerPrintLogin(String id) async {
    try {
      Response response = await dio.post(
        ApiEndPoints.getToken,
        data: {'id': id},
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
  Future<Either<Failure, bool>> updateUser(AuthEntity updateUser) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      if (token == null) {
        return Left(
          Failure(
            error: 'No token found',
          ),
        );
      }

      Response response = await dio.put(
        ApiEndPoints.updateUser,
        data: authApiModel.fromEntity(updateUser).toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
