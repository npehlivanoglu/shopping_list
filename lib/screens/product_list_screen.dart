import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery.dart';
//import 'package:shopping_list/providers/grocery_items_provider.dart';
import 'package:shopping_list/widgets/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProductListScreenState();
  }
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  List<GroceryItem> _newList = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-hello-c1db1-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');
    final response = await http.get(url);

    final Map<String, dynamic> listData = json.decode(response.body);

    final List<GroceryItem> _loadedList = [];
    for (final item in listData.entries) {
      final category = categories.entries.firstWhere(
          (element) => element.value.name == item.value['category']);
      _loadedList.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category.value));
    }

    setState(() {
      _newList = _loadedList;
    });
  }

  void _addItem() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const NewItem()),
      ),
    );

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    //var groceryItems = ref.watch(groceryItemsProvider);
    Widget content = ListView.builder(
      itemCount: _newList.length,
      itemBuilder: (context, index) => CategoryItem(_newList[index]),
    );
    if (_newList.isEmpty) {
      content = const Center(
          child: Text(
        "To start add an item...",
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Grocies"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
