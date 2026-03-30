import 'package:food_hub/features/home/domain/entity/category_entity.dart';
import 'package:food_hub/features/home/domain/entity/meal_entity.dart';
import 'package:food_hub/features/home/domain/entity/recipe_entity.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> categories();
  Future<List<RecipeEntity>> recipes();
  Future<List<MealEntity>> meals(String category);
}