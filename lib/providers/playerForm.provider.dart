import 'dart:async';

import 'package:clapp/models/user.model.dart';
import 'package:clapp/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PlayerFormProvider {
  final PagingController<int, User> pagingController =
      PagingController<int, User>(firstPageKey: 1);
  final textController = TextEditingController();
  final _userService = UserService();
  final usersPage = UsersPage();
  final filter = UserFilter();
  bool typing = false;
  Timer? timer;

  PlayerFormProvider() {
    pagingController.addPageRequestListener((pageKey) {
      filter.search = textController.text;
      filter.page = pageKey;
      _userService.list(filter: filter).then((p) {
        if (p.hasNext) {
          pagingController.appendPage(p.results, p.next);
        } else {
          pagingController.appendLastPage(p.results);
        }
      });
    });
  }

  onChanged(String? s) {
    if (typing) {
      timer?.cancel();
    }
    typing = true;
    timer = Timer(const Duration(seconds: 2), () {
      typing = false;
      pagingController.refresh();
    });
  }
}
