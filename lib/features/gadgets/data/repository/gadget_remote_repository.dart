import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/gadgets/data/data_source/remote/gadget_remote_data_source.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
import 'package:final_assignment/features/gadgets/domain/repository/i_gadget_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gadgetRemoteRepository = Provider<IGadgetRepository>((ref) {
  final gadgetRemoteDataSource = ref.watch(gadgetRemoteDataSourceProvider);
  return GadgetRemoteRepository(gadgetRemoteDataSource: gadgetRemoteDataSource);
});

class GadgetRemoteRepository implements IGadgetRepository {
  final GadgetRemoteDataSource gadgetRemoteDataSource;

  GadgetRemoteRepository({required this.gadgetRemoteDataSource});

  @override
  Future<Either<Failure, List<GadgetEntity>>> pagination(int page, int limit) {
    return gadgetRemoteDataSource.pagination(page: page, limit: limit);
  }
}
