import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/providers/grocery_items_provider.dart';
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
  void _addItem() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: ((context) => const NewItem()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var groceryItems = ref.watch(groceryItemsProvider);
    var content = ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) => CategoryItem(groceryItems[index]),
    );
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
