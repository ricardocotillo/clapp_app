import 'package:clapp/providers/book.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    return const Scaffold();
  }
}
