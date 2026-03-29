import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../domain/entities/profile.dart';
import '../domain/entities/medicine.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  // ── PROFILES ──────────────────────────────────────────────────────────────

  CollectionReference<Map<String, dynamic>> get _profilesCol =>
      _db.collection('users').doc(_userId).collection('profiles');

  Stream<List<Profile>> watchProfiles() {
    if (_userId == null) return const Stream.empty();
    return _profilesCol.snapshots().map((snap) =>
        snap.docs.map((d) => Profile.fromJson({...d.data(), 'id': d.id})).toList());
  }

  Future<void> addProfile(Profile profile) async {
    await _profilesCol.doc(profile.id).set(profile.toJson());
  }

  Future<void> updateProfile(Profile profile) async {
    await _profilesCol.doc(profile.id).update(profile.toJson());
  }

  Future<void> deleteProfile(String profileId) async {
    await _profilesCol.doc(profileId).delete();
    // Also delete all medicines for this profile
    final meds = await _medicinesCol(profileId).get();
    for (final doc in meds.docs) {
      await doc.reference.delete();
    }
  }

  // ── MEDICINES ─────────────────────────────────────────────────────────────

  CollectionReference<Map<String, dynamic>> _medicinesCol(String profileId) =>
      _profilesCol.doc(profileId).collection('medicines');

  Stream<List<Medicine>> watchMedicines(String profileId) {
    return _medicinesCol(profileId).snapshots().map((snap) => snap.docs
        .map((d) => Medicine.fromJson({...d.data(), 'id': d.id}))
        .toList());
  }

  Future<void> addMedicine(Medicine medicine) async {
    await _medicinesCol(medicine.profileId)
        .doc(medicine.id)
        .set(medicine.toJson());
  }

  Future<void> updateMedicine(Medicine medicine) async {
    await _medicinesCol(medicine.profileId)
        .doc(medicine.id)
        .update(medicine.toJson());
  }

  Future<void> deleteMedicine(String profileId, String medicineId) async {
    await _medicinesCol(profileId).doc(medicineId).delete();
  }

  // ── DOSE LOGS ─────────────────────────────────────────────────────────────

  CollectionReference<Map<String, dynamic>> get _logsCol =>
      _db.collection('users').doc(_userId).collection('dose_logs');

  Future<void> logDose({
    required String medicineId,
    required String profileId,
    required String medicineName,
    required DateTime scheduledTime,
    required String status, // 'taken', 'skipped', 'missed'
  }) async {
    await _logsCol.add({
      'medicineId': medicineId,
      'profileId': profileId,
      'medicineName': medicineName,
      'scheduledTime': Timestamp.fromDate(scheduledTime),
      'loggedAt': FieldValue.serverTimestamp(),
      'status': status,
    });
  }

  Stream<List<Map<String, dynamic>>> watchTodayLogs(String profileId) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _logsCol
        .where('profileId', isEqualTo: profileId)
        .where('scheduledTime',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('scheduledTime', isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots()
        .map((snap) => snap.docs.map((d) => {...d.data(), 'id': d.id}).toList());
  }
}
