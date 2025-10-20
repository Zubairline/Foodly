import 'package:flutter/material.dart';
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
  ]; //Catergory list
  static const List<Map<String, String>> recipes = [
    {
      'name': 'Grilled Chicken Salad',
      'image': 'assets/chicken_salad.jpg',
      'time': '15 min',
    },
    {'name': 'Vegan Bowl', 'image': 'assets/vegan_bowl.jpg', 'time': '10 min'},
    {'name': 'Pasta Alfredo', 'image': 'assets/pasta.jpg', 'time': '25 min'},
  ]; //Recipe: <name, image, time>

  static const List<Map<String, String>> quickRecipes = [
    {
      'name': 'Avocado Toast',
      'image': 'assets/avocado_toast.jpg',
      'time': '5 min',
    },
    {'name': 'Smoothie', 'image': 'assets/smoothie.jpg', 'time': '3 min'},
    {'name': 'Omelette', 'image': 'assets/omelette.jpg', 'time': '7 min'},
  ];

  int selectedCategoryIndex = 0;
  late List<bool> isFavorited;
  late List<bool> quickIsFavorited;
  int _selectedIndex = 0; // For bottom navigation

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation logic here
  }

  @override
  void initState() {
    super.initState();
    isFavorited = List.filled(recipes.length, false);
    quickIsFavorited = List.filled(quickRecipes.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        isFavorited[index]
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorited[index]
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
                                          isFavorited[index] =
                                              !isFavorited[index];
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
          children: [
            // Text and time
            Positioned(
              left: 8,
              bottom: 8,
              right: 28, // leave space for favorite icon
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black, // changed to black
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            ),
            // Favorite icon
            Positioned(
              right: 8,
              bottom: 8,
              child: IconButton(
                icon: Icon(
                  isQuick
                      ? (quickIsFavorited[index]
                            ? Icons.favorite
                            : Icons.favorite_border)
                      : (isFavorited[index]
                            ? Icons.favorite
                            : Icons.favorite_border),
                  color: isQuick
                      ? (quickIsFavorited[index]
                            ? const Color.fromARGB(255, 233, 22, 149)
                            : Colors.black)
                      : (isFavorited[index]
                            ? const Color(0xFFFFE89C)
                            : Colors.black),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    if (isQuick) {
                      quickIsFavorited[index] = !quickIsFavorited[index];
                    } else {
                      isFavorited[index] = !isFavorited[index];
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
