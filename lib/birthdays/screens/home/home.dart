import 'package:bday_calendar/birthdays/provider/birthdays_provider.dart';
import 'package:bday_calendar/birthdays/widgets/birthday_calendar/birthday_calendar.dart';
import 'package:bday_calendar/birthdays/widgets/birthday_card/birthday_card.dart';
import 'package:bday_calendar/core/utils/constants.dart';
import 'package:bday_calendar/core/widgets/app_scaffold.dart';
import 'package:bday_calendar/core/widgets/centered_error.dart';
import 'package:bday_calendar/core/widgets/centered_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<BirthdaysProvider>();
      state.getBirthdaysByMonth(1);
    });
  }

  void onTapDate(int day) {
    final state = context.read<BirthdaysProvider>();
    state.getBirthdaysByDay(day, 1);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BirthdaysProvider>();

    if (state.birthdaysIsLoading) {
      return const CenteredLoader();
    }

    if (state.birthdaysError != null) {
      return CenteredError(error: state.birthdaysError!);
    }

    return AppScaffold(
      isLoading: false,
      error: null,
      body: CustomScrollView(
        slivers: [
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     SliverToBoxAdapter(
          //       child: SizedBox(
          //         // height: 374,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 12),
          //           child: ,
          //         ),
          //       ),
          //     ),
          //   ]),
          // ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: BirthdayCalendar(
              birthdays: state.birthdays,
              onTapDate: onTapDate,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(12, 24, 12, 8),
            sliver: SliverToBoxAdapter(
              child: Text("Birthdays",
                  style: TextStyle(
                    color: Color(0xFFA6A6A6),
                    fontSize: 28,
                  )),
            ),
          ),
          if (state.selectedBirthdaysIsLoading)
            const SliverToBoxAdapter(child: CenteredLoader())
          else if (state.selectedBirthdaysError != null)
            SliverToBoxAdapter(
                child: CenteredError(error: state.selectedBirthdaysError!))
          else if (state.selectedBirthdays.isEmpty)
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "No birthdays for today",
                  style: TextStyle(
                    color: Color(0xFF414141),
                    fontSize: 20,
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.selectedBirthdays.length,
                (context, index) {
                  final item = state.selectedBirthdays[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: BirthdayCard(
                      name: item.name,
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
