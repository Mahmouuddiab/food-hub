import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/core/di/di.dart';
import 'package:food_hub/core/utils/app_sizes.dart';
import 'package:food_hub/features/home/presentation/cubit/home_cubit.dart';
import 'package:food_hub/features/home/presentation/cubit/home_state.dart';
import 'package:food_hub/features/home/presentation/screens/recipe_details_screen.dart';
import 'package:food_hub/features/home/presentation/widgets/recipe_item.dart';
import 'package:food_hub/shared/app_loading.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
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
            appBar: AppBar(
              title: Text("Recipes"),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s12,
                  vertical: AppSize.s5,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
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
