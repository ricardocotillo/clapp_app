import 'dart:convert';

import 'package:clapp/services/auth.service.dart';
import 'package:go_router/go_router.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:toast/toast.dart';

part 'register.provider.g.dart';

@JsonSerializable(createFactory: false)
class RegisterProvider extends ChangeNotifier {
  @override
  @JsonKey(includeToJson: false)
  bool get hasListeners => super.hasListeners;
  @JsonKey(includeToJson: false)
  final firstNameController = TextEditingController(text: 'Ricardo');
  @JsonKey(includeToJson: false)
  final lastNameController = TextEditingController(text: 'Cotillo');
  @JsonKey(includeToJson: false)
  final emailController =
      TextEditingController(text: 'ricardo.cotillo@gmail.com');
  @JsonKey(includeToJson: false)
  final passwordController = TextEditingController(text: 'LargoN00!!');
  @JsonKey(includeToJson: false)
  final password2Controller = TextEditingController(text: 'LargoN00!!');
  @JsonKey(includeToJson: false)
  RegisterErrors errors = RegisterErrors();
  @JsonKey(includeToJson: false)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @JsonKey(name: 'first_name')
  String get firstName => firstNameController.text;
  @JsonKey(name: 'last_name')
  String get lastName => lastNameController.text;
  String get email => emailController.text;
  String get username => emailController.text;
  String get password => passwordController.text;
  String get password2 => password2Controller.text;

  @JsonKey(includeToJson: false)
  String? Function(String?) get firstNameValidator =>
      ValidationBuilder(localeName: 'es').required().build();
  @JsonKey(includeToJson: false)
  String? Function(String?) get lastNameValidator =>
      ValidationBuilder(localeName: 'es').required().build();
  @JsonKey(includeToJson: false)
  String? Function(String?) get emailValidator =>
      ValidationBuilder(localeName: 'es').required().email().build();
  @JsonKey(includeToJson: false)
  String? Function(String?) get password1Validator =>
      ValidationBuilder(localeName: 'es').required().build();
  @JsonKey(includeToJson: false)
  String? Function(String?) get password2Validator =>
      ValidationBuilder(localeName: 'es')
          .required()
          .add((value) => passwordController.text == value
              ? null
              : 'Campo debe ser igual a Contraseña')
          .build();
  @JsonKey(includeToJson: false)
  final AuthService _authService = AuthService();

  Future<void> onSubmit(BuildContext context) async {
    errors = RegisterErrors();
    if (formKey.currentState?.validate() ?? false) {
      final user = await _authService.register(this).catchError((error) {
        errors = RegisterErrors.fromJson(jsonDecode(error.toString()));
        notifyListeners();
        return null;
      });
      if (user != null && context.mounted) {
        ToastContext().init(context);
        Toast.show('Usuario creado');
        context.pop();
      }
    }
  }

  Map<String, dynamic> toJson() => _$RegisterProviderToJson(this);
}

@JsonSerializable(createToJson: false)
class RegisterErrors {
  final List<String>? email;
  final List<String>? username;
  final List<String>? password;

  RegisterErrors({
    this.email,
    this.username,
    this.password,
  });

  String? get emailErrors => email?.join('\n');
  String? get usernameErrors => username?.join('\n');
  String? get passwordErrors => password?.join('\n');

  factory RegisterErrors.fromJson(Map<String, dynamic> json) =>
      _$RegisterErrorsFromJson(json);
}
