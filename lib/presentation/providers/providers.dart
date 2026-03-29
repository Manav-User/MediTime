import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/medicine.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';

// ── AUTH ──────────────────────────────────────────────────────────────────────

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// ── FIRESTORE ─────────────────────────────────────────────────────────────────

final firestoreServiceProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

// ── PROFILES ──────────────────────────────────────────────────────────────────

final selectedProfileProvider = StateProvider<Profile?>((ref) => null);

final profilesStreamProvider = StreamProvider<List<Profile>>((ref) {
  final auth = ref.watch(authStateProvider);
  return auth.when(
    data: (user) {
      if (user == null) return const Stream.empty();
      return ref.read(firestoreServiceProvider).watchProfiles();
    },
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});

// ── MEDICINES ─────────────────────────────────────────────────────────────────

final medicinesStreamProvider =
    StreamProvider.family<List<Medicine>, String>((ref, profileId) {
  return ref.read(firestoreServiceProvider).watchMedicines(profileId);
});

// ── TODAY'S LOGS ──────────────────────────────────────────────────────────────

final todayLogsProvider = StreamProvider.family<List<Map<String, dynamic>>, String>(
  (ref, profileId) {
    return ref.read(firestoreServiceProvider).watchTodayLogs(profileId);
  },
);
