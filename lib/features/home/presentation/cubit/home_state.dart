import 'package:food_hub/features/home/domain/entity/category_entity.dart';
import 'package:food_hub/features/home/domain/entity/meal_entity.dart';
import 'package:food_hub/features/home/domain/entity/recipe_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<CategoryEntity> categories;
  final List<RecipeEntity> recipes;
  final List<MealEntity> meals;
  final bool isMealsLoading;

  HomeSuccess({
    required this.categories,
    required this.recipes,
    required this.meals,
    this.isMealsLoading = false,
  });

  HomeSuccess copyWith({
    List<CategoryEntity>? categories,
    List<RecipeEntity>? recipes,
    List<MealEntity>? meals,
    bool? isMealsLoading,
  }) {
    return HomeSuccess(
      categories: categories ?? this.categories,
      recipes: recipes ?? this.recipes,
      meals: meals ?? this.meals,
      isMealsLoading: isMealsLoading ?? this.isMealsLoading,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}