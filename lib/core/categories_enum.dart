enum RecipeCategory {
  all,
  dinner,
  vegan,
  desserts,
  quickMeals,
}

extension RecipeCategoryExtension on RecipeCategory {
  String get label {
    switch (this) {
      case RecipeCategory.all:
        return 'All';
      case RecipeCategory.dinner:
        return 'Dinner';
      case RecipeCategory.vegan:
        return 'Vegan';
      case RecipeCategory.desserts:
        return 'Desserts';
      case RecipeCategory.quickMeals:
        return 'Quick Meals';
    }
  }

  String get key => name; // useful for JSON comparison
}
