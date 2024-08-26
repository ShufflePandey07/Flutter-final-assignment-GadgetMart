import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider =
    Provider<AuthApiModel>((ref) => const AuthApiModel.empty());

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fullname;
  final String email;
  final double phone;
  final String password;

  const AuthApiModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
  });

  const AuthApiModel.empty()
      : id = '',
        fullname = '',
        email = '',
        phone = 0,
        password = '';

  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fullName: fullname,
      email: email,
      password: password,
      phoneNumber: phone.toString(),
    );
  }

  AuthApiModel fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fullname: entity.fullName,
      email: entity.email,
      phone: double.parse(entity.phoneNumber),
      password: entity.password,
    );
  }

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        fullname,
        email,
        phone,
        password,
      ];
}
