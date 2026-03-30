import 'package:food_hub/features/home/data/data source/home_remote_ds.dart';
import 'package:food_hub/features/home/domain/entity/category_entity.dart';
import 'package:food_hub/features/home/domain/entity/meal_entity.dart';
import 'package:food_hub/features/home/domain/entity/recipe_entity.dart';
import 'package:food_hub/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDs remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<List<CategoryEntity>> categories() async {
    final result = await remote.categories();
    return result;
  }

  @override
  Future<List<RecipeEntity>> recipes() async{
    final result = await remote.recipes();
    return result ;
  }

  @override
  Future<List<MealEntity>> meals(String category) async{
    final result = await remote.meals(category);
    return result ;
  }
}