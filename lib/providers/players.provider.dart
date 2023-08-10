import 'package:clapp/components/playerForm.component.dart';
import 'package:clapp/models/membership.model.dart';
import 'package:clapp/providers/playerForm.provider.dart';
import 'package:clapp/services/membership.service.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class PlayersProvider {
  final int? clubId;
  final PagingController<int, Membership> pagingController =
      PagingController(firstPageKey: 1);
  MembershipsPage page = MembershipsPage();
  final MembershipService _membershipService = MembershipService();
  MembershipFilter get filter => MembershipFilter(
        club: clubId,
        page: page.next,
      );

  PlayersProvider({this.clubId}) {
    pagingController.addPageRequestListener((_) {
      getPlayers(filter);
    });
  }

  getPlayers(MembershipFilter filter) {
    _membershipService.list(filter: filter).then((p) {
      page = p;
      if (!page.hasNext) {
        pagingController.appendLastPage(page.results);
      } else {
        pagingController.appendPage(page.results, page.next);
      }
    });
  }

  openForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Provider(
            create: (_) => PlayerFormProvider(),
            child: const PlayerFormComponent(),
          ),
        ),
      ),
    );
  }
}
