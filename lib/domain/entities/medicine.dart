import 'package:freezed_annotation/freezed_annotation.dart';

part 'medicine.freezed.dart';
part 'medicine.g.dart';

enum FrequencyType { daily, specificDays, dateRange, asNeeded }
enum DosageForm { tablet, capsule, syrup, injection, drops, inhaler, other }

@freezed
abstract class Medicine with _$Medicine {
  const factory Medicine({
    required String id,
    required String profileId,
    required String name,
    String? genericName,
    required String dosage,
    required DosageForm dosageForm,
    required String color,
    required List<String> times, // Stored as "HH:mm" strings
    @Default([]) List<DateTime> scheduledDates,
    required FrequencyType frequency,
    @Default([]) List<String> weekdays,
    required DateTime startDate,
    DateTime? endDate,
    int? pillsPerDose,
    int? currentStock,
    int? refillReminderAt,
    String? doctorName,
    String? prescriptionNote,
    String? instructions,
    @Default(false) bool missedDoseAlertEnabled,
    @Default(true) bool isActive,
    required DateTime createdAt,
  }) = _Medicine;

  factory Medicine.fromJson(Map<String, dynamic> json) => _$MedicineFromJson(json);
}
