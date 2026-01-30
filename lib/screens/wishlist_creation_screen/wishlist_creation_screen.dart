import 'package:flutter/material.dart';
import 'package:wishlist/data/gift_reasons.dart';
import 'package:wishlist/firebase_data/firestore_service.dart';
import 'package:wishlist/models/wish_list.dart';
import 'package:wishlist/screens/wishlist_creation_screen/widgets/wishlist_form_body.dart';



class WishlistCreationScreen extends StatefulWidget {
  final String userId;

  const WishlistCreationScreen({super.key, required this.userId});

  @override
  State<WishlistCreationScreen> createState() => _WishlistCreationScreenState();
}

class _WishlistCreationScreenState extends State<WishlistCreationScreen> {
  final _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  String? _selectedImage;
  bool _enableReservations = false;
  bool _isSaving = false;

  void _updateSelectedImage(String title) {
    if (GiftReasonHelper.reasonImages.containsKey(title)) {
      setState(() {
        _selectedImage = GiftReasonHelper.reasonImages[title];
      });
    } else {
      _selectedImage = null;
    }
    setState(() {});
  }

  Future<void> _saveWishlist() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    setState(() => _isSaving = true);

    final newWishlist = Wishlist(
      id: '',
      userId: widget.userId,
      title: title,
      image: _selectedImage,
      enableReservations: _enableReservations,
    );

    try {
      final createdId = await _firestoreService.addWishlist(newWishlist);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wishlist created successfully!')),
        );
        Navigator.of(context).pop(createdId);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save list: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }


  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      _updateSelectedImage(_titleController.text);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create wish list')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: WishlistFormBody(
          formKey: _formKey,
          titleController: _titleController,
          selectedImage: _selectedImage,
          enableReservations: _enableReservations,
          isSaving: _isSaving,
          onTitleChanged: (val) {
            _titleController.text = val;
            _updateSelectedImage(val);
          },
          onReservationsChanged: (val) => setState(() => _enableReservations = val),
          onSave: _saveWishlist,
        ),
      ),
    );
  }


}

















