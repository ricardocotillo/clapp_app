// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RegisterProviderToJson(RegisterProvider instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'password2': instance.password2,
    };

RegisterErrors _$RegisterErrorsFromJson(Map<String, dynamic> json) =>
    RegisterErrors(
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      username: (json['username'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      password: (json['password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
