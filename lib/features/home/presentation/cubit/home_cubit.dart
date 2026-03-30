import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/features/home/domain/usecase/get_category_usecase.dart';
import 'package:food_hub/features/home/domain/usecase/get_meals_usecase.dart';
import 'package:food_hub/features/home/domain/usecase/get_recipe_usecase.dart';
import 'package:injectable/injectable.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetCategoryUseCase getCategoryUseCase;
  final GetRecipeUseCase getRecipeUseCase;
  final GetMealsUseCase getMealsUseCase;

  HomeCubit(
      this.getCategoryUseCase,
      this.getRecipeUseCase,
      this.getMealsUseCase,
      ) : super(HomeInitial());

  // 🔥 Load initial data
  Future<void> getHome() async {
    emit(HomeLoading());

    try {
      final categories = await getCategoryUseCase();
      final recipes = await getRecipeUseCase();

      // initial state (no meals yet)
      emit(HomeSuccess(
        categories: categories,
        recipes: recipes,
        meals: [],
      ));

      // ✅ auto load first category meals
      if (categories.isNotEmpty) {
        await getMeals(categories.first.name);
      }

    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  // 🔥 Load meals based on selected category
  Future<void> getMeals(String category) async {
    if (state is HomeSuccess) {
      final current = state as HomeSuccess;

      // show loading only for meals
      emit(current.copyWith(isMealsLoading: true));

      try {
        final meals = await getMealsUseCase(category);

        emit(current.copyWith(
          meals: meals,
          isMealsLoading: false,
        ));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }
}