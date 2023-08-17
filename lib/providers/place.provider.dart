import 'package:clapp/models/place.model.dart';
import 'package:clapp/services/place.service.dart';
import 'package:flutter/material.dart';

class PlaceProvider extends ChangeNotifier {
  Place? place;
  final placeService = PlaceService();

  PlaceProvider({required int id}) {
    placeService.get(id).then((p) {
      place = p;
      notifyListeners();
    });
  }
}
