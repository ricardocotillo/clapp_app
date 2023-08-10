import 'package:clapp/components/club.component.dart';
import 'package:clapp/providers/clubs.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClubsView extends StatelessWidget {
  const ClubsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ClubsProvider clubsProvider = Provider.of<ClubsProvider>(context);
    final clubs = clubsProvider.clubs;
    return clubs.isNotEmpty
        ? ListView.builder(
            itemCount: clubsProvider.clubs.length,
            itemBuilder: (context, i) => ClubComponent(
              club: clubs[i],
            ),
          )
        : Center(
            child: MaterialButton(
              onPressed: () => clubsProvider.openForm(context),
              color: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.onPrimary,
              child: const Text('Crea tu primer club'),
            ),
          );
  }
}
