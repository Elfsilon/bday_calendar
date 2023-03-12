import 'package:bday_calendar/birthdays/data/models/birthay/birthday.dart';
import 'package:bday_calendar/birthdays/data/repositories/firestore_repository.dart';
import 'package:flutter/material.dart';

class BirthdaysProvider with ChangeNotifier {
  BirthdaysProvider({
    required BirthdaysRepository repository,
  })  : _repository = repository,
        _birthdays = [],
        _birthdaysError = null,
        _birthdaysIsLoading = false,
        _selectedBirthdays = [],
        _selectedBirthdaysError = null,
        _selectedBirthdaysIsLoading = false;

  final BirthdaysRepository _repository;

  // Birthdays
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

  // Selected birthday
  List<Birthday> _selectedBirthdays;
  List<Birthday> get selectedBirthdays => _selectedBirthdays;
  set selectedBirthdays(List<Birthday> value) {
    _selectedBirthdays = value;
    notifyListeners();
  }

  bool _selectedBirthdaysIsLoading;
  bool get selectedBirthdaysIsLoading => _selectedBirthdaysIsLoading;
  set selectedBirthdaysIsLoading(bool value) {
    _selectedBirthdaysIsLoading = value;
    notifyListeners();
  }

  String? _selectedBirthdaysError;
  String? get selectedBirthdaysError => _selectedBirthdaysError;
  set selectedBirthdaysError(String? value) {
    _selectedBirthdaysError = value;
    notifyListeners();
  }
}

extension BirthaysProviderMethods on BirthdaysProvider {
  Future<void> getBirthdaysByMonth(int month) async {
    try {
      birthdaysIsLoading = true;
      final data = await _repository.fetchBirthdaysByMonth(month);
      birthdays = data;
    } catch (e) {
      birthdaysError = e.toString();
    } finally {
      birthdaysIsLoading = false;
    }
  }

  Future<void> getBirthdaysByDay(int day, int month) async {
    try {
      selectedBirthdaysIsLoading = true;
      final data = await _repository.fetchBirthdaysByDay(day, month);
      selectedBirthdays = data;
    } catch (e) {
      selectedBirthdaysError = e.toString();
    } finally {
      selectedBirthdaysIsLoading = false;
    }
  }

  Future<void> addBirthday(Birthday item) async {
    try {
      selectedBirthdaysIsLoading = true;
      await _repository.add(item);
      await _updateBirthdays(item.day, item.month);
    } catch (e) {
      selectedBirthdaysError = e.toString();
    } finally {
      selectedBirthdaysIsLoading = false;
    }
  }

  Future<void> deleteBirthday(Birthday item) async {
    try {
      selectedBirthdaysIsLoading = true;
      await _repository.delete(item.id);
      await _updateBirthdays(item.day, item.month);
    } catch (e) {
      selectedBirthdaysError = e.toString();
    } finally {
      selectedBirthdaysIsLoading = false;
    }
  }

  Future<void> _updateBirthdays(int day, int month) async {
    await getBirthdaysByDay(day, month);
    await getBirthdaysByMonth(month);
  }

  void clearBirthdays() {
    birthdaysIsLoading = true;
    birthdays = [];
    birthdaysError = null;
    clearSelectedBirthdays();
  }

  void clearSelectedBirthdays() {
    selectedBirthdays = [];
    selectedBirthdaysError = null;
    selectedBirthdaysIsLoading = false;
  }
}
