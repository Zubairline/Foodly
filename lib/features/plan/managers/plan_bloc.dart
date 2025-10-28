import 'package:foodly_backup/features/plan/managers/plan_event.dart';
import 'package:foodly_backup/features/plan/managers/plan_state.dart';
import 'package:foodly_backup/features/plan/model/meal_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PlanBloc extends HydratedBloc<PlanEvent, PlanState> {
  Map<DateTime, List<Meal>> meals = {};

  PlanBloc() : super(InitialState()) {
    on<LoadEvent>(_onLoadMealPlan);
    on<AddMealToPlan>(_onAddMealPlan);
    on<RemoveMealFromPlan>(_onRemoveMealPlan);
    on<UpdateMealInPlan>(_onUpdateMealPlan);
    on<ClearMealPlan>(_onClearMealPlan);
  }

  Future<void> _onLoadMealPlan(LoadEvent event, Emitter<PlanState> emit) async {
    emit(LoadedState(meals));
  }

  Future<void> _onAddMealPlan(
      AddMealToPlan event,
      Emitter<PlanState> emit,
      ) async {
    final dateMeals = meals[event.date] ?? [];
    dateMeals.add(event.meal);
    meals[event.date] = dateMeals;
    emit(LoadedState(Map.from(meals)));
  }

  Future<void> _onRemoveMealPlan(
      RemoveMealFromPlan event,
      Emitter<PlanState> emit,
      ) async {
    final dateMeals = meals[event.date];
    if (dateMeals != null) {
      dateMeals.remove(event.meal);
      meals[event.date] = dateMeals;
      emit(LoadedState(Map.from(meals)));
    }
  }

  Future<void> _onUpdateMealPlan(
      UpdateMealInPlan event,
      Emitter<PlanState> emit,
      ) async {
    final dateMeals = meals[event.date];
    if (dateMeals != null) {
      final index =
      dateMeals.indexWhere((item) => item.name == event.meal.name);
      if (index != -1) {
        dateMeals[index] = event.meal;
        meals[event.date] = dateMeals;
        emit(LoadedState(Map.from(meals)));
      }
    }
  }

  Future<void> _onClearMealPlan(
      ClearMealPlan event,
      Emitter<PlanState> emit,
      ) async {
    meals.clear();
    emit(LoadedState(Map.from(meals)));
  }

  @override
  Map<String, dynamic>? toJson(PlanState state) {
    if (state is LoadedState) {
      return {
        'meals': state.meals.map((key, value) => MapEntry(
          key.toIso8601String(),
          value.map((item) => item.toJson()).toList(),
        )),
      };
    }
    return null;
  }

  @override
  PlanState? fromJson(Map<String, dynamic> json) {
    try {
      final loadedMeals = (json['meals'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
          DateTime.parse(key),
          (value as List<dynamic>)
              .map((m) => Meal.fromJson(m as Map<String, dynamic>))
              .toList(),
        ),
      );
      meals = loadedMeals;
      return LoadedState(loadedMeals);
    } catch (_) {
      return InitialState();
    }
  }
}
