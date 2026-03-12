import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ProfileController {
  final StorageService _storageService = StorageService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController goalController = TextEditingController();

  Future<void> loadProfileData() async {
    final data = await _storageService.getProfile();

    nameController.text = data['name'] ?? '';
    ageController.text = data['age'] ?? '';
    weightController.text = data['weight'] ?? '';
    goalController.text = data['goal'] ?? '';
  }

  Future<void> saveData() async {
    await _storageService.saveProfile(
      nameController.text,
      ageController.text,
      weightController.text,
      goalController.text,
    );
  }

  void dispose() {
    nameController.dispose();
    ageController.dispose();
    weightController.dispose();
    goalController.dispose();
  }
}
