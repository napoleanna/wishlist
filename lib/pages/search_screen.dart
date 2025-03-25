import 'package:flutter/material.dart';
import 'package:wishlist/models/category.dart';
import '../widgets/category_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Category> categories = [
    Category(name: 'Beauty', imagePath: 'lib/assets/images/beauty.webp'),
    Category(name: 'Bags', imagePath: 'lib/assets/images/bag.webp'),
    Category(name: 'Electronics',
        imagePath: 'lib/assets/images/electronics.webp'),
    Category(name: 'Games', imagePath: 'lib/assets/images/games.webp'),
    Category(name: 'Health', imagePath: 'lib/assets/images/health.webp'),
    Category(name: 'Toys for adults',
        imagePath: 'lib/assets/images/toys_for_adults.webp'),
    Category(name: 'Jewelry', imagePath: 'lib/assets/images/jewelry.webp'),
    Category(name: 'Clothing', imagePath: 'lib/assets/images/dress.webp'),
    Category(name: 'Home appliances',
        imagePath: 'lib/assets/images/home_appliances.webp'),
    Category(name: 'Children`s goods',
        imagePath: 'lib/assets/images/children_goods.webp'),
    Category(name: 'Pets', imagePath: 'lib/assets/images/pets.webp'),
    Category(name: 'Books', imagePath: 'lib/assets/images/books.webp'),
    Category(name: 'Hobbies/creativity',
        imagePath: 'lib/assets/images/hobbies_creativity.webp'),
    Category(name: 'Auto/motorcycles',
        imagePath: 'lib/assets/images/auto.webp'),
    Category(name: 'Sports and recreation',
        imagePath: 'lib/assets/images/sports_recreation.webp'),
    Category(name: 'Home', imagePath: 'lib/assets/images/for_home.webp'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for wishes...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
          ),
          onChanged: (query) {
            // Добавь логику поиска
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Количество колонок
                  crossAxisSpacing: 10, // Отступы между колонками
                  mainAxisSpacing: 10, // Отступы между строками
                  childAspectRatio: 1, // Соотношение сторон (квадрат)
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(category: categories[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
