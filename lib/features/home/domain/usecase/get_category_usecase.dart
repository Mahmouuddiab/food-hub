import 'package:food_hub/features/home/domain/entity/category_entity.dart';
import 'package:food_hub/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryUseCase {
  HomeRepository repository;
  GetCategoryUseCase(this.repository);
  Future<List<CategoryEntity>> call()=> repository.categories();
}