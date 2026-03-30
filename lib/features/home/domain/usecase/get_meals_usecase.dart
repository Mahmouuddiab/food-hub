import 'package:food_hub/features/home/domain/entity/meal_entity.dart';
import 'package:food_hub/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealsUseCase {
  HomeRepository repository;
  GetMealsUseCase(this.repository);
  Future<List<MealEntity>> call(String category)=> repository.meals(category);
}