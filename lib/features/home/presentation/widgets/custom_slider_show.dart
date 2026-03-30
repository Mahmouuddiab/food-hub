import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:food_hub/core/utils/app_colors.dart';

class CursorSlideShow extends StatelessWidget {
  const CursorSlideShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
            children: [
            ImageSlideshow(
              width: double.infinity,
              height: 200,
              initialPage: 0,
              indicatorColor: AppColors.primary,
              indicatorBackgroundColor: AppColors.gray.withOpacity(0.4),
              autoPlayInterval: 2000,
              isLoop: true,
              indicatorRadius: 4,
              children: [
                _buildSlide("assets/banner2.jpeg"),
                _buildSlide("assets/banner3.jpeg"),
                _buildSlide("assets/banner4.jpeg"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(String asset) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          asset,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}