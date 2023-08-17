import 'package:clapp/models/place.model.dart';
import 'package:clapp/providers/places.provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlacesView extends StatelessWidget {
  const PlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlacesProvider placesProvider = Provider.of<PlacesProvider>(context);
    return SafeArea(
      child: PagedListView(
        pagingController: placesProvider.pagingController,
        builderDelegate: PagedChildBuilderDelegate<Place>(
          itemBuilder: (context, place, i) => ListTile(
            title: Text(place.name ?? ''),
            subtitle: Text(place.fullAddress),
            trailing: IconButton(
              onPressed: () => context.pushNamed(
                'place',
                pathParameters: {
                  'id': place.id.toString(),
                },
              ),
              icon: const Icon(LineAwesomeIcons.chevron_circle_right),
            ),
          ),
        ),
      ),
    );
  }
}
