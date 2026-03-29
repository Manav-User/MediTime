import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/profile.dart';
import '../providers/providers.dart';

class HomeDashboard extends ConsumerStatefulWidget {
  const HomeDashboard({super.key});

  @override
  ConsumerState<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends ConsumerState<HomeDashboard> {
  Profile? _selectedProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profilesAsync = ref.watch(profilesStreamProvider);

    return profilesAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (profiles) {
        // Auto-select first profile
        if (_selectedProfile == null && profiles.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => _selectedProfile = profiles.first);
          });
        }

        final username = ref.read(authStateProvider).value?.displayName ?? 'there';
        final hour = DateTime.now().hour;
        final greeting = hour < 12
            ? 'Good Morning'
            : hour < 17
                ? 'Good Afternoon'
                : 'Good Evening';

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // ── App Bar ──────────────────────────────────────────────
                SliverAppBar(
                  floating: true,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$greeting, $username 👋',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('EEEE, MMM d').format(DateTime.now()),
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  actions: [
                    if (_selectedProfile != null)
                      IconButton(
                        icon: const Icon(Icons.person_remove, color: Colors.redAccent),
                        tooltip: 'Delete Selected Profile',
                        onPressed: () => _confirmDeleteProfile(_selectedProfile!),
                      ),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      tooltip: 'Sign Out',
                      onPressed: () => _confirmSignOut(context),
                    ),
                  ],
                ),

                // ── Profile Switcher ──────────────────────────────────────
                SliverToBoxAdapter(
                  child: _buildProfileSwitcher(profiles, theme),
                ),

                // Show content only if a profile is selected
                if (_selectedProfile != null) ...[
                  // ── Progress Card ───────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: _buildProgressCard(theme, _selectedProfile!),
                    ),
                  ),

                  // ── Stat Cards ──────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          _buildStatCard(theme, 'Today', '0 Taken',
                              Icons.check_circle_outline, AppTheme.primaryTeal),
                          const SizedBox(width: 8),
                          _buildStatCard(theme, 'Pending', '0 Left',
                              Icons.access_time, AppTheme.accentCoral),
                        ],
                      ),
                    ),
                  ),

                  // ── Today's Medicines Header ────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text("Today's Medicines",
                          style: theme.textTheme.titleLarge),
                    ),
                  ),

                  // ── Medicine List ───────────────────────────────────────
                  _buildMedicineList(_selectedProfile!.id, theme),
                ] else ...[
                  SliverFillRemaining(
                    child: _buildEmptyState(theme),
                  ),
                ],

                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ),
          floatingActionButton: _selectedProfile != null
              ? FloatingActionButton.extended(
                  onPressed: () => context.push(
                      '/add-medicine?profileId=${_selectedProfile!.id}'),
                  backgroundColor: theme.colorScheme.primary,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Add Medicine',
                      style: TextStyle(color: Colors.white)),
                )
              : FloatingActionButton.extended(
                  onPressed: () => context.push('/add-profile'),
                  backgroundColor: theme.colorScheme.primary,
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  label: const Text('Add Profile',
                      style: TextStyle(color: Colors.white)),
                ),
        );
      },
    );
  }

  Widget _buildProfileSwitcher(List<Profile> profiles, ThemeData theme) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          ...profiles.map((p) {
            final isSelected = _selectedProfile?.id == p.id;
            return GestureDetector(
              onTap: () => setState(() => _selectedProfile = p),
              onLongPress: () => _confirmDeleteProfile(p),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryTeal
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: isSelected ? 28 : 24,
                        backgroundColor: isSelected
                            ? AppTheme.primaryTeal
                            : Colors.grey[200],
                        child: Text(
                          p.name[0].toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: isSelected ? 20 : 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p.name.split(' ').first,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? AppTheme.primaryTeal
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          // Add Profile button
          GestureDetector(
            onTap: () => context.push('/add-profile'),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor:
                        AppTheme.primaryTeal.withValues(alpha: 0.1),
                    child: const Icon(Icons.add, color: AppTheme.primaryTeal),
                  ),
                  const SizedBox(height: 4),
                  const Text('Add',
                      style:
                          TextStyle(fontSize: 12, color: AppTheme.primaryTeal)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(ThemeData theme, Profile profile) {
    final medicinesAsync =
        ref.watch(medicinesStreamProvider(profile.id));
    final todayLogsAsync = ref.watch(todayLogsProvider(profile.id));

    return medicinesAsync.when(
      loading: () => _progressCardShell(theme, 0, 0),
      error: (e, _) => _progressCardShell(theme, 0, 0),
      data: (medicines) {
        final activeMeds = medicines.where((m) => m.isActive).length;
        final takenCount = todayLogsAsync.when(
          data: (logs) =>
              logs.where((l) => l['status'] == 'taken').length,
          loading: () => 0,
          error: (_, __) => 0,
        );
        return _progressCardShell(theme, takenCount, activeMeds);
      },
    );
  }

  Widget _progressCardShell(ThemeData theme, int taken, int total) {
    final progress = total == 0 ? 0.0 : taken / total;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  color: Colors.white,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  strokeWidth: 8,
                ),
                Center(
                  child: Text(
                    '$taken/$total',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Daily Progress',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: Colors.white)),
                const SizedBox(height: 4),
                Text(
                  total == 0
                      ? 'No medicines scheduled today.'
                      : taken == total
                          ? 'All doses taken! Great job! 🎉'
                          : '${total - taken} dose(s) remaining today.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.white.withValues(alpha: 0.85)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      ThemeData theme, String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey[700])),
                Text(value,
                    style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold, color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineList(String profileId, ThemeData theme) {
    final medicinesAsync = ref.watch(medicinesStreamProvider(profileId));
    final todayLogsAsync = ref.watch(todayLogsProvider(profileId));

    return medicinesAsync.when(
      loading: () => const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator())),
      error: (e, _) =>
          SliverToBoxAdapter(child: Center(child: Text('Error: $e'))),
      data: (medicines) {
        final active = medicines.where((m) => m.isActive).toList();
        if (active.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(Icons.medication_outlined,
                      size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text('No medicines added yet',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text('Tap + Add Medicine to get started',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey)),
                ],
              ),
            ),
          );
        }

        final logs = todayLogsAsync.value ?? [];

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final med = active[index];
              final takenLog = logs.where((l) =>
                  l['medicineId'] == med.id && l['status'] == 'taken');
              final isTaken = takenLog.isNotEmpty;

              // Parse color
              Color medColor;
              try {
                medColor = Color(
                    int.parse(med.color.replaceFirst('#', '0xFF')));
              } catch (_) {
                medColor = AppTheme.primaryTeal;
              }

              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4))
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    width: 12,
                    height: 50,
                    decoration: BoxDecoration(
                      color: medColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  title: Text(med.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${med.dosage} • ${med.dosageForm.name}'),
                      if (med.times.isNotEmpty)
                        Text(med.times.join(', '),
                            style:
                                TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isTaken)
                        IconButton(
                          icon: Icon(Icons.check_circle_outline,
                              color: theme.colorScheme.primary),
                          tooltip: 'Mark Taken',
                          onPressed: () => _logDose(med.id, profileId,
                              med.name, 'taken'),
                        ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (val) async {
                          if (val == 'delete') {
                            _confirmDeleteMedicine(
                                profileId, med.id, med.name);
                          } else if (val == 'skip') {
                            _logDose(
                                med.id, profileId, med.name, 'skipped');
                          }
                        },
                        itemBuilder: (_) => [
                          const PopupMenuItem(
                              value: 'skip',
                              child: Text('Mark Skipped')),
                          const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete Medicine',
                                  style:
                                      TextStyle(color: Colors.redAccent))),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: active.length,
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.family_restroom, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 24),
            Text('No profiles yet',
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text('Add a family member to get started',
                textAlign: TextAlign.center,
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.push('/add-profile'),
              icon: const Icon(Icons.person_add),
              label: const Text('Add Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logDose(
      String medicineId, String profileId, String name, String status) async {
    try {
      await ref.read(firestoreServiceProvider).logDose(
            medicineId: medicineId,
            profileId: profileId,
            medicineName: name,
            scheduledTime: DateTime.now(),
            status: status,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(status == 'taken'
                ? '✅ $name marked as taken'
                : '⏭ $name skipped'),
            behavior: SnackBarBehavior.floating,
            backgroundColor:
                status == 'taken' ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), behavior: SnackBarBehavior.floating),
        );
      }
    }
  }

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              Navigator.pop(context);
              final router = GoRouter.of(context);
              await ref.read(authServiceProvider).signOut();
              router.go('/welcome');
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteProfile(Profile profile) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Remove ${profile.name}?'),
        content: const Text(
            'This will also delete all medicines for this profile. This action cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(firestoreServiceProvider)
                  .deleteProfile(profile.id);
              if (mounted) setState(() => _selectedProfile = null);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteMedicine(
      String profileId, String medicineId, String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete $name?'),
        content: const Text('This medicine and its history will be deleted.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(firestoreServiceProvider)
                  .deleteMedicine(profileId, medicineId);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
