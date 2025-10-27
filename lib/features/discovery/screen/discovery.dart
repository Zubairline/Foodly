import 'package:flutter/material.dart';
import 'package:foodly_backup/config/utils/images.dart';
import 'package:foodly_backup/features/discovery/widget/recipe_detail.dart';
import 'package:nb_utils/nb_utils.dart';

class Discovery extends StatefulWidget {
  const Discovery({super.key});

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  static const List<String> categories = [
    'All',
    'Dinner',
    'Vegan',
    'Desserts',
    'Quick Meals',
  ]; //Category List
  static const List<Map<String, String>> recipes = [
    {
      'name': 'Grilled Chicken Salad',
      'image': grilledChickenSalad,
      'time': '15 min',
    },
    {'name': 'Vegan Bowl', 'image': saladBowl, 'time': '10 min'},
    {'name': 'Pasta Alfredo', 'image': pastaAlfredo, 'time': '25 min'},
  ]; //Recipe: <name, image, time>

  static const List<Map<String, String>> quickRecipes = [
    {'name': 'Avocado Toast', 'image': avocadoToast, 'time': '5 min'},
    {'name': 'Smoothie', 'image': smoothies, 'time': '3 min'},
    {'name': 'Omelette', 'image': omelettes, 'time': '7 min'},
  ];

  int selectedCategoryIndex = 0;
  late List<bool> isFavorite;
  late List<bool> quickIsFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = List.filled(recipes.length, false);
    quickIsFavorite = List.filled(quickRecipes.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          25.height,
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search recipes...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          25.height,

          // Category Chips
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(categories[index]),
                  selected: index == selectedCategoryIndex,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    }
                  },
                  selectedColor: const Color(0xFFEF4136),
                  backgroundColor: const Color(0xFFFFFAF8),
                  labelStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          20.height,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Horizontal Quick & Easy Recipes Section
                  const Text(
                    'Quick & Easy Recipes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: quickRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = quickRecipes[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailScreen(recipe: recipe),
                              ),
                            );
                          },
                          child: _buildRecipeCard(
                            recipe['name']!,
                            recipe['image']!,
                            recipe['time']!,
                            index,
                            true,
                          ), //Quick Recipe card generation
                        );
                      },
                    ),
                  ),
                  24.height,

                  // Main Recipe Grid
                  GridView.builder(
                    itemCount: recipes.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecipeDetailScreen(recipe: recipe),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            //Box configuration
                            color: const Color(0xFFFFFAF8),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image fills top section
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    recipe['image']!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),

                              // Text + favorite icon (fixed height)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        recipe['name']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    8.width,
                                    IconButton(
                                      icon: Icon(
                                        isFavorite[index]
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite[index]
                                            ? const Color.fromARGB(
                                                255,
                                                233,
                                                22,
                                                149,
                                              )
                                            : Colors.black,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isFavorite[index] =
                                              !isFavorite[index];
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              // Recipe time (fixed height)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4,
                                ),
                                child: Text(
                                  recipe['time']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Make horizontal recipe card
  Widget _buildRecipeCard(
    String title,
    String imagePath,
    String time,
    int index,
    bool isQuick,
  ) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFAF8), // same as background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1), // thin black border
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Image is the background
            Image.asset(imagePath, fit: BoxFit.cover),

            // 2. A semi-transparent layer to make text readable
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  // Semi-transparent overlay
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              // Changed to white for contrast
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Favorite icon
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        isQuick
                            ? (quickIsFavorite[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border)
                            : (isFavorite[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                        color: isQuick
                            ? (quickIsFavorite[index]
                                  ? const Color.fromARGB(255, 233, 22, 149)
                                  : Colors.white) // Changed to white
                            : (isFavorite[index]
                                  ? const Color(0xFFFFE89C)
                                  : Colors.white), // Changed to white
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isQuick) {
                            quickIsFavorite[index] = !quickIsFavorite[index];
                          } else {
                            isFavorite[index] = !isFavorite[index];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
