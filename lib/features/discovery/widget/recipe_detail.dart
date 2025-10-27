import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, String> recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        // To change the overall padding around the content
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe name text - To edit formatting: change fontSize for size, fontWeight for boldness, color for text color
              Text(
                recipe['name'] ?? 'Recipe Name',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Recipe time text formatting
              Text(
                'Time: ${recipe['time'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              // Main recipe content text formatting
              const Text(
                'Ingredients:\n\n- Ingredient 1\n- Ingredient 2\n- Ingredient 3\n- Ingredient 4\n\n Nutritional Info: \n\n Calories: XX\n\n Fat:XX\n    Unsaturated Fats:XX\n    Saturated Fats:XX\n    Trans Fats:XX\n\n Carbohydrates:XX\n    Dietery Fiber:XX\n    Sugars:XX\n\n Protein:XX\n Salt:XX\n\n Instructions:\n\n RECIPE INFO INSERTED HERE \n\n',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
