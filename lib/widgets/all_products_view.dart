import 'package:flutter/material.dart';
import 'package:wishlist/screens/wish_creation_screen.dart';
import '../data/categories.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({super.key});

  @override
  _AllProductsViewState createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
   TextEditingController _searchController = TextEditingController();
  List<String> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _updateProductList();
  }

  void _updateProductList([String query = '']) {
    List<String> allProducts = categoryGroups.values.expand((list) => list).toList();
    allProducts.sort();
    setState(() {
      filteredProducts = query.isEmpty
          ? allProducts
          : allProducts.where((product) => product.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.5),
            ),
            onChanged: _updateProductList,
          ),
        ),
        Expanded(
          child: filteredProducts.isNotEmpty
              ? ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                elevation: 2,
                child: ListTile(
                  title: Text(filteredProducts[index]),
                  leading: const Icon(Icons.label, color: Color(0xFF8a4f75)),
                  onTap: () => _openWishCreation(context, filteredProducts[index]),
                ),
              );
            },
          ) :Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Product not found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height:  10),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add my new wish'),
                onPressed: () => _openWishCreation(context,
                    _searchController.text),
              ),
            ],
          )
        ),
      ],
    );
  }

  void _openWishCreation(BuildContext context, String productName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WishCreationScreen(
                initialProductName: productName),
        ),
    );
  }
}