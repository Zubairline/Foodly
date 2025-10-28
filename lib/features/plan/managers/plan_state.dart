import 'package:foodly_backup/features/plan/model/meal_model.dart';

abstract class PlanState {}

class InitialState extends PlanState {}

class LoadingState extends PlanState {}

class LoadedState extends PlanState {
  final Map<DateTime, List<Meal>> meals;

  LoadedState(this.meals);

  List<Object?> get props => [meals];
}

class ErrorState extends PlanState {
  final String error;

  ErrorState(this.error);

  List<Object?> get props => [error];
}
