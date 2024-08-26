import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/users_shared_prefs.dart';
import 'package:final_assignment/features/gadgets/data/dto/pagination_dto.dart';
import 'package:final_assignment/features/gadgets/data/model/gadget_api_model.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gadgetRemoteDataSourceProvider = Provider<GadgetRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final gadgetApiModel = ref.watch(gadgetApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return GadgetRemoteDataSource(
    dio: dio,
    gadgetApiModel: gadgetApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class GadgetRemoteDataSource {
  final Dio dio;
  final GadgetApiModel gadgetApiModel;
  final UserSharedPrefs userSharedPrefs;

  GadgetRemoteDataSource({
    required this.dio,
    required this.gadgetApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<GadgetEntity>>> pagination(
      {required int page, required int limit}) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold((l) => {token = null}, (r) => token = r);
      final response = await dio.get(
        ApiEndPoints.pagination,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        final paginationDto = PaginationDto.fromJson(response.data);
        return Right(gadgetApiModel.toEntityList(paginationDto.products));
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}
