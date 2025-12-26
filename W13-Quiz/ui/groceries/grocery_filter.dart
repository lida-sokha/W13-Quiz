import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';

class FilterGrocery extends StatefulWidget {
  const FilterGrocery({super.key});

  @override
  State<FilterGrocery> createState() => _GroceryFilterState();
}

class _GroceryFilterState extends State<FilterGrocery> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filterGroceries = dummyGroceryItems.where((grocery) {
      return grocery.name.toLowerCase().startsWith(searchText.toLowerCase());
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Your Groceries')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: filterGroceries.isEmpty
                ? const Center(child: Text('No groceries found'))
                : ListView.builder(
                    itemCount: filterGroceries.length,
                    itemBuilder: (context, index) {
                      final grocery = filterGroceries[index];
                      return ListTile(
                        leading: Container(
                          width: 15,
                          height: 15,
                          color: grocery.category.color,
                        ),
                        title: Text(grocery.name),
                        trailing: Text(grocery.quantity.toString()),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
