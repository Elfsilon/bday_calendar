import 'package:bday_calendar/birthdays/data/models/birthay/birthday.dart';
import 'package:bday_calendar/birthdays/data/repositories/birthday_repository.dart';
import 'package:flutter/material.dart';

class BirthdaysProvider with ChangeNotifier {
  BirthdaysProvider({
    required FirestoreRepository repository,
  })  : _repository = repository,
        _birthdays = [],
        _birthdaysError = null,
        _birthdaysIsLoading = false;

  final FirestoreRepository _repository;

  List<Birthday> _birthdays;
  List<Birthday> get birthdays => _birthdays;
  set birthdays(List<Birthday> value) {
    _birthdays = value;
    notifyListeners();
  }

  bool _birthdaysIsLoading;
  bool get birthdaysIsLoading => _birthdaysIsLoading;
  set birthdaysIsLoading(bool value) {
    _birthdaysIsLoading = value;
    notifyListeners();
  }

  String? _birthdaysError;
  String? get birthdaysError => _birthdaysError;
  set birthdaysError(String? value) {
    _birthdaysError = value;
    notifyListeners();
  }
}

extension BirthaysProviderMethods on BirthdaysProvider {
  void fetchBirthdays(int month) async {
    try {
      birthdaysIsLoading = true;

      final data = await _repository.getCollection(
        collection: FirestoreCollections.birthdays,
        converter: (map) => Birthday.fromJson(map),
      );

      birthdays = data;
    } catch (e) {
      birthdaysError = e.toString();
    } finally {
      birthdaysIsLoading = false;
    }
  }

  void clearBirthdays(int month) async {
    birthdaysIsLoading = true;
    birthdays = [];
    birthdaysError = null;
  }
}
