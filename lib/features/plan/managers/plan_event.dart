import 'package:foodly_backup/features/plan/model/meal_model.dart';

abstract class PlanEvent {}

class LoadEvent extends PlanEvent {
  final DateTime date;

  LoadEvent(this.date);
}

class AddMealToPlan extends PlanEvent {
  final DateTime date;
  final Meal meal;

  AddMealToPlan({required this.date, required this.meal});
}

class RemoveMealFromPlan extends PlanEvent {
  final DateTime date;
  final Meal meal;

  RemoveMealFromPlan({required this.date, required this.meal});
}

class UpdateMealInPlan extends PlanEvent {
  final DateTime date;
  final Meal meal;

  UpdateMealInPlan({required this.date, required this.meal});
}

class ClearMealPlan extends PlanEvent {}
