import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChallengeForm extends StatefulWidget {
  const ChallengeForm({super.key});

  @override
  State<ChallengeForm> createState() => _ChallengeFormState();
}

class _ChallengeFormState extends State<ChallengeForm> {
  var address = '';
  var d = DateTime.now().add(const Duration(hours: 24));

  openDatePicker(
      BuildContext context, DateTime firstDate, DateTime lastDate) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (newDate != null) {
      setState(() {
        d = d.copyWith(
          year: newDate.year,
          month: newDate.month,
          day: newDate.day,
        );
      });
    }
  }

  openTimePicker(BuildContext context) {
    final t = TimeOfDay.fromDateTime(d);
    showTimePicker(context: context, initialTime: t);
  }

  var step = 0;

  @override
  Widget build(BuildContext context) {
    final lastDate = d.add(const Duration(days: 30));
    return Stepper(
      currentStep: step,
      onStepContinue: step != 1 || (step == 1 && address.isNotEmpty)
          ? () => setState(() => step++)
          : null,
      onStepCancel: step > 0 ? () => setState(() => step--) : null,
      steps: [
        Step(
          title: const Text('Fecha'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(DateFormat('dd-MM-yyyy').format(d)),
                  TextButton(
                    onPressed: () => openDatePicker(context, d, lastDate),
                    child: const Text('Cambiar'),
                  )
                ],
              ),
              Row(
                children: [
                  Text(DateFormat.jm().format(d)),
                  TextButton(
                    onPressed: () => openTimePicker(context),
                    child: const Text('Cambiar'),
                  )
                ],
              ),
            ],
          ),
        ),
        Step(
          title: const Text('Lugar'),
          content: TextField(
            decoration: const InputDecoration(
              label: Text(
                'Ingresa una dirección',
              ),
            ),
            onChanged: (s) => setState(() => address = s),
          ),
        ),
        const Step(
          title: Text('Tu equipo'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text('Busca por nombre'),
                  suffix: Icon(LineAwesomeIcons.search),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
