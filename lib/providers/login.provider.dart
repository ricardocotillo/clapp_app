import 'dart:convert';

import 'package:clapp/providers/auth.provider.dart';
import 'package:clapp/services/auth.service.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

part 'login.provider.g.dart';

@JsonSerializable(createFactory: false)
class LoginProvider extends ChangeNotifier {
  @override
  @JsonKey(includeToJson: false)
  bool get hasListeners => super.hasListeners;
  @JsonKey(includeToJson: false)
  final TextEditingController emailController = TextEditingController();
  @JsonKey(includeToJson: false)
  final TextEditingController passwordController = TextEditingController();
  @JsonKey(includeToJson: false)
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String get email => emailController.text;
  String get password => passwordController.text;

  @JsonKey(includeToJson: false)
  String? Function(String?) get emailValidator =>
      ValidationBuilder(localeName: 'es').email().required().build();

  @JsonKey(includeToJson: false)
  String? Function(String?) get passwordValidator =>
      ValidationBuilder(localeName: 'es').required().build();

  @JsonKey(includeToJson: false)
  LoginErrors errors = LoginErrors();

  @JsonKey(includeToJson: false)
  final AuthService _authService = AuthService();

  onSubmit(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    errors = LoginErrors();
    if (formKey.currentState?.validate() ?? false) {
      ToastContext().init(context);
      final token = await _authService.login(this).catchError((e) {
        final Map<String, dynamic> j = jsonDecode(e.toString());
        if (j.containsKey('error')) {
          Toast.show(
            'Email o contraseña incorrectos',
            backgroundColor: Theme.of(context).colorScheme.error,
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onError,
            ),
            duration: 3,
          );
        } else {
          errors = LoginErrors.fromJson(j);
        }
        notifyListeners();
        return null;
      });
      if (token != null) {
        if (context.mounted) {
          await Provider.of<AuthProvider>(context, listen: false)
              .saveToken(token);
        }
        final user = await _authService.me();
        if (context.mounted) {
          await Provider.of<AuthProvider>(context, listen: false)
              .saveUser(user);
        }
        if (context.mounted) {
          context.go('/');
        }
      }
    }
  }

  redirectToRegister(BuildContext context) {
    context.push('/register');
  }

  Map<String, dynamic> toJson() => _$LoginProviderToJson(this);
}

@JsonSerializable(createToJson: false)
class LoginErrors {
  final List<String>? email;
  final List<String>? password;

  LoginErrors({
    this.email,
    this.password,
  });

  String? get emailErrors => email?.join('\n');
  String? get passwordErrors => password?.join('\n');

  factory LoginErrors.fromJson(Map<String, dynamic> json) =>
      _$LoginErrorsFromJson(json);
}
