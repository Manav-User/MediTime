// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Medicine _$MedicineFromJson(Map<String, dynamic> json) => _Medicine(
      id: json['id'] as String,
      profileId: json['profileId'] as String,
      name: json['name'] as String,
      genericName: json['genericName'] as String?,
      dosage: json['dosage'] as String,
      dosageForm: $enumDecode(_$DosageFormEnumMap, json['dosageForm']),
      color: json['color'] as String,
      times: (json['times'] as List<dynamic>).map((e) => e as String).toList(),
      scheduledDates: (json['scheduledDates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      frequency: $enumDecode(_$FrequencyTypeEnumMap, json['frequency']),
      weekdays: (json['weekdays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      pillsPerDose: (json['pillsPerDose'] as num?)?.toInt(),
      currentStock: (json['currentStock'] as num?)?.toInt(),
      refillReminderAt: (json['refillReminderAt'] as num?)?.toInt(),
      doctorName: json['doctorName'] as String?,
      prescriptionNote: json['prescriptionNote'] as String?,
      instructions: json['instructions'] as String?,
      missedDoseAlertEnabled: json['missedDoseAlertEnabled'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MedicineToJson(_Medicine instance) => <String, dynamic>{
      'id': instance.id,
      'profileId': instance.profileId,
      'name': instance.name,
      'genericName': instance.genericName,
      'dosage': instance.dosage,
      'dosageForm': _$DosageFormEnumMap[instance.dosageForm]!,
      'color': instance.color,
      'times': instance.times,
      'scheduledDates':
          instance.scheduledDates.map((e) => e.toIso8601String()).toList(),
      'frequency': _$FrequencyTypeEnumMap[instance.frequency]!,
      'weekdays': instance.weekdays,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'pillsPerDose': instance.pillsPerDose,
      'currentStock': instance.currentStock,
      'refillReminderAt': instance.refillReminderAt,
      'doctorName': instance.doctorName,
      'prescriptionNote': instance.prescriptionNote,
      'instructions': instance.instructions,
      'missedDoseAlertEnabled': instance.missedDoseAlertEnabled,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$DosageFormEnumMap = {
  DosageForm.tablet: 'tablet',
  DosageForm.capsule: 'capsule',
  DosageForm.syrup: 'syrup',
  DosageForm.injection: 'injection',
  DosageForm.drops: 'drops',
  DosageForm.inhaler: 'inhaler',
  DosageForm.other: 'other',
};

const _$FrequencyTypeEnumMap = {
  FrequencyType.daily: 'daily',
  FrequencyType.specificDays: 'specificDays',
  FrequencyType.dateRange: 'dateRange',
  FrequencyType.asNeeded: 'asNeeded',
};
