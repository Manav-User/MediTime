import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/medicine.dart';
import '../providers/providers.dart';

class AddMedicineScreen extends ConsumerStatefulWidget {
  final String profileId;
  const AddMedicineScreen({super.key, required this.profileId});

  @override
  ConsumerState<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends ConsumerState<AddMedicineScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  // Step 1 — Info
  final _nameController = TextEditingController();
  final _genericNameController = TextEditingController();
  final _dosageController = TextEditingController();
  DosageForm _selectedForm = DosageForm.tablet;
  String _selectedColor = '#3B82F6';

  // Step 2 — Schedule
  FrequencyType _selectedFrequency = FrequencyType.daily;
  final List<TimeOfDay> _selectedTimes = [];
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  final List<bool> _weekdaySelection = List.filled(7, false);

  // Step 3 — Alerts
  bool _localRemindersEnabled = true;
  bool _missedDoseAlertEnabled = false;

  // Step 4 — Extras
  final _stockController = TextEditingController();
  final _refillAtController = TextEditingController();
  final _doctorController = TextEditingController();
  final _instructionsController = TextEditingController();

  final List<Color> _colorOptions = [
    const Color(0xFF3B82F6),
    const Color(0xFFEF4444),
    const Color(0xFF10B981),
    const Color(0xFFF97316),
    const Color(0xFF8B5CF6),
    const Color(0xFFF59E0B),
    const Color(0xFFEC4899),
    const Color(0xFF06B6D4),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _genericNameController.dispose();
    _dosageController.dispose();
    _stockController.dispose();
    _refillAtController.dispose();
    _doctorController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _selectedTimes.add(picked));
    }
  }

  Future<void> _pickDate({bool isEnd = false}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isEnd ? (_endDate ?? DateTime.now().add(const Duration(days: 7))) : _startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() {
        if (isEnd) {
          _endDate = picked;
        } else {
          _startDate = picked;
        }
      });
    }
  }

  bool _validateStep(int step) {
    switch (step) {
      case 0:
        if (_nameController.text.trim().isEmpty) {
          _showError('Please enter the medicine name.');
          return false;
        }
        if (_dosageController.text.trim().isEmpty) {
          _showError('Please enter the dosage (e.g. 500mg).');
          return false;
        }
        return true;
      case 1:
        if (_selectedTimes.isEmpty) {
          _showError('Please add at least one reminder time.');
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _saveMedicine() async {
    setState(() => _isLoading = true);
    try {
      final weekdays = <String>[];
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      for (int i = 0; i < 7; i++) {
        if (_weekdaySelection[i]) weekdays.add(days[i]);
      }

      final medicine = Medicine(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        profileId: widget.profileId,
        name: _nameController.text.trim(),
        genericName: _genericNameController.text.trim().isNotEmpty
            ? _genericNameController.text.trim()
            : null,
        dosage: _dosageController.text.trim(),
        dosageForm: _selectedForm,
        color: _selectedColor,
        times: _selectedTimes
            .map((t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}')
            .toList(),
        frequency: _selectedFrequency,
        weekdays: weekdays,
        startDate: _startDate,
        endDate: _endDate,
        pillsPerDose: 1,
        currentStock: int.tryParse(_stockController.text),
        refillReminderAt: int.tryParse(_refillAtController.text),
        doctorName: _doctorController.text.trim().isNotEmpty ? _doctorController.text.trim() : null,
        instructions: _instructionsController.text.trim().isNotEmpty
            ? _instructionsController.text.trim()
            : null,
        missedDoseAlertEnabled: _missedDoseAlertEnabled,
        isActive: true,
        createdAt: DateTime.now(),
      );

      await ref.read(firestoreServiceProvider).addMedicine(medicine);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Medicine added successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        _showError('Error saving medicine: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Medicine')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (!_validateStep(_currentStep)) return;
          if (_currentStep < 3) {
            setState(() => _currentStep++);
          } else {
            _saveMedicine();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          } else {
            context.pop();
          }
        },
        controlsBuilder: (context, details) {
          final isLast = _currentStep == 3;
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : details.onStepContinue,
                  child: _isLoading && isLast
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(isLast ? 'Save' : 'Next'),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text(_currentStep == 0 ? 'Cancel' : 'Back'),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Info'),
            content: _buildInfoStep(theme),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Schedule'),
            content: _buildScheduleStep(theme),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Alerts'),
            content: _buildAlertsStep(),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Extras'),
            content: _buildExtrasStep(),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoStep(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _nameController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Medicine Name *',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _genericNameController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Generic Name (optional)',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _dosageController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Dosage (e.g. 500mg) *',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<DosageForm>(
          value: _selectedForm,
          decoration: const InputDecoration(
            labelText: 'Form',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
          items: DosageForm.values
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name[0].toUpperCase() + e.name.substring(1)),
                  ))
              .toList(),
          onChanged: (val) => setState(() => _selectedForm = val ?? DosageForm.tablet),
        ),
        const SizedBox(height: 16),
        Text('Pill Color', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _colorOptions.map((color) {
            // ignore: deprecated_member_use
            final hex = '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
            final isSelected = _selectedColor == hex;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = hex),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.black, width: 3)
                      : Border.all(color: Colors.transparent),
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildScheduleStep(ThemeData theme) {
    const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<FrequencyType>(
          value: _selectedFrequency,
          decoration: const InputDecoration(
            labelText: 'Frequency',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
          items: FrequencyType.values
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text({
                      FrequencyType.daily: 'Daily',
                      FrequencyType.specificDays: 'Specific Days',
                      FrequencyType.dateRange: 'Date Range',
                      FrequencyType.asNeeded: 'As Needed',
                    }[e]!),
                  ))
              .toList(),
          onChanged: (val) => setState(() => _selectedFrequency = val ?? FrequencyType.daily),
        ),
        if (_selectedFrequency == FrequencyType.specificDays) ...[
          const SizedBox(height: 12),
          Text('Select Days', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (i) {
              return GestureDetector(
                onTap: () => setState(() => _weekdaySelection[i] = !_weekdaySelection[i]),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _weekdaySelection[i]
                      ? theme.colorScheme.primary
                      : Colors.grey[200],
                  child: Text(
                    weekdays[i],
                    style: TextStyle(
                      color: _weekdaySelection[i] ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
        const SizedBox(height: 16),
        // Start Date
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Start Date'),
          subtitle: Text(DateFormat('MMM d, yyyy').format(_startDate)),
          trailing: const Icon(Icons.calendar_today_outlined),
          onTap: () => _pickDate(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 8),
        // End Date
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('End Date (optional)'),
          subtitle: Text(_endDate != null ? DateFormat('MMM d, yyyy').format(_endDate!) : 'Not set'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_endDate != null)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => _endDate = null),
                ),
              const Icon(Icons.calendar_today_outlined),
            ],
          ),
          onTap: () => _pickDate(isEnd: true),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 16),
        Text('Reminder Times *', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._selectedTimes.asMap().entries.map((entry) {
              final t = entry.value;
              return Chip(
                label: Text(t.format(context)),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => setState(() => _selectedTimes.removeAt(entry.key)),
              );
            }),
            ActionChip(
              avatar: const Icon(Icons.add, size: 18),
              label: const Text('Add Time'),
              onPressed: _pickTime,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAlertsStep() {
    return Column(
      children: [
        SwitchListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          title: const Text('Local Reminders'),
          subtitle: const Text('Push notification on this device'),
          value: _localRemindersEnabled,
          onChanged: (v) => setState(() => _localRemindersEnabled = v),
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          title: const Text('Missed Dose Alert'),
          subtitle: const Text('Notify account holder if dose is missed'),
          value: _missedDoseAlertEnabled,
          onChanged: (v) => setState(() => _missedDoseAlertEnabled = v),
        ),
      ],
    );
  }

  Widget _buildExtrasStep() {
    return Column(
      children: [
        TextFormField(
          controller: _stockController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Current Stock (Pills)',
            prefixIcon: Icon(Icons.medication_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _refillAtController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Refill Reminder At (Pills Left)',
            prefixIcon: Icon(Icons.refresh),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _doctorController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Doctor Name (optional)',
            prefixIcon: Icon(Icons.medical_services_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _instructionsController,
          maxLines: 3,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Special Instructions (optional)',
            prefixIcon: Icon(Icons.notes),
            alignLabelWithHint: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
        ),
      ],
    );
  }
}
