import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/gadgets/data/model/gadget_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_api_model.g.dart';

final cartApiModelProvider = Provider<CartApiModel>((ref) {
  return const CartApiModel.empty();
});

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final GadgetApiModel gadgets;
  final int quantity;
  final double total;

  const CartApiModel(
      {required this.id,
      required this.gadgets,
      required this.quantity,
      required this.total});

  const CartApiModel.empty()
      : id = '',
        gadgets = const GadgetApiModel.empty(),
        quantity = 0,
        total = 0.0;

  CartEntity toEntity() {
    return CartEntity(
        id: id,
        gadgetEntity: gadgets.toEntity(),
        quantity: quantity,
        total: total);
  }

  factory CartApiModel.fromEntity(CartEntity entity) {
    return CartApiModel(
        id: entity.id,
        gadgets: GadgetApiModel.fromEntity(entity.gadgetEntity),
        quantity: entity.quantity,
        total: entity.quantity * entity.gadgetEntity.productPrice);
  }

  factory CartApiModel.fromJson(Map<String, dynamic> json) {
    return CartApiModel(
      id: json['_id'],
      gadgets: GadgetApiModel.fromJson(json['productId']),
      quantity: json['quantity'],
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': gadgets.id,
      'quantity': quantity,
      'total': total,
    };
  }

  List<CartApiModel> fromEntityList(List<CartEntity> entityList) {
    return entityList.map((e) => CartApiModel.fromEntity(e)).toList();
  }

  List<CartEntity> toEntityList(List<CartApiModel> modelList) {
    return modelList.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [id, gadgets, quantity, total];
}
