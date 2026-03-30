import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/core/di/di.dart';
import 'package:food_hub/features/home/presentation/cubit/home_cubit.dart';
import 'package:food_hub/features/home/presentation/cubit/home_state.dart';
import 'package:food_hub/features/home/presentation/widgets/category_tabs.dart';
import 'package:food_hub/features/home/presentation/widgets/meal_grid_item.dart';
import 'package:food_hub/shared/app_loading.dart';

class MealsByCategoryScreen extends StatefulWidget {
  const MealsByCategoryScreen({super.key});

  @override
  State<MealsByCategoryScreen> createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  int selectedIndex = 0;
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = getIt<HomeCubit>();
    homeCubit.getHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const AppLoading();
        }

        if (state is HomeSuccess) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    /// 🔹 Category Tabs
                    CategoryTabs(
                      selectedIndex: selectedIndex,
                      categories: state.categories,
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });

                        final categoryName = state.categories[index].name;
                        homeCubit.getMeals(categoryName);
                      },
                    ),

                    const SizedBox(height: 20),

                    /// 🔹 Meals loading indicator
                    if (state.isMealsLoading)
                      const Expanded(
                        child: Center(
                          child: AppLoading(),
                        ),
                      )
                    else
                    /// 🔹 Meals Grid
                      Expanded(
                        child: state.meals.isEmpty
                            ? const Center(child: Text("No meals found"))
                            : GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: state.meals.length,
                          itemBuilder: (context, index) {
                            final meal = state.meals[index];

                            return MealGridItem(meal: meal, onFavoriteTap: (){});
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }
}