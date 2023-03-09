import 'package:bday_calendar/birthdays/data/models/birthay/birthday.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BirthdaysRepository {
  const BirthdaysRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  static const collection = "birthdays";

  Future<List<Birthday>> fetchBirthdaysByMonth(int month) async {
    final snapshot = await firestore
        .collection(collection)
        .where("month", isEqualTo: month)
        .get();
    final data = snapshot.docs.map((doc) => Birthday.fromJson(doc));
    return data.toList();
  }

  Future<List<Birthday>> fetchBirthdaysByDay(int day) async {
    final snapshot = await firestore
        .collection(collection)
        .where("day", isEqualTo: day)
        .get();
    final data = snapshot.docs.map((doc) => Birthday.fromJson(doc));
    return data.toList();
  }

  Future<void> add(Birthday item) async {
    await firestore.collection(collection).add(item.toJson());
  }

  Future<void> delete(String id) async {
    print("[REPO] delete $id");
    await firestore.collection(collection).doc(id).delete();
  }

  Future<void> edit(Birthday item) async {
    await firestore.collection(collection).doc(item.id).set(item.toJson());
  }
}
