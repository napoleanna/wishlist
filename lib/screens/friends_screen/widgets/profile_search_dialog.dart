import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileSearchDialog extends StatefulWidget {
  const ProfileSearchDialog({super.key});

  @override
  State<ProfileSearchDialog> createState() => _ProfileSearchDialogState();
}

class _ProfileSearchDialogState extends State<ProfileSearchDialog> {
  final _searchController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _foundUser;
  
  Future<void> _sendFriendRequest() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || _foundUser == null) return;
    
    if (currentUser.uid == _foundUser!['uid']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You can't add yourself!"))
      );
      return;
  } 
    try {

      final myDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid).get();
      final myNickname = myDoc.data()?['nickname'] ?? 'User';

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_foundUser!['uid'])
          .collection('friend_requests')
          .doc(currentUser.uid)
          .set({
            'fromId': currentUser.uid,
            'fromNickname': myNickname,
            'timestamp': FieldValue.serverTimestamp(),
            'status': 'pending',

      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Friend request sent!'))
        );
        Navigator.pop(context);
      }
     } catch (e) {
      print("Error sending request: $e");
     }
    }

  Future<void> _searchUser() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .where('nickname', isEqualTo: query)
          .get();

      setState(() {
        _isLoading = false;
        if (result.docs.isNotEmpty) {
          _foundUser = result.docs.first.data();
          _foundUser!['uid'] = result.docs.first.id;
        } else {
          _foundUser = null;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not found')));
        }
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error searching user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF6d66b1);


    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Search a Friend',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Enter nickname',
            suffixIcon: IconButton(
                onPressed: _searchUser,
                icon: const Icon(Icons.search)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 20),
        if (_isLoading) const CircularProgressIndicator(),
        if (_foundUser != null) ...[
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(_foundUser!['avatar']
                ?? 'assets/avatars/avatar1.png'),
          ),
          const SizedBox(height: 10),
          Text(_foundUser!['nickname'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child:  ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: _sendFriendRequest,
              child: const Text('Send Friend Request',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ] else if (_searchController.text.isNotEmpty && !_isLoading)
            const Text(
                'No user found', style: TextStyle(color: Colors.redAccent)),
        ],
       ),
      ),
    );
  }
}
        
        

