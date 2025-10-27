abstract class DiscoveryState {}

class InitialState extends DiscoveryState {}

class LoadingState extends DiscoveryState {}

class LoadedState extends DiscoveryState {
  final List<dynamic> recipes;
  final List<dynamic> quickRecipes;

  LoadedState(this.recipes, this.quickRecipes);

  List<Object?> get props => [recipes, quickRecipes];
}

class ErrorState extends DiscoveryState {
  final String message;

  ErrorState(this.message);

  List<Object?> get props => [message];
}
