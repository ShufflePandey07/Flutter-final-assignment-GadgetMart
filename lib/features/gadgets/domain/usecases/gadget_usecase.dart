import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
import 'package:final_assignment/features/gadgets/domain/repository/i_gadget_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gadgetUseCaseProvider = Provider<GadgetUseCase>((ref) {
  final gadgetRepository = ref.watch(gadgetRepositoryProvider);
  return GadgetUseCase(gadgetRepository: gadgetRepository);
});

class GadgetUseCase {
  final IGadgetRepository gadgetRepository;

  GadgetUseCase({required this.gadgetRepository});

  Future<Either<Failure, List<GadgetEntity>>> pagination(
      int? page, int? limit) {
    return gadgetRepository.pagination(page!, limit!);
  }
}
