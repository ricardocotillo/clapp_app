import 'package:clapp/components/clubForm.component.dart';
import 'package:clapp/models/club.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/sport.model.dart';
import 'package:clapp/services/club.service.dart';
import 'package:clapp/services/sport.service.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ClubsProvider extends ChangeNotifier {
  // Filter filter;
  final int? userId;
  List<Club> clubs = [];
  ClubsPage page = ClubsPage();
  SportsPage sportsPage = SportsPage();
  final ClubService _clubService = ClubService();
  final SportService _sportService = SportService();

  Filter get filter => Filter(params: {'members': userId});

  ClubsProvider({this.userId}) {
    final s = _sportService.list();
    final c = fetchClubs();
    Future.wait([c, s]).then((values) {
      page = values[0] as ClubsPage;
      sportsPage = values[1] as SportsPage;
      clubs.addAll(page.results);
      notifyListeners();
    });
  }
  Future<ClubsPage> fetchClubs() {
    return _clubService.list(filter: filter);
  }

  openForm(BuildContext context) async {
    var club = await showDialog<Club?>(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Clubform(
            sports: sportsPage.results,
          ),
        ),
      ),
    );

    if (club != null) {
      try {
        club = await _clubService.create(club);
        clubs.insert(0, club);
        notifyListeners();
      } catch (e) {
        if (context.mounted) {
          ToastContext().init(context);
          Toast.show(
            e.toString(),
            duration: 3,
            backgroundColor: Theme.of(context).colorScheme.error,
            textStyle: AppTheme.fontSizes.baseStyle.copyWith(
              color: Theme.of(context).colorScheme.onError,
            ),
          );
        }
      }
    }
  }

  updateClubsPage(ClubsPage p) {
    page = p;
    clubs.addAll(p.results);
  }
}
