// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$LoginProviderToJson(LoginProvider instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

LoginErrors _$LoginErrorsFromJson(Map<String, dynamic> json) => LoginErrors(
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      password: (json['password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
