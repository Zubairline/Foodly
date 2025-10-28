abstract class RecipeDetailState {}

class RecipeInitial extends RecipeDetailState {}

class RecipeLoading extends RecipeDetailState {}

class RecipeLoaded extends RecipeDetailState {
  final Map<String, dynamic> recipe;

  RecipeLoaded(this.recipe);

  List<Object?> get props => [recipe];
}

class RecipeError extends RecipeDetailState {
  final String message;

  RecipeError(this.message);

  List<Object?> get props => [message];
}
