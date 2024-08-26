import 'package:dartz/dartz.dart';
// import 'package:final_assignment/core/common/provider/internet_connectivity.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/gadgets/data/repository/gadget_remote_repository.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gadgetRepositoryProvider =
    Provider<IGadgetRepository>((ref) => ref.read(gadgetRemoteRepository));

// final gadgetRepositoryProvider = Provider<IGadgetRepository>((ref) {
//   final checkConnectivity = ref.watch(connectivityStatusProvider);
//   if (checkConnectivity == ConnectivityStatus.isConnected) {
//     return ref.read(gadgetRemoteRepository);
//   } else {
//     return ref.read(gadgetRemoteRepository);
//   } // to do ==================================================
// });

abstract class IGadgetRepository {
  Future<Either<Failure, List<GadgetEntity>>> pagination(int page, int limit);
}
