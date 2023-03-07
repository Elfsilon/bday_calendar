import 'package:flutter/material.dart';

class CenteredError extends StatelessWidget {
  const CenteredError({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
