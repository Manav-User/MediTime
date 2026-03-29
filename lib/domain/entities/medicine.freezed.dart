// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medicine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Medicine {
  String get id;
  String get profileId;
  String get name;
  String? get genericName;
  String get dosage;
  DosageForm get dosageForm;
  String get color;
  List<String> get times; // Stored as "HH:mm" strings
  List<DateTime> get scheduledDates;
  FrequencyType get frequency;
  List<String> get weekdays;
  DateTime get startDate;
  DateTime? get endDate;
  int? get pillsPerDose;
  int? get currentStock;
  int? get refillReminderAt;
  String? get doctorName;
  String? get prescriptionNote;
  String? get instructions;
  bool get missedDoseAlertEnabled;
  bool get isActive;
  DateTime get createdAt;

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicineCopyWith<Medicine> get copyWith =>
      _$MedicineCopyWithImpl<Medicine>(this as Medicine, _$identity);

  /// Serializes this Medicine to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Medicine &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.genericName, genericName) ||
                other.genericName == genericName) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.dosageForm, dosageForm) ||
                other.dosageForm == dosageForm) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other.times, times) &&
            const DeepCollectionEquality()
                .equals(other.scheduledDates, scheduledDates) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality().equals(other.weekdays, weekdays) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.pillsPerDose, pillsPerDose) ||
                other.pillsPerDose == pillsPerDose) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.refillReminderAt, refillReminderAt) ||
                other.refillReminderAt == refillReminderAt) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.prescriptionNote, prescriptionNote) ||
                other.prescriptionNote == prescriptionNote) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            (identical(other.missedDoseAlertEnabled, missedDoseAlertEnabled) ||
                other.missedDoseAlertEnabled == missedDoseAlertEnabled) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        profileId,
        name,
        genericName,
        dosage,
        dosageForm,
        color,
        const DeepCollectionEquality().hash(times),
        const DeepCollectionEquality().hash(scheduledDates),
        frequency,
        const DeepCollectionEquality().hash(weekdays),
        startDate,
        endDate,
        pillsPerDose,
        currentStock,
        refillReminderAt,
        doctorName,
        prescriptionNote,
        instructions,
        missedDoseAlertEnabled,
        isActive,
        createdAt
      ]);

  @override
  String toString() {
    return 'Medicine(id: $id, profileId: $profileId, name: $name, genericName: $genericName, dosage: $dosage, dosageForm: $dosageForm, color: $color, times: $times, scheduledDates: $scheduledDates, frequency: $frequency, weekdays: $weekdays, startDate: $startDate, endDate: $endDate, pillsPerDose: $pillsPerDose, currentStock: $currentStock, refillReminderAt: $refillReminderAt, doctorName: $doctorName, prescriptionNote: $prescriptionNote, instructions: $instructions, missedDoseAlertEnabled: $missedDoseAlertEnabled, isActive: $isActive, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $MedicineCopyWith<$Res> {
  factory $MedicineCopyWith(Medicine value, $Res Function(Medicine) _then) =
      _$MedicineCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String profileId,
      String name,
      String? genericName,
      String dosage,
      DosageForm dosageForm,
      String color,
      List<String> times,
      List<DateTime> scheduledDates,
      FrequencyType frequency,
      List<String> weekdays,
      DateTime startDate,
      DateTime? endDate,
      int? pillsPerDose,
      int? currentStock,
      int? refillReminderAt,
      String? doctorName,
      String? prescriptionNote,
      String? instructions,
      bool missedDoseAlertEnabled,
      bool isActive,
      DateTime createdAt});
}

/// @nodoc
class _$MedicineCopyWithImpl<$Res> implements $MedicineCopyWith<$Res> {
  _$MedicineCopyWithImpl(this._self, this._then);

