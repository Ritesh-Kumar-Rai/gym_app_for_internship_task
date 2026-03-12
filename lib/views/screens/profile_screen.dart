import 'package:flutter/material.dart';
import "../../controllers/profile_controller.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final StorageService _storageService = StorageService();

  // // Controllers for input fields [cite: 61, 62, 63, 64]
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _weightController = TextEditingController();
  // final TextEditingController _goalController = TextEditingController();
  /*
  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Fetch data when screen opens [cite: 69]
  }

  // Requirement: Data should persist after app restart [cite: 69]
  Future<void> _loadProfileData() async {
    final data = await _storageService.getProfile();
    setState(() {
      _nameController.text = data['name']!;
      _ageController.text = data['age']!;
      _weightController.text = data['weight']!;
      _goalController.text = data['goal']!;
    });
  }

  // Requirement: User must be able to update and store data locally [cite: 66, 68]
  Future<void> _saveData() async {
    await _storageService.saveProfile(
      _nameController.text,
      _ageController.text,
      _weightController.text,
      _goalController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile Updated Locally!"),
        backgroundColor: Color(0xFFCCFF00),
      ),
    );
  }*/

  // new one after refactoring the code to MVC controller
  final ProfileController _controller = new ProfileController();

  @override
  void initState() {
    super.initState();
    _controller.loadProfileData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSave() async {
    await _controller.saveData();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile Updated Locally!"),
        backgroundColor: Color(0xFFCCFF00),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Your Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1A1A1A),
              child: Icon(Icons.person, size: 50, color: Color(0xFFCCFF00)),
            ),
            const SizedBox(height: 30),
            _buildTextField("Name", _controller.nameController),
            _buildTextField("Age", _controller.ageController, isNumber: true),
            _buildTextField(
              "Weight (kg)",
              _controller.weightController,
              isNumber: true,
            ),
            _buildTextField("Fitness Goal", _controller.goalController),
            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCCFF00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                // onPressed: _saveData,
                onPressed: _handleSave,
                child: const Text(
                  "UPDATE PROFILE",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFCCFF00)),
          ),
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
        ),
      ),
    );
  }
}
