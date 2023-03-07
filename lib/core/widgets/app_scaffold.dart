import 'package:bday_calendar/core/widgets/centered_error.dart';
import 'package:bday_calendar/core/widgets/centered_loader.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.isLoading,
    required this.error,
    required this.body,
  });

  final bool isLoading;
  final String? error;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: CenteredLoader(),
      );
    }

    if (error != null) {
      return Scaffold(
        body: CenteredError(error: error!),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: body,
      ),
    );
  }
}
