import 'package:food_hub/features/home/domain/entity/recipe_entity.dart';
import 'package:food_hub/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecipeUseCase {
  HomeRepository repository;
  GetRecipeUseCase(this.repository);
  Future<List<RecipeEntity>> call()=> repository.recipes();
}