import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/models/grocery.dart';
//import 'package:shopping_list/providers/grocery_items_provider.dart';
import 'package:shopping_list/widgets/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProductListScreenState();
  }
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final List<GroceryItem> _newList = [];
  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const NewItem()),
      ),
    );
    if (newItem == null) {
      return null;
    }

    setState(() {
      _newList.add(newItem);
    });
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
