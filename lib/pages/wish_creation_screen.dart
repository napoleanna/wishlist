import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wishlist/data/gift_reasons.dart';

class WishCreationScreen extends StatefulWidget {
  final String initialProductName;

  const WishCreationScreen({super.key, required this.initialProductName});

  @override
  _WishCreationScreenState createState() => _WishCreationScreenState();
}

class _WishCreationScreenState extends State<WishCreationScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productLinkController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _selectedReason;
  
  @override
  void initState() {
    super.initState();
    _productNameController.text = widget.initialProductName;
  }

  void _saveWish() {
    if ( _productNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    FirebaseFirestore.instance.collection('wishes').add({
      'name': _productNameController.text,
      'reason': _selectedReason,
      'link': _productLinkController.text,
      'notes': _notesController.text,
      'created_at': Timestamp.now(),
    });

    Navigator.pop(context);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Creat wish')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _productNameController,
            decoration: const InputDecoration(labelText: 'Wish name'),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Reason for a gift'),
              items: giftReasons.map((reason) {
                return DropdownMenuItem(value: reason, child: Text(reason));
              }).toList(),
              onChanged: (value) => setState(() => _selectedReason = value),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _productLinkController,
            decoration:  const InputDecoration(labelText: 'Wish link'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Notes (color, size, etc.)'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveWish,
            child: const Text('Save'),
          ),
        ],
      ),
      ),
    );
  }
}
