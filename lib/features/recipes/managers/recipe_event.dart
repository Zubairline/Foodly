abstract class RecipeDetailEvent {}

class LoadRecipeDetail extends RecipeDetailEvent {
  final String recipeName;

  LoadRecipeDetail(this.recipeName);

  List<Object?> get props => [recipeName];
}