  final Medicine _self;
  final $Res Function(Medicine) _then;

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? name = null,
    Object? genericName = freezed,
    Object? dosage = null,
    Object? dosageForm = null,
    Object? color = null,
    Object? times = null,
    Object? scheduledDates = null,
    Object? frequency = null,
    Object? weekdays = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? pillsPerDose = freezed,
    Object? currentStock = freezed,
    Object? refillReminderAt = freezed,
    Object? doctorName = freezed,
    Object? prescriptionNote = freezed,
    Object? instructions = freezed,
    Object? missedDoseAlertEnabled = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      profileId: null == profileId
          ? _self.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      genericName: freezed == genericName
          ? _self.genericName
          : genericName // ignore: cast_nullable_to_non_nullable
              as String?,
      dosage: null == dosage
          ? _self.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      dosageForm: null == dosageForm
          ? _self.dosageForm
          : dosageForm // ignore: cast_nullable_to_non_nullable
              as DosageForm,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      times: null == times
          ? _self.times
          : times // ignore: cast_nullable_to_non_nullable
              as List<String>,
      scheduledDates: null == scheduledDates
          ? _self.scheduledDates
          : scheduledDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as FrequencyType,
      weekdays: null == weekdays
          ? _self.weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pillsPerDose: freezed == pillsPerDose
          ? _self.pillsPerDose
          : pillsPerDose // ignore: cast_nullable_to_non_nullable
              as int?,
      currentStock: freezed == currentStock
          ? _self.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as int?,
      refillReminderAt: freezed == refillReminderAt
          ? _self.refillReminderAt
          : refillReminderAt // ignore: cast_nullable_to_non_nullable
              as int?,
      doctorName: freezed == doctorName
          ? _self.doctorName
          : doctorName // ignore: cast_nullable_to_non_nullable
              as String?,
      prescriptionNote: freezed == prescriptionNote
          ? _self.prescriptionNote
          : prescriptionNote // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _self.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      missedDoseAlertEnabled: null == missedDoseAlertEnabled
          ? _self.missedDoseAlertEnabled
          : missedDoseAlertEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Medicine implements Medicine {
  const _Medicine(
      {required this.id,
      required this.profileId,
      required this.name,
      this.genericName,
      required this.dosage,
      required this.dosageForm,
      required this.color,
      required final List<String> times,
      final List<DateTime> scheduledDates = const [],
      required this.frequency,
      final List<String> weekdays = const [],
      required this.startDate,
      this.endDate,
      this.pillsPerDose,
      this.currentStock,
      this.refillReminderAt,
      this.doctorName,
      this.prescriptionNote,
      this.instructions,
      this.missedDoseAlertEnabled = false,
      this.isActive = true,
      required this.createdAt})
      : _times = times,
        _scheduledDates = scheduledDates,
        _weekdays = weekdays;
  factory _Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);

  @override
  final String id;
  @override
  final String profileId;
  @override
  final String name;
  @override
  final String? genericName;
  @override
  final String dosage;
  @override
  final DosageForm dosageForm;
  @override
  final String color;
  final List<String> _times;
  @override
  List<String> get times {
    if (_times is EqualUnmodifiableListView) return _times;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_times);
  }

// Stored as "HH:mm" strings
  final List<DateTime> _scheduledDates;
