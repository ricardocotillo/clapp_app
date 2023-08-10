import 'package:clapp/models/club.model.dart';
import 'package:clapp/models/sport.model.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

class Clubform extends StatefulWidget {
  const Clubform({
    super.key,
    this.inital,
    required this.sports,
  });
  final List<Sport> sports;
  final Club? inital;

  @override
  State<Clubform> createState() => _ClubformState();
}

class _ClubformState extends State<Clubform> {
  TextEditingController nameController = TextEditingController();
  Sport? sport;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.inital?.name ?? '';
    sport = widget.inital?.sport;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Crea un club',
            style: AppTheme.headers.headerLg,
          ),
          TextFormField(
            validator: ValidationBuilder(localeName: 'es')
                .required()
                .maxLength(100)
                .build(),
            controller: nameController,
            decoration: const InputDecoration(
              label: Text('Nombre'),
            ),
          ),
          DropdownButtonFormField(
            hint: const Text('Deporte'),
            value: sport?.id,
            validator: (id) => ValidationBuilder(localeName: 'es')
                .required()
                .build()
                .call(id?.toString() ?? ''),
            items: widget.sports
                .map(
                  (s) => DropdownMenuItem(
                    value: s.id,
                    child: Text(s.name),
                  ),
                )
                .toList(),
            onChanged: (id) {
              sport = widget.sports.firstWhere((s) => s.id == id);
            },
          ),
          const SizedBox(height: 16),
          MaterialButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                final club = widget.inital ?? Club(name: '');
                club.name = nameController.text;
                club.sport = sport;
                context.pop<Club>(club);
              }
            },
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onPrimary,
            child: const Text('Crear'),
          )
        ],
      ),
    );
  }
}
