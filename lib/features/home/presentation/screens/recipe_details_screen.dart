import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_hub/features/home/domain/entity/recipe_entity.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final RecipeEntity recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24),top: Radius.circular(24)),
                child: Image.network(
                  recipe.image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name & Cuisine
                    Text(
                      recipe.name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.cuisine,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),

                    const SizedBox(height: 12),

                    // Ratings and Reviews
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: recipe.rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 24,
                        ),
                        const SizedBox(width: 8),
                        Text('${recipe.rating.toStringAsFixed(1)} (${recipe.reviewCount} reviews)'),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Details: Servings, Prep, Cook, Calories, Difficulty
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        _buildDetailChip('Servings: ${recipe.servings}'),
                        _buildDetailChip('Prep: ${recipe.prepTimeMinutes} min'),
                        _buildDetailChip('Cook: ${recipe.cookTimeMinutes} min'),
                        _buildDetailChip('Calories: ${recipe.caloriesPerServing} cal'),
                        _buildDetailChip('Difficulty: ${recipe.difficulty}'),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Ingredients
                    const Text(
                      'Ingredients',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...recipe.ingredients.map(
                          (ingredient) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(fontSize: 18)),
                            Expanded(child: Text(ingredient, style: const TextStyle(fontSize: 16))),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Instructions
                    const Text(
                      'Instructions',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...recipe.instructions.asMap().entries.map(
                          (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${entry.key + 1}. ', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Expanded(child: Text(entry.value, style: const TextStyle(fontSize: 16))),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tags
                    if (recipe.tags.isNotEmpty) ...[
                      const Text(
                        'Tags',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: recipe.tags
                            .map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.deepOrange.shade100,
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Meal Types
                    if (recipe.mealType.isNotEmpty) ...[
                      const Text(
                        'Meal Type',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: recipe.mealType
                            .map((meal) => Chip(
                          label: Text(meal),
                          backgroundColor: Colors.green.shade100,
                        ))
                            .toList(),
                      ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for detail chips
  Widget _buildDetailChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.orange.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}