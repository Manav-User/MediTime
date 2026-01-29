import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Medicine {
  final int id;
  final String name;
  final String image;
  final String dose;

  Medicine({
    required this.id,
    required this.name,
    required this.image,
    required this.dose,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'dose': dose,
      };

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json['id'] as int,
        name: json['name'] as String,
        image: json['image'] as String,
        dose: json['dose'] as String,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Medicine &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image &&
          dose == other.dose;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ image.hashCode ^ dose.hashCode;
}

class LocalStorageService {
  static const String _fileName = 'medicines.json';
  late File _file;

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _file = File('${directory.path}/$_fileName');
  }

  Future<List<Medicine>> getAllMedicines() async {
    try {
      if (!await _file.exists()) {
        return [];
      }

      final contents = await _file.readAsString();
      if (contents.isEmpty) {
        return [];
      }

      final jsonData = jsonDecode(contents) as List;
      return jsonData
          .map(
              (medicine) => Medicine.fromJson(medicine as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error reading medicines: $e');
      return [];
    }
  }

  Future<int> insertMedicine(Medicine medicine) async {
    try {
      final medicines = await getAllMedicines();

      // Generate new ID
      int newId = medicines.isEmpty
          ? 1
          : (medicines.map((m) => m.id).reduce((a, b) => a > b ? a : b) + 1);

      final newMedicine = Medicine(
        id: newId,
        name: medicine.name,
        image: medicine.image,
        dose: medicine.dose,
      );

      medicines.add(newMedicine);
      await _saveMedicines(medicines);

      return newId;
    } catch (e) {
      print('Error inserting medicine: $e');
      rethrow;
    }
  }

  Future<bool> updateMedicine(Medicine medicine) async {
    try {
      final medicines = await getAllMedicines();
      final index = medicines.indexWhere((m) => m.id == medicine.id);

      if (index == -1) {
        return false;
      }

      medicines[index] = medicine;
      await _saveMedicines(medicines);

      return true;
    } catch (e) {
      print('Error updating medicine: $e');
      rethrow;
    }
  }

  Future<int> deleteMedicine(Medicine medicine) async {
    try {
      final medicines = await getAllMedicines();
      final initialLength = medicines.length;
      medicines.removeWhere((m) => m.id == medicine.id);

      await _saveMedicines(medicines);

      return initialLength - medicines.length;
    } catch (e) {
      print('Error deleting medicine: $e');
      rethrow;
    }
  }

  Future<void> _saveMedicines(List<Medicine> medicines) async {
    try {
      final jsonData = jsonEncode(medicines.map((m) => m.toJson()).toList());
      await _file.writeAsString(jsonData);
    } catch (e) {
      print('Error saving medicines: $e');
      rethrow;
    }
  }

  Future<void> clearAllMedicines() async {
    try {
      if (await _file.exists()) {
        await _file.delete();
      }
    } catch (e) {
      print('Error clearing medicines: $e');
    }
  }
}
