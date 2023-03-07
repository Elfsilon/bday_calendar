import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'birthday.g.dart';

@JsonSerializable()
class Birthday extends Equatable {
  const Birthday({
    required this.name,
    required this.day,
    required this.month,
  });

  final String name;
  final int day;
  final int month;

  factory Birthday.fromJson(Map<String, dynamic> json) =>
      _$BirthdayFromJson(json);

  Map<String, dynamic> toJson() => _$BirthdayToJson(this);

  @override
  List<Object> get props => [name, day, month];
}
