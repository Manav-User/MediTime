// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
      id: json['id'] as String,
      name: json['name'] as String,
      relationship: json['relationship'] as String,
      age: (json['age'] as num).toInt(),
      avatarUrl: json['avatarUrl'] as String?,
      isMainUser: json['isMainUser'] as bool? ?? false,
    );

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'relationship': instance.relationship,
      'age': instance.age,
      'avatarUrl': instance.avatarUrl,
      'isMainUser': instance.isMainUser,
    };
