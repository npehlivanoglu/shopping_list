import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery.dart';
//import 'package:shopping_list/providers/grocery_items_provider.dart';
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
  var _isLoading = true;
  String? _error;
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
    final List<GroceryItem> loadedList = [];
    setState(() {
      _newList = loadedList;
      _isLoading = false;
      if (response.statusCode > 400) {
        _error = "something went wrong";
      }
    });

    for (final item in listData.entries) {
      final category = categories.entries.firstWhere(
          (element) => element.value.name == item.value['category']);
      loadedList.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category.value));
    }
  }

  void _addItem() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const NewItem()),
      ),
    );

    _loadItems();
  }

  void _removeItem(GroceryItem item) async {
    final index = _newList.indexOf(item);
    setState(
      () {
        _newList.remove(item);
      },
    );
    final url = Uri.https(
        'flutter-hello-c1db1-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _newList.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //var groceryItems = ref.watch(groceryItemsProvider);
    Widget content = ListView.builder(
      itemCount: _newList.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          _removeItem(_newList[index]);
        },
        key: ValueKey(_newList[index].id),
        child: ListTile(
          leading: Container(
            width: 24,
            height: 24,
            color: _newList[index].category.color,
          ),
          title: Text(_newList[index].name),
          trailing: Text(
            _newList[index].quantity.toString(),
          ),
        ),
      ),
    );
    if (_newList.isEmpty) {
      content = const Center(
          child: Text(
        "To start add an item...",
      ));
    }
    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    } else if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
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
