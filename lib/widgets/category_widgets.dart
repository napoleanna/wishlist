import 'package:flutter/material.dart';

import '../data/categories.dart';
import '../data/categories_list.dart';
import 'category_tile.dart';

class CategoryGrid extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryGrid({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onCategorySelected(categories[index].name),
          child: CategoryTile(category: categories[index]),
        );
      },
    );
  }
}

class GroupList extends StatelessWidget {
  final String category;
  final VoidCallback onBack;

  const GroupList({
    super.key,
    required this.category,
    required this.onBack});

  @override
  Widget build(BuildContext context) {
    final groups = categoryGroups[category] ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  title: Text(
                      groups[index],
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  leading: const Icon(Icons.category, color: Color(0xFF8a4f75),),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      indicatorColor: Color(0xFFac829d),
      labelColor: Color(0xFF8a4f75),
      unselectedLabelColor: Color(0xFF3b2848),
      tabs: [
        Tab(text: 'Categories'),
        Tab(text: 'All product'),
      ],
    );
  }
}
