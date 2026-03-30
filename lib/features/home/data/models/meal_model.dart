import 'package:food_hub/features/home/domain/entity/meal_entity.dart';

class MealModel extends MealEntity {
  MealModel({
    required super.id,
    required super.name,
    required super.image,
  });


  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      image: json['strMealThumb'] as String,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strMealThumb': image,
    };
  }
}