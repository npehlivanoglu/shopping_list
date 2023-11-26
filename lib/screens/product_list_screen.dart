import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/providers/categories_provider.dart';
import 'package:shopping_list/widgets/category_item.dart';
class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProductListScreenState();
  }
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    var categories = ref.watch(filteredCategoriesProvider);
    var content = ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) =>
          CategoryItem(categories[index]),
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Your Grocies")),
      body: content,
    );
  }
}