// Stored as "HH:mm" strings
  @override
  @JsonKey()
  List<DateTime> get scheduledDates {
    if (_scheduledDates is EqualUnmodifiableListView) return _scheduledDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scheduledDates);
  }

  @override
  final FrequencyType frequency;
  final List<String> _weekdays;
  @override
  @JsonKey()
  List<String> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final int? pillsPerDose;
  @override
  final int? currentStock;
  @override
  final int? refillReminderAt;
  @override
  final String? doctorName;
  @override
  final String? prescriptionNote;
  @override
  final String? instructions;
  @override
  @JsonKey()
  final bool missedDoseAlertEnabled;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MedicineCopyWith<_Medicine> get copyWith =>
      __$MedicineCopyWithImpl<_Medicine>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MedicineToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Medicine &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.genericName, genericName) ||
                other.genericName == genericName) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.dosageForm, dosageForm) ||
                other.dosageForm == dosageForm) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other._times, _times) &&
            const DeepCollectionEquality()
                .equals(other._scheduledDates, _scheduledDates) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.pillsPerDose, pillsPerDose) ||
                other.pillsPerDose == pillsPerDose) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.refillReminderAt, refillReminderAt) ||
                other.refillReminderAt == refillReminderAt) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.prescriptionNote, prescriptionNote) ||
                other.prescriptionNote == prescriptionNote) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            (identical(other.missedDoseAlertEnabled, missedDoseAlertEnabled) ||
                other.missedDoseAlertEnabled == missedDoseAlertEnabled) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        profileId,
        name,
        genericName,
        dosage,
        dosageForm,
        color,
        const DeepCollectionEquality().hash(_times),
        const DeepCollectionEquality().hash(_scheduledDates),
        frequency,
        const DeepCollectionEquality().hash(_weekdays),
        startDate,
        endDate,
        pillsPerDose,
        currentStock,
        refillReminderAt,
        doctorName,
        prescriptionNote,
        instructions,
        missedDoseAlertEnabled,
        isActive,
        createdAt
      ]);

  @override
  String toString() {
    return 'Medicine(id: $id, profileId: $profileId, name: $name, genericName: $genericName, dosage: $dosage, dosageForm: $dosageForm, color: $color, times: $times, scheduledDates: $scheduledDates, frequency: $frequency, weekdays: $weekdays, startDate: $startDate, endDate: $endDate, pillsPerDose: $pillsPerDose, currentStock: $currentStock, refillReminderAt: $refillReminderAt, doctorName: $doctorName, prescriptionNote: $prescriptionNote, instructions: $instructions, missedDoseAlertEnabled: $missedDoseAlertEnabled, isActive: $isActive, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$MedicineCopyWith<$Res>
    implements $MedicineCopyWith<$Res> {
  factory _$MedicineCopyWith(_Medicine value, $Res Function(_Medicine) _then) =
      __$MedicineCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String profileId,
      String name,
      String? genericName,
      String dosage,
      DosageForm dosageForm,
      String color,
      List<String> times,
      List<DateTime> scheduledDates,
      FrequencyType frequency,
      List<String> weekdays,
      DateTime startDate,
      DateTime? endDate,
      int? pillsPerDose,
      int? currentStock,
      int? refillReminderAt,
      String? doctorName,
      String? prescriptionNote,
      String? instructions,
      bool missedDoseAlertEnabled,
      bool isActive,
      DateTime createdAt});
}

/// @nodoc
class __$MedicineCopyWithImpl<$Res> implements _$MedicineCopyWith<$Res> {
  __$MedicineCopyWithImpl(this._self, this._then);

  final _Medicine _self;
  final $Res Function(_Medicine) _then;

  /// Create a copy of Medicine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? name = null,
    Object? genericName = freezed,
    Object? dosage = null,
    Object? dosageForm = null,
    Object? color = null,
    Object? times = null,
    Object? scheduledDates = null,
    Object? frequency = null,
    Object? weekdays = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? pillsPerDose = freezed,
    Object? currentStock = freezed,
    Object? refillReminderAt = freezed,
    Object? doctorName = freezed,
    Object? prescriptionNote = freezed,
    Object? instructions = freezed,
    Object? missedDoseAlertEnabled = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_Medicine(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      profileId: null == profileId
          ? _self.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      genericName: freezed == genericName
          ? _self.genericName
          : genericName // ignore: cast_nullable_to_non_nullable
              as String?,
      dosage: null == dosage
          ? _self.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      dosageForm: null == dosageForm
          ? _self.dosageForm
          : dosageForm // ignore: cast_nullable_to_non_nullable
              as DosageForm,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      times: null == times
          ? _self._times
          : times // ignore: cast_nullable_to_non_nullable
              as List<String>,
      scheduledDates: null == scheduledDates
          ? _self._scheduledDates
          : scheduledDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      frequency: null == frequency
          ? _self.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as FrequencyType,
      weekdays: null == weekdays
          ? _self._weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pillsPerDose: freezed == pillsPerDose
          ? _self.pillsPerDose
          : pillsPerDose // ignore: cast_nullable_to_non_nullable
              as int?,
      currentStock: freezed == currentStock
          ? _self.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as int?,
      refillReminderAt: freezed == refillReminderAt
          ? _self.refillReminderAt
          : refillReminderAt // ignore: cast_nullable_to_non_nullable
              as int?,
      doctorName: freezed == doctorName
          ? _self.doctorName
          : doctorName // ignore: cast_nullable_to_non_nullable
              as String?,
      prescriptionNote: freezed == prescriptionNote
          ? _self.prescriptionNote
          : prescriptionNote // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _self.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      missedDoseAlertEnabled: null == missedDoseAlertEnabled
          ? _self.missedDoseAlertEnabled
          : missedDoseAlertEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
