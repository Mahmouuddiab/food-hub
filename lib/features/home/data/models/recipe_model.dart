import 'package:food_hub/features/home/domain/entity/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel({
    required super.id,
    required super.name,
    required super.ingredients,
    required super.instructions,
    required super.prepTimeMinutes,
    required super.cookTimeMinutes,
    required super.servings,
    required super.difficulty,
    required super.cuisine,
    required super.caloriesPerServing,
    required super.tags,
    required super.userId,
    required super.image,
    required super.rating,
    required super.reviewCount,
    required super.mealType,
  });


  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      ingredients: List<String>.from(json['ingredients'] as List<dynamic>),
      instructions: List<String>.from(json['instructions'] as List<dynamic>),
      prepTimeMinutes: json['prepTimeMinutes'] as int,
      cookTimeMinutes: json['cookTimeMinutes'] as int,
      servings: json['servings'] as int,
      difficulty: json['difficulty'] as String,
      cuisine: json['cuisine'] as String,
      caloriesPerServing: json['caloriesPerServing'] as int,
      tags: List<String>.from(json['tags'] as List<dynamic>),
      userId: json['userId'] as int,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      mealType: List<String>.from(json['mealType'] as List<dynamic>),
    );
  }

}