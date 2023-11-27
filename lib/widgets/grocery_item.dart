import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
    this.groceryItem, {
    Key? key,
  }) : super(key: key);

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // First sub-row for category information
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 24,
              width: 24,
              color: groceryItem.category.color,
              margin: const EdgeInsets.all(5),
            ),
            const SizedBox(width: 20),
            Text(groceryItem.category.name),
            const SizedBox(width: 20),
          ],
        ),
        
        // Second sub-row for quantity information with left margin
        Container(
          margin: const EdgeInsets.only(right: 10), // Adjust the margin as needed
          child: Text(groceryItem.quantity.toString()),
        ),
      ],
    );
  }
}
