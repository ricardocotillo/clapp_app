import 'package:clapp/components/publication.component.dart';
import 'package:clapp/providers/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return ListView.separated(
      separatorBuilder: (context, i) => const SizedBox(height: 20.0),
      itemCount: homeProvider.publications.length,
      itemBuilder: (context, i) => Padding(
        padding: EdgeInsets.only(top: i == 0 ? 16.0 : 0.0),
        child: PublicationComponent(
          publication: homeProvider.publications[i],
        ),
      ),
    );
  }
}
