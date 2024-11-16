import 'package:flutter/material.dart';
import 'package:app_tentify_frfr/shared/models/user.dart';
import 'package:app_tentify_frfr/shared/services/authService.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  User? _currentUser;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _profilePictureUrlController = TextEditingController();
  bool _isPasswordVerified = false;
  bool _isChangingPassword = false;

  @override
  void initState() {
    super.initState();
    _currentUser = _authService.getCurrentUser();
    if (_currentUser != null) {
      _nameController.text = _currentUser!.name ?? '';
      _emailController.text = _currentUser!.email;
      _bioController.text = _currentUser!.bio ?? '';
      _profilePictureUrlController.text = _currentUser!.profilePictureUrl ?? '';
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _currentUser = _authService.getCurrentUser(); // Update current user when dependencies change

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildProfilePicture(),
              const SizedBox(height: 16),
              buildTextField("Name", _nameController),
              const SizedBox(height: 16),
              buildTextField("Email", _emailController),
              const SizedBox(height: 16),
              buildTextField("Bio", _bioController),
              const SizedBox(height: 16),
              buildTextField("Profile Picture URL", _profilePictureUrlController),
              const SizedBox(height: 16),
              buildPasswordFields(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_currentUser != null) {
                      _currentUser!.name = _nameController.text;
                      _currentUser!.email = _emailController.text;
                      _currentUser!.bio = _bioController.text;
                      _currentUser!.profilePictureUrl = _profilePictureUrlController.text;
                      if (_isChangingPassword) {
                        if (_isPasswordVerified && _newPasswordController.text.isNotEmpty) {
                          _currentUser!.password = _newPasswordController.text;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please verify your current password and enter a new password')),
                          );
                          return;
                        }
                      }
                      await _authService.updateUser(_currentUser!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated successfully')),
                      );
                    }
                  }
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfilePicture() {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Image.network(
              _currentUser?.profilePictureUrl ?? '',
              width: 128,
              height: 128,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(),
          ),
        ],
      ),
    );
  }

  Widget buildEditIcon() {
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(3),
        color: Colors.white,
        child: ClipOval(
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.orangeAccent,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }

  Widget buildPasswordFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Change Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text("Change Password"),
          value: _isChangingPassword,
          onChanged: (bool value) {
            setState(() {
              _isChangingPassword = value;
              _isPasswordVerified = false;
              _currentPasswordController.clear();
              _newPasswordController.clear();
            });
          },
        ),
        if (_isChangingPassword) ...[
          if (!_isPasswordVerified)
            buildTextField("Current Password", _currentPasswordController),
          if (_isPasswordVerified) ...[
            buildTextField("New Password", _newPasswordController),
            const SizedBox(height: 16),
          ],
          ElevatedButton(
            onPressed: () {
              if (!_isPasswordVerified) {
                // Verify current password
                if (_currentPasswordController.text == _currentUser?.password) {
                  setState(() {
                    _isPasswordVerified = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect current password')),
                  );
                }
              }
            },
            child: Text(_isPasswordVerified ? "Change Password" : "Verify Password"),
          ),
        ],
      ],
    );
  }
}