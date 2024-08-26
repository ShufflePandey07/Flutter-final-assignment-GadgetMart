import 'package:final_assignment/app/constants/hive_table_constant.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userBoxId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phoneNumber;

  @HiveField(4)
  final String password;
  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();
  // Empty Constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          fullName: '',
          email: '',
          phoneNumber: '',
          password: '',
        );

  AuthEntity toEntity() => AuthEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password);

  AuthHiveModel fromEntity(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        fullName: entity.fullName,
        email: entity.email,
        phoneNumber: entity.phoneNumber,
        password: entity.password,
      );


  List<AuthEntity> toEntities(List<AuthHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  List<AuthHiveModel> fromEntities(List<AuthEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId,fullName: $fullName,email: $email,phoneNumber: $phoneNumber,password: $password';
  }
}
