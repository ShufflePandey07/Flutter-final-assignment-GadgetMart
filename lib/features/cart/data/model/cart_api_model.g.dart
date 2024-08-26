// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      id: json['_id'] as String?,
      gadgets: GadgetApiModel.fromJson(json['gadgets'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'gadgets': instance.gadgets,
      'quantity': instance.quantity,
      'total': instance.total,
    };
