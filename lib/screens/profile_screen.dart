import 'package:flutter/material.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController = TextEditingController(
      text: 'Username');
  bool _isEditing = false;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveName() {
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('My Profile', style: TextStyle(fontSize: 24)),
        actions: [
          _settingsButton(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('lib/assets/images/profile_screen.webp'),
                  ),
                  SizedBox(height: 20),
                  _isEditing
                      ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: TextField(
                      controller: _nameController,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  )
                      : GestureDetector(
                    onTap: _toggleEditing,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _nameController.text,
                        style: TextStyle(fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  if (_isEditing)
                    ElevatedButton(
                      onPressed: _saveName,
                      child: Text('Save'),
                    ),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text('Edit account',
                            style: TextStyle(color: Colors.white)),
                        ),

                    ],
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _settingsButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        print("Settings button pressed");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsScreen()));
      },
    );
  }
}