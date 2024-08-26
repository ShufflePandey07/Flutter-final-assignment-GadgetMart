// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gadget_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GadgetApiModel _$GadgetApiModelFromJson(Map<String, dynamic> json) =>
    GadgetApiModel(
      id: json['_id'] as String,
      productName: json['productName'] as String,
      productCategory: json['productCategory'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      productDescription: json['productDescription'] as String,
      productImage: json['productImage'] as String,
    );

Map<String, dynamic> _$GadgetApiModelToJson(GadgetApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'productName': instance.productName,
      'productCategory': instance.productCategory,
      'productPrice': instance.productPrice,
      'productDescription': instance.productDescription,
      'productImage': instance.productImage,
    };
