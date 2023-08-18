import 'package:clapp/components/carousel.component.dart';
import 'package:clapp/components/club.component.dart';
import 'package:clapp/providers/allClubs.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllClubsView extends StatelessWidget {
  const AllClubsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AllClubsProvider clubsProvider =
        Provider.of<AllClubsProvider>(context);
    final clubs = clubsProvider.clubs;
    final sports = clubsProvider.sportsPage.results;
    final selectedSports = clubsProvider.selectedSports;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CarouselComponent(
              count: sports.length,
              height: 50,
              gap: 8,
              builder: (context, i) => Padding(
                padding: EdgeInsets.only(
                  left: i == 0 ? 16.0 : 0,
                  right: i == sports.length - 1 ? 16.0 : 0,
                ),
                child: FilterChip(
                  selected: selectedSports.contains(sports[i].id),
                  label: Text(sports[i].name),
                  onSelected: (v) {
                    if (v) {
                      selectedSports.add(sports[i].id);
                    } else {
                      selectedSports.removeWhere((s) => s == sports[i].id);
                    }
                    clubsProvider.updateResults();
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: clubs.length,
                itemBuilder: (context, i) => ClubComponent(
                  club: clubs[i],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
