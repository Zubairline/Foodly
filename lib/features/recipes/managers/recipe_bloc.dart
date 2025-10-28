import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/recipes/managers/recipe_event.dart';
import 'package:foodly_backup/features/recipes/managers/recipe_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  RecipeDetailBloc() : super(RecipeInitial()) {
    on<LoadRecipeDetail>(_onLoadRecipeDetail);
  }

  Future<void> _onLoadRecipeDetail(
    LoadRecipeDetail event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(RecipeLoading());
    try {
      final String response = await rootBundle.loadString(
        'assets/json/recipes.json',
      );
      final data = json.decode(response);

      final quickRecipes = List<Map<String, dynamic>>.from(
        data['quickHealthyFoods'],
      );
      final popularRecipes = List<Map<String, dynamic>>.from(
        data['popularFoods'],
      );

      final allRecipes = [...quickRecipes, ...popularRecipes];

      final recipe = allRecipes.firstWhere(
        (r) =>
            r['name'].toString().toLowerCase() ==
            event.recipeName.toLowerCase(),
        orElse: () => {},
      );

      if (recipe.isEmpty) {
        emit(RecipeError('Recipe not found.'));
      } else {
        emit(RecipeLoaded(recipe));
      }
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: 'Error: $e');
      emit(RecipeError('Failed to load recipe details.'));
    }
  }
}
