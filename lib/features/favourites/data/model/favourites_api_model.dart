import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/favourites/domain/entity/favourites_entity.dart';
import 'package:final_assignment/features/gadgets/data/model/gadget_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourites_api_model.g.dart';

final favouritesApiModelProvider = Provider<FavouritesApiModel>((ref) {
  return const FavouritesApiModel.empty();
});

@JsonSerializable()
class FavouritesApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final GadgetApiModel productId;
  final String? userId;

  const FavouritesApiModel({
    required this.id,
    required this.productId,
    required this.userId,
  });

  const FavouritesApiModel.empty()
      : id = '',
        productId = const GadgetApiModel.empty(),
        userId = '';

  FavouritesEntity toEntity() {
    return FavouritesEntity(
      id: id,
      gadgetEntity: productId.toEntity(),
      userId: userId,
    );
  }

  factory FavouritesApiModel.fromEntity(FavouritesEntity entity) {
    return FavouritesApiModel(
      id: entity.id,
      productId: GadgetApiModel.fromEntity(entity.gadgetEntity),
      userId: entity.userId,
    );
  }

  factory FavouritesApiModel.fromJson(Map<String, dynamic> json) =>
      _$FavouritesApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavouritesApiModelToJson(this);

  List<FavouritesApiModel> fromEntityList(List<FavouritesEntity> entityList) {
    return entityList.map((e) => FavouritesApiModel.fromEntity(e)).toList();
  }

  List<FavouritesEntity> toEntityList(List<FavouritesApiModel> modelList) {
    return modelList.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [id, productId, userId];
}
