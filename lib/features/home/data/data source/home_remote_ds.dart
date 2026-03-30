import 'package:food_hub/features/home/data/models/category_model.dart';
import 'package:food_hub/features/home/data/models/meal_model.dart';
import 'package:food_hub/features/home/data/models/recipe_model.dart';

abstract class HomeRemoteDs {
  Future<List<CategoryModel>> categories();
  Future<List<RecipeModel>> recipes();
  Future<List<MealModel>> meals(String category);
}