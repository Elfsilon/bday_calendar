import 'package:bday_calendar/birthdays/data/models/birthay/birthday.dart';
import 'package:bday_calendar/core/utils/constants.dart';
import 'package:flutter/material.dart';

class BirthdayCalendar extends StatefulWidget {
  const BirthdayCalendar({
    super.key,
    required this.birthdays,
    this.onTapDate,
  });

  final List<Birthday> birthdays;
  final Function(int day)? onTapDate;

  @override
  State<BirthdayCalendar> createState() => _BirthdayCalendarState();
}

class _BirthdayCalendarState extends State<BirthdayCalendar> {
  int selectedId = 0;

  void onTap(int day) {
    debugPrint("HGHHH");
    setState(() {
      selectedId = day;
    });
    widget.onTapDate?.call(day);
  }

  List<Widget> getCalendarData() {
    final today = DateTime.now();
    final birthdayDays = widget.birthdays.map((e) => e.day).toList();

    final currentMonthDaysCount = DateTime(today.year, today.month + 1, 0).day;
    final currentMonthDays = List.generate(
      currentMonthDaysCount,
      (index) {
        final curr = index + 1;
        return BirthdayCalendarDay(
          onTap: onTap,
          number: curr,
          selected: curr == selectedId,
          birthday: birthdayDays.contains(curr),
        );
      },
    );

    final firstWeekday = DateTime(today.year, today.month, 1).weekday;

    final prevMonthDaysCount = DateTime(today.year, today.month, 0).day;
    final visibleDaysFromPrevMonthCount = firstWeekday - 1;
    final firstVisibleLastMonthDay =
        prevMonthDaysCount - visibleDaysFromPrevMonthCount;
    final visibleDaysFromPrevMonth = List.generate(
      visibleDaysFromPrevMonthCount,
      (index) {
        final curr = firstVisibleLastMonthDay + index;
        return BirthdayCalendarDay(
          number: curr,
          active: false,
        );
      },
    );

    final rest =
        7 - (currentMonthDaysCount + visibleDaysFromPrevMonthCount) % 7;
    final restOfDays = List.generate(
      rest,
      (index) {
        final curr = index + 1;
        return BirthdayCalendarDay(
          number: curr,
          active: false,
        );
      },
    );

    final data = [
      ...visibleDaysFromPrevMonth,
      ...currentMonthDays,
      ...restOfDays,
    ];

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 7,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 3 / 4,
      children: getCalendarData(),
    );
  }
}

class BirthdayCalendarDay extends StatelessWidget {
  const BirthdayCalendarDay({
    super.key,
    required this.number,
    this.active = true,
    this.birthday = false,
    this.selected = false,
    this.onTap,
  });

  final int number;
  final bool active;
  final bool birthday;
  final bool selected;
  final Function(int day)? onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected
        ? const Color(0xFF504520)
        : birthday
            ? const Color(0xFF4D4D4D)
            : active
                ? const Color(0xFF333333)
                : const Color(0xFF252525);

    final textColor = selected
        ? const Color(0xFFFFC700)
        : birthday
            ? const Color(0xFFA6A6A6)
            : active
                ? const Color(0xFFA6A6A6)
                : const Color(0xFF414141);

    return GestureDetector(
      onTap: () => onTap?.call(number),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: AppConstants.borderRadius,
            border: selected || birthday ? Border.all(color: textColor) : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                number.toString(),
                style: TextStyle(
                  color: textColor,
                ),
              ),
              Visibility(
                visible: birthday,
                child: Text(
                  "B",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
