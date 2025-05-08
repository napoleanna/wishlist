import 'package:flutter/material.dart';
import '../widgets/category_widgets.dart';
import '../widgets/all_products_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const CategoryTabs(),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    selectedCategory == null
                        ? CategoryGrid(
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    )
                        : GroupList(
                      category: selectedCategory!,
                      onBack: () {
                        setState(() {
                          selectedCategory = null;
                        });
                      },
                    ),
                    const AllProductsView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
