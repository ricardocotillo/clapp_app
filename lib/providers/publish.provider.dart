import 'dart:convert';
import 'dart:io';

import 'package:clapp/models/publication.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/services/publication.service.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';

class PublishProvider extends ChangeNotifier {
  PublishProvider({this.user});

  final User? user;
  final PublicationService _publicationService = PublicationService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bodyController = TextEditingController();
  final imagePicker = ImagePicker();

  File? file;

  String? Function(String?) get bodyValidator =>
      ValidationBuilder(localeName: 'es')
          .add((value) => file != null ? null : 'Este campo es requerido')
          .build();

  Future<Publication> publish() async {
    final p = Publication(
      body: bodyController.text,
      image: file != null ? base64.encode(await file!.readAsBytes()) : null,
      user: user,
    );
    return _publicationService.create(p);
  }

  addImage() async {
    final xfile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      file = File(xfile.path);
      notifyListeners();
    }
  }
}
