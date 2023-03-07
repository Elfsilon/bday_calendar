import 'package:bday_calendar/auth/widgets/auth_guard.dart';
import 'package:bday_calendar/birthdays/data/repositories/birthday_repository.dart';
import 'package:bday_calendar/birthdays/provider/birthdays_provider.dart';
import 'package:bday_calendar/birthdays/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthdays calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: AuthGuard(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => BirthdaysProvider(
                repository: FirestoreRepository(
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            ),
          ],
          child: const Home(),
        ),
      ),
    );
  }
}
