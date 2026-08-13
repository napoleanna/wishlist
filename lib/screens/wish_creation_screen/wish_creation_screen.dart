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
  State<WishCreationScreen> createState() => _WishCreationScreenState();
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
      _rememberDate = widget.existingWish!.rememberDate;
      if (widget.existingWish!.date != null) {
        _giftDate = widget.existingWish!.date;
        _giftDateController.text = _dateFormat.format(_giftDate!);
      }
    }

    _nameController.addListener(_updateState);
    _productLinkController.addListener(_updateState);
    _notesController.addListener(_updateState);
    _giftDateController.addListener(_updateState);
  }

  void _updateState() {
    if (mounted) {
      setState(() { });
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
        rememberDate: _rememberDate,
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
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving wish: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(

      body:  SafeArea(
          child: Stack(
            children: [
              Padding(
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

              Positioned(
                top: 12,
                  left: 16,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white.withValues(alpha: 0.07) 
                            : Colors.black.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDarkMode ? Colors.white : Colors.black87,
                        size: 18,
                      ),
                    ),
                  ),
              ),
            ],
          ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateState);
    _productLinkController.removeListener(_updateState);
    _notesController.removeListener(_updateState);
    _giftDateController.removeListener(_updateState);

    _nameController.dispose();
    _productLinkController.dispose();
    _notesController.dispose();
    _giftDateController.dispose();
    super.dispose();
  }
}
