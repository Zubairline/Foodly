import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/config/utils/routes.dart';
import 'package:foodly_backup/core/categories_enum.dart';
import 'package:foodly_backup/features/discovery/managers/discovery_bloc.dart';
import 'package:foodly_backup/features/discovery/managers/discovery_event.dart';
import 'package:foodly_backup/features/discovery/managers/discovery_state.dart';
import 'package:foodly_backup/features/discovery/widget/quick_recipe_card.dart';
import 'package:nb_utils/nb_utils.dart';

class Discovery extends StatefulWidget {
  const Discovery({super.key});

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  RecipeCategory selectedCategory = RecipeCategory.all;

  static const _kFavRecipesKey = 'favoriteRecipes';
  static const _kFavQuickKey = 'quickFavoriteRecipes';
  final Set<String> _favRecipeIds = <String>{};
  final Set<String> _favQuickIds = <String>{};

  @override
  void initState() {
    super.initState();
    context.read<DiscoveryBloc>().add(OnLoadDiscovery());
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final recipes = prefs.getStringList(_kFavRecipesKey) ?? const <String>[];
    final quick = prefs.getStringList(_kFavQuickKey) ?? const <String>[];
    setState(() {
      _favRecipeIds
        ..clear()
        ..addAll(recipes);
      _favQuickIds
        ..clear()
        ..addAll(quick);
    });
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kFavRecipesKey, _favRecipeIds.toList());
    await prefs.setStringList(_kFavQuickKey, _favQuickIds.toList());
  }

  String _keyFor(Map item, {required String prefix}) {
    final id = item['id'];
    if (id != null) return '$prefix$id';

    final name = (item['name'] ?? '').toString();
    final image = (item['image'] ?? '').toString();
    final time = (item['time'] ?? '').toString();
    return '$prefix$name|$image|$time';
  }

  bool _isFav(Map item, {required bool quick}) {
    final key = _keyFor(item, prefix: quick ? 'q:' : 'r:');
    return quick ? _favQuickIds.contains(key) : _favRecipeIds.contains(key);
  }

  void _toggleFav(Map item, {required bool quick}) {
    final key = _keyFor(item, prefix: quick ? 'q:' : 'r:');
    setState(() {
      final set = quick ? _favQuickIds : _favRecipeIds;
      if (set.contains(key)) {
        set.remove(key);
      } else {
        set.add(key);
      }
    });
    _saveFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoveryBloc, DiscoveryState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ErrorState) {
          return Center(
            child: Text(
              'Something went wrong.\n${state.message}',
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is LoadedState) {
          final allRecipes = state.recipes;
          final quickRecipes = state.quickRecipes;

          debugPrint('Selected category: ${selectedCategory.key}');
          for (var item in allRecipes) {
            debugPrint('Recipe: ${item['name']} -> ${item['category']}');
          }

          String norm(dynamic v) => (v ?? '').toString().trim().toLowerCase();

          final filteredRecipes = selectedCategory == RecipeCategory.all
              ? allRecipes
              : allRecipes.where((r) {
                  final cat = norm(r['category']);
                  final key = norm(selectedCategory.name);
                  return cat == key;
                }).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.height,

                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search recipes...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                25.height,

                // Category chips (enum)
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: RecipeCategory.values.length,
                    itemBuilder: (context, index) {
                      final category = RecipeCategory.values[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(category.label),
                          selected: category == selectedCategory,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => selectedCategory = category);
                            }
                          },
                          selectedColor: const Color(0xFFEF4136),
                          backgroundColor: const Color(0xFFFFFAF8),
                          labelStyle: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ),
                ),

                20.height,

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      const Text(
                        'Quick & Easy Recipes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: quickRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = Map<String, dynamic>.from(
                              quickRecipes[index],
                            );
                            return GestureDetector(
                              onTap: () {
                                final recipeName = recipe['name'];
                                Navigator.pushNamed(
                                  context,
                                  RouteGenerator.recipeDetail,
                                  arguments: recipeName,
                                );
                              },

                              child: QuickRecipeCard(
                                title: recipe['name'],
                                imagePath: recipe['image'],
                                time: recipe['time'],
                                isFav: _isFav(recipe, quick: true),
                                onToggleFav: () =>
                                    _toggleFav(recipe, quick: true),
                              ),
                            );
                          },
                        ),
                      ),

                      24.height,

                      // Filtered grid
                      GridView.builder(
                        itemCount: filteredRecipes.length,
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
                          final recipe = Map<String, dynamic>.from(
                            filteredRecipes[index],
                          );
                          final isFav = _isFav(recipe, quick: false);

                          return GestureDetector(
                            onTap: () {
                              final recipeName = recipe['name'];
                              Navigator.pushNamed(
                                context,
                                RouteGenerator.recipeDetail,
                                arguments: recipeName,
                              );
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFAF8),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: Image.asset(
                                        (recipe['image'] ?? '').toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            (recipe['name'] ?? '').toString(),
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
                                            isFav
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFav
                                                ? Colors.red
                                                : Colors.black,
                                            size: 20,
                                          ),
                                          onPressed: () =>
                                              _toggleFav(recipe, quick: false),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      (recipe['time'] ?? '').toString(),
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
              ],
            ),
          );
        }

        // InitialState fallback
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
