import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';

class FavouritesEntity extends Equatable {
  final String? id;
  final GadgetEntity gadgetEntity;
  final String? userId;

  const FavouritesEntity({
    this.id,
    required this.gadgetEntity,
    this.userId,
  });

  @override
  List<Object?> get props => [id, gadgetEntity, userId];
}
