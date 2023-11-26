import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/category.dart';

class CategoriesProviderNotifier extends StateNotifier<List<Category>> {
  CategoriesProviderNotifier() : super([]);
}

final categoriesProvider =
    StateNotifierProvider<CategoriesProviderNotifier, List<Category>>(
        (ref) => CategoriesProviderNotifier());

final filteredCategoriesProvider = Provider((ref) {
  var allCategories = categories.values.toList();
  var dummyItems = groceryItems;
  List<Category> filteredCategories = [];
  
  for (var dummyItem in dummyItems) {
    for (var category in allCategories) {
      if(dummyItem.category == category){
        filteredCategories.add(category);
      }
    }
  }
  print(filteredCategories.length);
  return filteredCategories;
  //return categories.values.toList();
});
