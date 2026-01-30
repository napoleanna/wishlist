import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/models/user_profile.dart';
import 'package:wishlist/screens/profile_screen/widgets/profile_settings.dart';
import 'package:wishlist/services/profile_service.dart';
import 'package:wishlist/screens/profile_screen/widgets/profile_form.dart';
import 'package:wishlist/screens/profile_screen/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _service = ProfileService();
  final _nicknameController = TextEditingController();

  DateTime? _birthDate;
  String _selectedAvatar = 'assets/avatars/avatar_start.png';
  bool _isProfileComplete = false;
  bool _isLoading = true;


  final List<String> avatarPaths = [
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
  ];

 @override
  void initState() {
   super.initState();
     _loadProfile();
 }



Future<void> _loadProfile() async {
  setState(() => _isLoading = true);
  try {
    final  UserProfile? profile = await _service.loadProfile();
    if (profile != null) {
      _nicknameController.text = profile.nickname;
      _birthDate = profile.birthDate;
      _selectedAvatar = profile.avatar;
      _isProfileComplete = profile.nickname.isNotEmpty && profile.birthDate != null;
    } else {
      _isProfileComplete = false;
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error loading profile: $e')));
  } finally {
    setState(() => _isLoading = false);
  }
}


Future<void> _saveProfile() async {
   final user = FirebaseAuth.instance.currentUser;
   if (user == null) return;

   if (_nicknameController.text.trim().isEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Please enter a nickname')),
     );
     return;
   }


   final profile = UserProfile(
       nickname: _nicknameController.text.trim(),
       birthDate: _birthDate,
       avatar: _selectedAvatar,
       email: user.email,
   );

   showDialog(
       context: context,
       barrierDismissible: false,
       builder: (_) => const Center(child: CircularProgressIndicator())
   );

   try {
     await _service.saveProfile(profile);
     setState(() => _isProfileComplete = true);
   } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text('Error saving profile: $e')));
   } finally {
     if (Navigator.of(context).canPop()) Navigator.of(context).pop();
   }

}

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isProfileComplete) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8F4FB),
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
           IconButton(
               onPressed: () => FirebaseAuth.instance.signOut(),
               icon: const Icon(Icons.logout)),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProfileHeader(
                  avatarPath: _selectedAvatar,
                  nickname: _nicknameController.text,
                  birthDate: _birthDate,
                  onEdit: () => setState(() => _isProfileComplete = false),
                  ),
                  const SizedBox(height: 30),
                  const ProfileSettings(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FB),
      appBar: AppBar(
        title: const Text('Create Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ProfileForm(
            nicknameController: _nicknameController,
            birthDate: _birthDate,
            selectedAvatar: _selectedAvatar,
            avatarPaths: avatarPaths,
            onPickDate: () async {
              final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());
              if (date != null) setState(() => _birthDate = date);
            },
            onAvatarChanged: (path) => setState(() => _selectedAvatar = path),
            onSave: _saveProfile,
            isSaving: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

}

