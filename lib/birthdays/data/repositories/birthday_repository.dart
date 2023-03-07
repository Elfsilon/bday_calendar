import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static const birthdays = "birthdays";
}

class FirestoreRepository {
  const FirestoreRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  Future<List<T>> getCollection<T>({
    required String collection,
    required T Function(Map<String, dynamic> map) converter,
  }) async {
    final event = await firestore.collection(collection).get();
    final jsonList = event.docs.map((doc) => jsonEncode(doc.data()));
    final data = jsonList.map<T>((encoded) => converter(jsonDecode(encoded)));
    return data.toList();
  }
}
