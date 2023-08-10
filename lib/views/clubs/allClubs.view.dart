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
    final filter = clubsProvider.filter;
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
                  selected: filter.sport?.contains(sports[i].id) ?? false,
                  label: Text(sports[i].name),
                  onSelected: (v) {
                    final f = clubsProvider.filter;
                    if (v) {
                      f.sport != null
                          ? f.sport?.add(sports[i].id)
                          : f.sport = [sports[i].id];
                      clubsProvider.updateFilter(f);
                    } else {
                      f.sport?.removeWhere((s) => s == sports[i].id);
                      clubsProvider.updateFilter(f);
                    }
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
