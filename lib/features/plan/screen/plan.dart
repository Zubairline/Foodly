import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/plan/managers/plan_bloc.dart';
import 'package:foodly_backup/features/plan/managers/plan_event.dart';
import 'package:foodly_backup/features/plan/managers/plan_state.dart';
import 'package:foodly_backup/features/plan/model/meal_model.dart';
import 'package:foodly_backup/features/plan/model/ingredient_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';

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

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
    // Load meals from storage
    context.read<PlanBloc>().add(LoadEvent(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final year = now.year;
    final months = List.generate(12, (index) => DateTime(year, index + 1));

    return GestureDetector(
      onTap: () {
        setState(() => selectedDay = null);
      },
      child: SafeArea(
        child: BlocBuilder<PlanBloc, PlanState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            final meals = state is LoadedState
                ? state.meals
                : <DateTime, List<Meal>>{};

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              itemCount: months.length,
              itemBuilder: (context, index) {
                final month = months[index];
                final firstDay = DateTime(month.year, month.month, 1);
                final lastDay = DateTime(month.year, month.month + 1, 0);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMonthCalendar(firstDay, lastDay),
                    const SizedBox(height: 24),

                    // 📦 Meal container (only for selected day)
                    if (selectedDay != null &&
                        selectedDay!.month == month.month) ...[
                      _buildMealContainer(context, meals),
                      const SizedBox(height: 40),
                    ],
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  // 🗓 Calendar
  Widget _buildMonthCalendar(DateTime firstDay, DateTime lastDay) {
    return TableCalendar(
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: firstDay,
      currentDay: DateTime.now(),
      availableGestures: AvailableGestures.none,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        headerMargin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
        weekendStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
      calendarStyle: CalendarStyle(
        defaultDecoration: BoxDecoration(
          color: const Color(0xFFDABDA5),
          shape: BoxShape.circle,
        ),
        weekendDecoration: BoxDecoration(
          color: const Color(0xFFDABDA5),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.redAccent.shade400,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.redAccent.shade400,
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        defaultTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        weekendTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (selected, focused) {
        setState(() {
          if (isSameDay(selectedDay, selected)) {
            selectedDay = null;
          } else {
            selectedDay = selected;
          }
        });
      },
    );
  }

  // 📦 Meal container using HydratedBloc data
  Widget _buildMealContainer(
    BuildContext context,
    Map<DateTime, List<Meal>> meals,
  ) {
    final bloc = context.read<PlanBloc>();
    final selectedMeals = meals[selectedDay] ?? [];

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _showAddMealDialog(context, bloc),
                  child: Row(
                    children: const [
                      Icon(Icons.add_circle_outline, color: Colors.black54),
                      SizedBox(width: 8),
                      Text(
                        "Add new plan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (selectedMeals.isEmpty)
              const Text(
                "No meals yet for this day.",
                style: TextStyle(color: Colors.black54),
              )
            else
              ...selectedMeals.map((meal) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          meal.name,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.black54,
                          size: 22,
                        ),
                        onPressed: () {
                          bloc.add(
                            RemoveMealFromPlan(date: selectedDay!, meal: meal),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  // 📝 Add Meal Dialog

  void _showAddMealDialog(BuildContext context, PlanBloc bloc) async {
    final timeController = TextEditingController();
    Map<String, dynamic>? selectedMeal;

    // Load existing meals
    final String foodsResponse = await rootBundle.loadString('assets/json/foods.json');
    final foodsData = json.decode(foodsResponse);
    final popularFoods = List<Map<String, dynamic>>.from(foodsData['popularFoods']);
    final quickFoods = List<Map<String, dynamic>>.from(foodsData['quickHealthyFoods']);
    final allMeals = [...popularFoods, ...quickFoods];

    Future<void> pickTime() async {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (context.mounted && pickedTime != null) {
        final formatted = pickedTime.format(context);
        timeController.text = formatted;
      }
    }

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
          title: const Text("Add New Meal Plan"),
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
                const SizedBox(height: 12),

                // 🕒 Time Picker
                TextField(
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Pick time",
                    suffixIcon: const Icon(Icons.access_time),
                  ),
                  onTap: pickTime,
                ),
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
                if (selectedDay != null && selectedMeal != null) {
                  // Load ingredients from recipes.json if available
                  List<Ingredient> ingredients = [];
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

                    if (recipe.isNotEmpty && recipe['ingredients'] != null) {
                      ingredients = (recipe['ingredients'] as List<dynamic>).map((i) => Ingredient(name: i.toString(), quantity: '')).toList();
                    }
                  } catch (e) {
                    // If recipes.json fails to load or meal not found, use empty ingredients
                    ingredients = [];
                  }

                  final meal = Meal(
                    name: selectedMeal!['name'],
                    category: selectedMeal!['category'],
                    time: timeController.text.trim(),
                    image: selectedMeal!['image'] ?? '',
                    ingredients: ingredients,
                  );

                  // Add to HydratedBloc
                  bloc.add(AddMealToPlan(date: selectedDay!, meal: meal));
                }
                Navigator.pop(context);
                toast('Meal added successfully!');
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
