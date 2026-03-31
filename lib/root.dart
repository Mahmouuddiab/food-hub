import 'package:flutter/material.dart';
import 'package:food_hub/core/utils/app_colors.dart';
import 'package:food_hub/features/auth/presentation/screen/profile_screen.dart';
import 'package:food_hub/features/home/presentation/screens/home_screen.dart';
import 'package:food_hub/features/home/presentation/screens/meals_by_category_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    MealsByCategoryScreen(),
    Center(child: Text('Favorites')),
    ProfileScreen(),
  ];

  final List<IconData> icons = [
    Icons.home_filled,
    Icons.category_outlined,
    Icons.favorite,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            icons.length,
                (index) => _navItem(icons[index], index),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.gray,
              size: isSelected ? 28 : 24,
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  height: 4,
                  width: 16,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}