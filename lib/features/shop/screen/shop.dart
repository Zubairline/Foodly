import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/config/utils/colors.dart';
import 'package:foodly_backup/config/utils/themes.dart';
import 'package:foodly_backup/core/helper/ingredient_parser.dart';
import 'package:foodly_backup/features/plan/managers/plan_bloc.dart';
import 'package:foodly_backup/features/plan/managers/plan_event.dart';
import 'package:foodly_backup/features/plan/managers/plan_state.dart';
import 'package:foodly_backup/features/plan/model/meal_model.dart';
import 'package:foodly_backup/features/plan/model/ingredient_model.dart';
import 'package:foodly_backup/features/shop/widgets/number_badge.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealSearchDelegate extends SearchDelegate<Map<String, dynamic>?> {
  final List<Map<String, dynamic>> meals;

  MealSearchDelegate(this.meals);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = meals.where((meal) =>
        meal['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final meal = results[index];
        return ListTile(
          title: Text(meal['name']),
          subtitle: Text('Category: ${meal['category']}'),
          onTap: () {
            close(context, meal);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = meals.where((meal) =>
        meal['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final meal = suggestions[index];
        return ListTile(
          title: Text(meal['name']),
          subtitle: Text('Category: ${meal['category']}'),
          onTap: () {
            close(context, meal);
          },
        );
      },
    );
  }
}

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  DateTime startDate = DateTime(DateTime.now().year, 11, 12);
  DateTime endDate = DateTime(DateTime.now().year, 11, 19);

  @override
  void initState() {
    super.initState();
    // Load meals from storage
    context.read<PlanBloc>().add(LoadEvent(DateTime.now()));
    _loadSavedDates();
    // Add a delay to ensure state is loaded
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {});
    });
  }

  Future<void> _loadSavedDates() async {
    final prefs = await SharedPreferences.getInstance();
    final startDateStr = prefs.getString('shop_start_date');
    final endDateStr = prefs.getString('shop_end_date');
    if (startDateStr != null && endDateStr != null) {
      setState(() {
        startDate = DateTime.parse(startDateStr);
        endDate = DateTime.parse(endDateStr);
      });
    }
  }

  Future<void> _saveDates() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('shop_start_date', startDate.toIso8601String());
    await prefs.setString('shop_end_date', endDate.toIso8601String());
  }

  void _pickDate(bool isStart) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
      _saveDates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        final meals = state is LoadedState ? state.meals : <DateTime, List<Meal>>{};
        final selectedMeals = _getMealsInRange(meals, startDate, endDate);
        print('Meals map: $meals');
        print('Start date: $startDate, End date: $endDate');
        print('Selected meals: $selectedMeals');

        // Count occurrences of each meal
        final Map<String, int> mealCounts = {};
        for (final meal in selectedMeals) {
          final key = '${meal.name}_${meal.category}';
          mealCounts[key] = (mealCounts[key] ?? 0) + 1;
        }

        // Get unique meals
        final Set<String> seenKeys = {};
        final List<Meal> uniqueMeals = [];
        for (final meal in selectedMeals) {
          final key = '${meal.name}_${meal.category}';
          if (!seenKeys.contains(key)) {
            seenKeys.add(key);
            uniqueMeals.add(meal);
          }
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shop',
                    style: welcomeText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // First date
                          NumberBadge(
                            number: DateFormat('MMM dd').format(startDate),
                            onTap: () => _pickDate(true),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'to',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Second date
                          NumberBadge(
                            number: DateFormat('MMM dd').format(endDate),
                            onTap: () => _pickDate(false),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _showAddMealDialog(context, context.read<PlanBloc>()),
                        child: Row(
                          children: const [
                            Icon(Icons.add_circle_outline, color: Colors.black54),
                            SizedBox(width: 8),
                            Text(
                              "Add meal",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 350,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: uniqueMeals.isEmpty
                  ? Container()
                  : ListView.builder(
                      itemCount: uniqueMeals.length,
                      itemBuilder: (context, index) {
                        final meal = uniqueMeals[index];
                        final key = '${meal.name}_${meal.category}';
                        final count = mealCounts[key] ?? 1;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      meal.name,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${meal.category} • ${meal.time}',
                                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  if (count > 1)
                                    Text(
                                      'x$count',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.black54,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      // Remove one instance of the meal from plan
                                      final date = _findDateForMeal(meals, meal);
                                      if (date != null) {
                                        context.read<PlanBloc>().add(RemoveMealFromPlan(date: date, meal: meal));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              ),
              Align(
                alignment: Alignment.center,
                child: OutlinedButton(
                  onPressed: () => _showGroceryListDialog(context, selectedMeals),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(navigationButton),
                  ),
                  child: Text(
                    'Generate Shopping List',
                    style: buttons.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Meal> _getMealsInRange(Map<DateTime, List<Meal>> meals, DateTime startDate, DateTime endDate) {
    List<Meal> selectedMeals = [];
    // Normalize dates to start of day for comparison
    DateTime start = DateTime(startDate.year, startDate.month, startDate.day);
    DateTime end = DateTime(endDate.year, endDate.month, endDate.day);

    for (DateTime date in meals.keys) {
      DateTime normalizedDate = DateTime(date.year, date.month, date.day);
      if ((normalizedDate.isAfter(start) || normalizedDate.isAtSameMomentAs(start)) &&
          (normalizedDate.isBefore(end) || normalizedDate.isAtSameMomentAs(end))) {
        selectedMeals.addAll(meals[date] ?? []);
      }
    }
    return selectedMeals;
  }

  DateTime? _findDateForMeal(Map<DateTime, List<Meal>> meals, Meal meal) {
    for (final entry in meals.entries) {
      if (entry.value.contains(meal)) {
        return entry.key;
      }
    }
    return null;
  }

  void _showAddMealDialog(BuildContext context, PlanBloc planBloc) async {
    Map<String, dynamic>? selectedMeal;

    // Load existing meals
    final String foodsResponse = await rootBundle.loadString('assets/json/foods.json');
    final foodsData = json.decode(foodsResponse);
    final popularFoods = List<Map<String, dynamic>>.from(foodsData['popularFoods']);
    final quickFoods = List<Map<String, dynamic>>.from(foodsData['quickHealthyFoods']);
    final allMeals = [...popularFoods, ...quickFoods];

    Future<void> showMealSearchDialog() async {
      final result = await showSearch<Map<String, dynamic>?>(
        context: context,
        delegate: MealSearchDelegate(allMeals),
      );
      if (result != null) {
        selectedMeal = result;
      }
    }

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Add New Meal"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Meal Selection
                GestureDetector(
                  onTap: () async {
                    await showMealSearchDialog();
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade50,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedMeal != null ? selectedMeal!['name'] : "Select a meal",
                            style: TextStyle(
                              color: selectedMeal != null ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                        const Icon(Icons.search, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                if (selectedMeal != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    "Category: ${selectedMeal!['category']}",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
              ),
              onPressed: () async {
                if (selectedMeal != null) {
                  // Load ingredients and cooking time from recipes.json if available
                  List<Ingredient> ingredients = [];
                  String cookingTime = '';
                  try {
                    final recipesResponse = await rootBundle.loadString('assets/json/recipes.json');
                    final recipesData = json.decode(recipesResponse);
                    final quickRecipes = List<Map<String, dynamic>>.from(recipesData['quickHealthyFoods']);
                    final popularRecipes = List<Map<String, dynamic>>.from(recipesData['popularFoods']);
                    final allRecipes = [...quickRecipes, ...popularRecipes];

                    final recipe = allRecipes.firstWhere(
                      (r) => r['name'].toString().toLowerCase() == selectedMeal!['name'].toString().toLowerCase(),
                      orElse: () => {},
                    );

                    if (recipe.isNotEmpty) {
                      if (recipe['ingredients'] != null) {
                        ingredients = (recipe['ingredients'] as List<dynamic>).map((i) => Ingredient(name: i.toString(), quantity: '')).toList();
                      }
                      cookingTime = recipe['time'] ?? '';
                    }
                  } catch (e) {
                    // If recipes.json fails to load or meal not found, use empty ingredients and time
                    ingredients = [];
                    cookingTime = '';
                  }

                  final meal = Meal(
                    name: selectedMeal!['name'],
                    category: selectedMeal!['category'],
                    time: cookingTime,
                    image: selectedMeal!['image'] ?? '',
                    ingredients: ingredients,
                  );

                  // Add to PlanBloc on startDate
                  planBloc.add(AddMealToPlan(date: startDate, meal: meal));
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  void _showGroceryListDialog(BuildContext context, List<Meal> selectedMeals) {
    // Collect all ingredient strings
    List<String> allIngredients = [];
    for (final meal in selectedMeals) {
      for (final ingredient in meal.ingredients) {
        allIngredients.add(ingredient.name);
      }
    }

    // Parse and sum ingredients
    final summedIngredients = IngredientParser.parseAndSumIngredients(allIngredients);

    // Generate bulleted list
    final buffer = StringBuffer();
    summedIngredients.forEach((name, quantity) {
      final formatted = IngredientParser.formatQuantity(quantity, null); // Default to grams
      buffer.writeln('- $name: $formatted');
    });

    final groceryList = buffer.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Grocery List'),
        content: SingleChildScrollView(
          child: SelectableText(
            groceryList.isEmpty ? 'No ingredients found.' : groceryList,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
