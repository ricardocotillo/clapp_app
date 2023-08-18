import 'package:clapp/models/club.model.dart';
import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/sport.model.dart';
import 'package:clapp/services/club.service.dart';
import 'package:clapp/services/sport.service.dart';
import 'package:flutter/material.dart';

class AllClubsProvider extends ChangeNotifier {
  // Filter filter;
  List<Club> clubs = [];
  ClubsPage page = ClubsPage();
  SportsPage sportsPage = SportsPage();
  final ClubService _clubService = ClubService();
  final SportService _sportService = SportService();
  final selectedSports = <int>[];

  AllClubsProvider() {
    final s = _sportService.list();
    final c = fetchClubs();
    Future.wait([c, s]).then((values) {
      page = values[0] as ClubsPage;
      clubs.addAll(page.results);
      sportsPage = values[1] as SportsPage;
      notifyListeners();
    });
  }

  Filter get filter {
    final sports = selectedSports.isNotEmpty ? selectedSports.join(',') : null;
    final params = <String, dynamic>{};
    if (sports != null) params['sport'] = sports;
    return Filter(
      params: params,
    );
  }

  updateResults() async {
    final p = await fetchClubs();
    resetClubsPage(p);
    notifyListeners();
  }

  Future<ClubsPage> fetchClubs() {
    return _clubService.list(filter: filter);
  }

  resetClubsPage(ClubsPage p) {
    page = p;
    clubs = page.results;
  }

  updateClubsPage(ClubsPage p) {
    page = p;
    clubs.addAll(p.results);
  }
}
