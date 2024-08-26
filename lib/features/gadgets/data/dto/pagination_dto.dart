import 'package:final_assignment/features/gadgets/data/model/gadget_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable()
class PaginationDto {
  final bool success;
  final String message;
  final List<GadgetApiModel> products;

  PaginationDto({
    required this.success,
    required this.message,
    required this.products,
  });

//   From Json
  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

// To Json
  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}
