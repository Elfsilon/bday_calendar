import 'package:bday_calendar/auth/providers/auth_provider.dart';
import 'package:bday_calendar/auth/screens/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      builder: (context, _) {
        final state = context.watch<AuthProvider>();
        return state.credential != null ? child : const AuthScreen();
      },
    );
  }
}
