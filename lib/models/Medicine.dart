import 'package:medicinereminder/notifications/NotificationManager.dart';
import 'package:medicinereminder/storage/local_storage_service.dart';

import '../enums/icon_enum.dart';
import 'package:scoped_model/scoped_model.dart';

class MedicineModel extends Model with IconMixin {
  final LocalStorageService _storage = LocalStorageService();
  final NotificationManager notificationManager = NotificationManager();

  MedicineModel() {
    _initializeStorage();
  }

  Future<void> _initializeStorage() async {
    await _storage.init();
  }

  Future<List<Medicine>> getMedicineList() async {
    return await _storage.getAllMedicines();
  }

  LocalStorageService getStorage() {
    return _storage;
  }

  void toggleIconState() {
    toggleState();
    notifyListeners();
  }

  DeleteIconState getIconState() {
    return getCurrentIconState();
  }

  void refreshList() {
    notifyListeners();
  }
}

mixin IconMixin {
  var iconState = DeleteIconState.hide; // default

  void toggleState() {
    if (iconState == DeleteIconState.hide) {
      iconState = DeleteIconState.show;
    } else {
      iconState = DeleteIconState.hide;
    }
  }

  DeleteIconState getCurrentIconState() {
    return iconState;
  }
}
