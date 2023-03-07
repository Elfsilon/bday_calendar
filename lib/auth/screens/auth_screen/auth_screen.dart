import 'package:bday_calendar/auth/providers/auth_provider.dart';
import 'package:bday_calendar/core/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthProvider>();

    return AppScaffold(
      isLoading: state.isLoading,
      error: state.error,
      body: Center(
        child: ElevatedButton(
          onPressed: () => state.login("maxucks@gmail.com", "111111"),
          child: const Text("Login"),
        ),
      ),
    );
  }
}
