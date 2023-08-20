import 'package:clapp/providers/book.provider.dart';
import 'package:clapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final court = bookProvider.court;
    final days = bookProvider.days;
    final selectedDay = bookProvider.selectedDay;
    final Size size = MediaQuery.of(context).size;
    final slots = bookProvider.slots;
    final selectedSlots = bookProvider.selectedSlots;
    return Scaffold(
      appBar: AppBar(
        title: Text(court?.name ?? ''),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                days.length,
                (i) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  alignment: Alignment.center,
                  width: size.width / 8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    color: i == selectedDay
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('EE', 'es').format(days[i]),
                        style: AppTheme.fontSizes.smStyle.copyWith(
                          color: i == selectedDay ? Colors.white : null,
                        ),
                      ),
                      Text(
                        days[i].day.toString(),
                        style: AppTheme.headers.headerLg.copyWith(
                          color: i == selectedDay ? Colors.white : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: slots.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 50,
                crossAxisCount: 3,
              ),
              itemBuilder: (context, i) => RawChip(
                selected: selectedSlots.contains(slots[i]),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                selectedColor: Theme.of(context).colorScheme.primary,
                showCheckmark: false,
                label: Text(
                  '${DateFormat('HH:mm').format(slots[i].start)} - ${DateFormat('HH:mm').format(slots[i].end)}',
                  style: AppTheme.fontSizes.xsStyle.copyWith(
                    color:
                        selectedSlots.contains(slots[i]) ? Colors.white : null,
                  ),
                ),
                onSelected: (_) => bookProvider.onSelected(slots[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
