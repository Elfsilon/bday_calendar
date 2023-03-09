import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'birthday.g.dart';

@JsonSerializable()
class Birthday extends Equatable {
  const Birthday({
    required this.name,
    required this.day,
    required this.month,
    required this.id,
  });

  final String id;
  final String name;
  final int day;
  final int month;

  factory Birthday.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data();
    if (json == null) throw Exception("Provided snapshot data is null");
    json.addAll({"id": snapshot.id});
    return _$BirthdayFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final json = _$BirthdayToJson(this);
    json.removeWhere((key, value) => key == 'id');
    return json;
  }

  @override
  List<Object> get props => [name, day, month];
}
