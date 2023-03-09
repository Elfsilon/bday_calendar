// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birthday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Birthday _$BirthdayFromJson(Map<String, dynamic> json) => Birthday(
      name: json['name'] as String,
      day: json['day'] as int,
      month: json['month'] as int,
      id: json['id'] as String,
    );

Map<String, dynamic> _$BirthdayToJson(Birthday instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'day': instance.day,
      'month': instance.month,
    };
