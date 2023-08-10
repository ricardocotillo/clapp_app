import 'package:clapp/components/publish.component.dart';
import 'package:clapp/models/publication.model.dart';
import 'package:clapp/providers/auth.provider.dart';
import 'package:clapp/providers/publish.provider.dart';
import 'package:clapp/services/publication.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  final List<Publication> publications = [];
  PublicationsPage page = PublicationsPage(count: 0, results: []);
  final PublicationService _publicationService = PublicationService();
  HomeProvider() {
    _publicationService.list().then((p) {
      page = p;
      publications.addAll(p.results);
      notifyListeners();
    });
  }

  void publish(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final p = await showDialog<Publication>(
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (_) => PublishProvider(user: authProvider.user),
        child: const PublishComponent(),
      ),
    );
    if (p != null) {
      publications.insert(0, p);
      notifyListeners();
    }
  }
}
