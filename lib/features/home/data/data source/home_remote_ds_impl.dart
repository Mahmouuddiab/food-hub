import 'package:food_hub/core/helper/dio_helper.dart';
import 'package:food_hub/features/home/data/models/category_model.dart';
import 'package:food_hub/features/home/data/models/meal_model.dart';
import 'package:food_hub/features/home/data/models/recipe_model.dart';
import 'package:injectable/injectable.dart';
import 'home_remote_ds.dart';

@Injectable(as: HomeRemoteDs)
class HomeRemoteDsImpl implements HomeRemoteDs {
  @override
  Future<List<CategoryModel>> categories() async{
    final response = await DioHelper.getData(
        url: "https://www.themealdb.com/api/json/v1/1/categories.php"
    );
    if(response.statusCode == 200){
      final List data = response.data['categories'] ;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    }
    else{
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  @override
  Future<List<RecipeModel>> recipes() async{
    final response = await DioHelper.getData(
        url: "https://dummyjson.com/recipes"
    );
    if(response.statusCode == 200){
      final List data = response.data['recipes'] ;
      print("recipes => $data");
      return data.map((json) => RecipeModel.fromJson(json)).toList();
    }
    else{
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  @override
  Future<List<MealModel>> meals(String category) async {
    final response = await DioHelper.getData(
      url: "https://www.themealdb.com/api/json/v1/1/filter.php",
      queryParameters: {
        "c": category,
      },
    );

    if (response.statusCode == 200) {
      final List data = response.data['meals'];

      print("meals ($category) => $data");

      return data.map((json) => MealModel.fromJson(json)).toList();
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

}