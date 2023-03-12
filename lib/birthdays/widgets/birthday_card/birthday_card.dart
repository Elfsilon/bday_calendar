import 'package:bday_calendar/core/utils/constants.dart';
import 'package:flutter/material.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Color(0xFF4C4C4C),
        borderRadius: AppConstants.borderRadius,
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: "VT323",
          color: Color(0xFFA6A6A6),
        ),
      ),
    );
  }
}
