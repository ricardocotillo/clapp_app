import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/place.model.dart';
import 'package:clapp/services/place.service.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PlacesProvider extends ChangeNotifier {
  final PagingController<int, Place> pagingController =
      PagingController(firstPageKey: 1);
  PlacePage placePage = PlacePage();
  final PlaceService _placeService = PlaceService();
  Filter get _placeFilter => Filter(
        params: {
          'page': placePage.next,
          'fields': 'id,name,address,district,city',
        },
      );

  PlacesProvider() {
    pagingController.addPageRequestListener((_) {
      getPlaces(_placeFilter);
    });
  }

  getPlaces(Filter filter) async {
    final page = await _placeService.list(filter: filter);
    if (!page.hasNext) {
      pagingController.appendLastPage(page.results);
    } else {
      pagingController.appendPage(page.results, page.next);
    }
  }
}
