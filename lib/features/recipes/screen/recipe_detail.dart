

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/recipes/managers/recipe_bloc.dart';
import 'package:foodly_backup/features/recipes/managers/recipe_event.dart';
import 'package:foodly_backup/features/recipes/managers/recipe_state.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeName;
  const RecipeDetailScreen({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeDetailBloc()..add(LoadRecipeDetail(recipeName)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            recipeName,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
            if (state is RecipeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecipeError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else if (state is RecipeLoaded) {
              final recipe = state.recipe;
              final ingredients = recipe['ingredients'] as List?;
              final instructions = recipe['instructions'] as List?;
              final nutrition = recipe['nutrition'] as Map?;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    if (recipe['image'] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          recipe['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 220,
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Name
                    Text(
                      recipe['name'] ?? 'Recipe',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Time
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          recipe['time'] ?? 'N/A',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const Divider(height: 32, thickness: 1),

                    // Ingredients
                    const Text(
                      'Ingredients',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...?ingredients?.map(
                          (i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text('• $i',
                            style: const TextStyle(fontSize: 15)),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Instructions
                    const Text(
                      'Instructions',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...?instructions?.map(
                          (s) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          s,
                          style: const TextStyle(height: 1.5, fontSize: 15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Nutrition
                    const Text(
                      'Nutrition Facts',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (nutrition != null) ...[
                      Text('Calories: ${nutrition['calories']} kcal'),
                      Text('Fat: ${nutrition['fat']} g'),
                      Text('Carbohydrates: ${nutrition['carbohydrates']} g'),
                      Text('Protein: ${nutrition['protein']} g'),
                    ],
                  ],
                ),
              );
            }

            // Default / initial state
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
