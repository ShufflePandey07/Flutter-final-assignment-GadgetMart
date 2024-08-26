import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/gadgets/domain/entity/gadget_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gadget_api_model.g.dart';

final gadgetApiModelProvider = Provider<GadgetApiModel>((ref) {
  return const GadgetApiModel.empty();
});

@JsonSerializable()
class GadgetApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String productName;
  final String productCategory;
  final double productPrice;
  final String productDescription;
  final String productImage;

  const GadgetApiModel({
    required this.id,
    required this.productName,
    required this.productCategory,
    required this.productPrice,
    required this.productDescription,
    required this.productImage,
  });

  const GadgetApiModel.empty()
      : id = '',
        productName = '',
        productCategory = '',
        productPrice = 0,
        productDescription = '',
        productImage = '';

  // To entity
  GadgetEntity toEntity() {
    return GadgetEntity(
      id: id,
      productName: productName,
      productCategory: productCategory,
      productPrice: productPrice,
      productDescription: productDescription,
      productImage: productImage,
    );
  }

  // From entity
  factory GadgetApiModel.fromEntity(GadgetEntity entity) {
    return GadgetApiModel(
      id: entity.id,
      productName: entity.productName,
      productCategory: entity.productCategory,
      productPrice: entity.productPrice,
      productDescription: entity.productDescription,
      productImage: entity.productImage,
    );
  }

  // From entity list
  List<GadgetApiModel> fromEntityList(List<GadgetEntity> entityList) {
    return entityList
        .map((entity) => GadgetApiModel.fromEntity(entity))
        .toList();
  }

  // To entity list
  List<GadgetEntity> toEntityList(List<GadgetApiModel> modelList) {
    return modelList.map((model) => model.toEntity()).toList();
  }

  //  From Json
  factory GadgetApiModel.fromJson(Map<String, dynamic> json) =>
      _$GadgetApiModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        productName,
        productCategory,
        productPrice,
        productDescription,
        productImage
      ];
}
