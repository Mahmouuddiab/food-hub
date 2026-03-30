import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/core/di/di.dart';
import 'package:food_hub/core/utils/app_sizes.dart';
import 'package:food_hub/features/home/presentation/cubit/home_cubit.dart';
import 'package:food_hub/features/home/presentation/cubit/home_state.dart';
import 'package:food_hub/features/home/presentation/screens/recipe_details_screen.dart';
import 'package:food_hub/features/home/presentation/screens/recipes_screen.dart';
import 'package:food_hub/features/home/presentation/widgets/category_item.dart';
import 'package:food_hub/features/home/presentation/widgets/custom_row_bar.dart';
import 'package:food_hub/features/home/presentation/widgets/custom_slider_show.dart';
import 'package:food_hub/features/home/presentation/widgets/recipe_item.dart';
import 'package:food_hub/shared/app_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit homeCubit = getIt<HomeCubit>();

  @override
  void initState() {
    super.initState();
    homeCubit.getHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        if (state is HomeLoading) {
          return AppLoading();
        }
        if (state is HomeSuccess) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s12,
                  vertical: AppSize.s5,
                ),
                child: Column(
                  spacing: 20,
                  children: [
                    CursorSlideShow(),
                    CustomRowBar(textOne: "Categories", textTwo: "View"),
                    SizedBox(
                      height: 170,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return CategoryItem(category: category);
                        },
                      ),
                    ),
                    CustomRowBar(
                      textOne: "Recipes",
                      textTwo: "View",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipesScreen(),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.53,
                        ),
                        itemCount: state.recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = state.recipes[index];
                          return RecipeItem(
                            recipe: recipe,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetailsScreen(recipe: recipe),
                                ),
                              );
                            },
                          );
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
