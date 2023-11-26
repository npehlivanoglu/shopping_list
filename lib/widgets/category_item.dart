import 'package:flutter/material.dart';
import 'package:shopping_list/models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
    this.category, {
    super.key,
  });
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          color: category.color,
          margin: const EdgeInsets.all(5),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(category.name)
      ],
    );
  }
}
