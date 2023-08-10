import 'package:clapp/components/imageFormField.component.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfileProvider extends ChangeNotifier {
  static final userBox = Hive.box<User>('me');
  static final User? user = userBox.get(0);

  final _authService = AuthService();

  final imageController = ImageEditingController(url: user?.image);

  final firstNameController = TextEditingController(text: user?.firstName);

  final lastNameController = TextEditingController(text: user?.lastName);

  final emailController = TextEditingController(text: user?.email);

  bool get imageChanged => user?.image != imageController.url;
  bool get firstNameChanged => user?.firstName != firstNameController.text;
  bool get lastNameChanged => user?.lastName != lastNameController.text;
  bool get emailChanged => user?.email != emailController.text;

  bool get changed =>
      imageChanged || firstNameChanged || lastNameChanged || emailChanged;

  onChanged() => notifyListeners();

  save() {
    user?.firstName = firstNameController.text;
    user?.lastName = lastNameController.text;
    user?.email = emailController.text;
    user?.image = imageController.image;
    if (user != null) _authService.profile(user!);
  }
}
