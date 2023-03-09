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
    print("SET BIRTHDAYS $value");
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
    print("SET SELECTED BIRTHDAYS $value");
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
      print("ByMonth $data");
      birthdays = data;
    } catch (e) {
      birthdaysError = e.toString();
    } finally {
      birthdaysIsLoading = false;
    }
  }

  Future<void> getBirthdaysByDay(int day) async {
    try {
      selectedBirthdaysIsLoading = true;
      final data = await _repository.fetchBirthdaysByDay(day);
      print("ByDay $data");
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
      print("[VM] delete 1: ${item.id}");
      if (item.id == null) {
        throw Exception("[BirthdaysProvider] Provided item id is null");
      }
      print("[VM] delete 2: ${item.id}");
      await _repository.delete(item.id!);
      await _updateBirthdays(item.day, item.month);
    } catch (e) {
      selectedBirthdaysError = e.toString();
    } finally {
      selectedBirthdaysIsLoading = false;
    }
  }

  Future<void> _updateBirthdays(int day, int month) async {
    await getBirthdaysByDay(day);
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
