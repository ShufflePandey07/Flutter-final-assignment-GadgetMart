// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      phone: (json['phone'] as num).toDouble(),
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
    };
