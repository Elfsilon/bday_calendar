import 'dart:math';

import 'package:bday_calendar/birthdays/data/models/birthay/birthday.dart';
import 'package:bday_calendar/birthdays/provider/birthdays_provider.dart';
import 'package:bday_calendar/core/widgets/app_scaffold.dart';
import 'package:bday_calendar/core/widgets/centered_error.dart';
import 'package:bday_calendar/core/widgets/centered_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  void onTap(BuildContext context, int month) {
    final state = context.read<BirthdaysProvider>();
    state.getBirthdaysByMonth(month);
  }

  void delete(BuildContext context, Birthday item) {
    print("DELETE $item");
    final state = context.read<BirthdaysProvider>();
    state.deleteBirthday(item);
  }

  void add(BuildContext context, int month) {
    final state = context.read<BirthdaysProvider>();
    final item = Birthday(
      id: "",
      name: "Test",
      day: Random().nextInt(20) + 1,
      month: month,
    );
    state.addBirthday(item);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BirthdaysProvider>();

    return AppScaffold(
      isLoading: false,
      error: null,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () => onTap(context, 0),
                onLongPress: () => add(context, 0),
                child: const Text("0"),
              ),
              ElevatedButton(
                onPressed: () => onTap(context, 1),
                onLongPress: () => add(context, 1),
                child: const Text("1"),
              ),
              ElevatedButton(
                onPressed: () => onTap(context, 2),
                onLongPress: () => add(context, 2),
                child: const Text("2"),
              ),
            ],
          ),
          if (state.birthdaysIsLoading)
            const CenteredLoader()
          else if (state.birthdaysError != null)
            CenteredError(error: state.birthdaysError!)
          else
            Expanded(
              child: ListView.builder(
                itemCount: state.birthdays.length,
                itemBuilder: (context, index) {
                  final item = state.birthdays[index];
                  return GestureDetector(
                    onTap: () => delete(context, item),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Text(item.name),
                          const SizedBox(width: 8),
                          Text(item.day.toString()),
                          const SizedBox(width: 8),
                          Text(item.month.toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
