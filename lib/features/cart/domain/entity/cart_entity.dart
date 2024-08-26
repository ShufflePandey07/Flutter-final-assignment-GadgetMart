import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';

class CartEntity extends Equatable {
  final String? id;
  final GadgetEntity gadgetEntity;
  final int quantity;
  final double total; // Ensure total is computed correctly

  const CartEntity({
    this.id,
    required this.gadgetEntity,
    required this.quantity,
    required this.total,
  });

  @override
  List<Object?> get props => [id, gadgetEntity, quantity, total];
}
