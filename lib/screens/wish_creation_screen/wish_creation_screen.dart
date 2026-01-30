import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../firebase_data/firestore_service.dart';
import '../../models/wish.dart';
import 'widgets/wish_form.dart';

class WishCreationScreen extends StatefulWidget {
  final String initialProductName;
  final String userId;
  final Wish? existingWish;
  final String? initialListId;
  final String? initialReason;

  const WishCreationScreen({
    super.key,
    this.initialProductName = '',
    required this.userId,
    this.existingWish,
    this.initialListId,
    this.initialReason,
  });

  @override
  _WishCreationScreenState createState() => _WishCreationScreenState();
}

class _WishCreationScreenState extends State<WishCreationScreen> {
  late TextEditingController _nameController;
  final _productLinkController = TextEditingController();
  final _notesController = TextEditingController();
  final _giftDateController = TextEditingController();

  final _dateFormat = DateFormat('dd.MM.yyyy');
  final _dateMaskFormatter = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  DateTime? _giftDate;
  String? _selectedReason;
  bool _rememberDate = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.existingWish?.title ?? widget.initialProductName,
    );

    if (widget.existingWish != null) {
      _productLinkController.text = widget.existingWish!.link ?? '';
      _notesController.text = widget.existingWish!.notes ?? '';
      _selectedReason = widget.existingWish!.reason;
      if (widget.existingWish!.date != null) {
        _giftDate = widget.existingWish!.date;
        _giftDateController.text = _dateFormat.format(_giftDate!);
      }
    }
  }


  void _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _giftDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      setState(() {
        _giftDate = selected;
        _giftDateController.text = _dateFormat.format(selected);
      });
    }
  }

  void _saveWish() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a product name')),
      );
      return;
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      String listId;
      String? reason;

      if (widget.existingWish != null && widget.existingWish!.listId.isNotEmpty) {
        listId = widget.existingWish!.listId;
        reason = widget.existingWish!.reason;
      } else if (widget.initialListId != null && widget.initialListId!.isNotEmpty) {
        listId = widget.initialListId!;
        reason = widget.initialReason ?? _selectedReason;
      } else {
        reason = _selectedReason;
        listId = reason != null
            ? reason.toLowerCase().replaceAll(' ', '_').replaceAll('`', '')
            : 'other';
      }

      final newWish = Wish(
        id: widget.existingWish?.id ?? '',
        userId: currentUser.uid,
        title: _nameController.text.trim(),
        listId: listId,
        reason: reason,
        link: _productLinkController.text.trim(),
        notes: _notesController.text.trim(),
        date: _giftDate,
      );

      final firestoreService = FirestoreService();


      if (widget.existingWish != null && widget.existingWish!.id.isNotEmpty) {
        await firestoreService.updateWish(
          currentUser.uid,
          widget.existingWish!.id,
          newWish,
        );
      } else {
        await firestoreService.saveWish(newWish);
      }

      if (mounted) Navigator.pop(context);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving wish: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingWish == null ? 'Create Wish' : 'Edit Wish'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: WishForm(
          nameController: _nameController,
          linkController: _productLinkController,
          notesController: _notesController,
          dateController: _giftDateController,
          selectedReason: _selectedReason,
          rememberDate: _rememberDate,
          dateMaskFormatter: _dateMaskFormatter,
          isEditing: widget.existingWish != null,
          onReasonChanged: (val) => setState(() => _selectedReason = val),
          onRememberDateChanged: (val) => setState(() => _rememberDate = val ?? false),
          onPickDate: _pickDate,
          onSave: _saveWish,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _productLinkController.dispose();
    _notesController.dispose();
    _giftDateController.dispose();
    super.dispose();
  }
}
