import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/discovery/managers/discovery_event.dart';
import 'package:foodly_backup/features/discovery/managers/discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  DiscoveryBloc() : super(InitialState()) {
    on<OnLoadDiscovery>(_onLoadDiscovery);
  }

  Future<void> _onLoadDiscovery(
    OnLoadDiscovery event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(LoadingState());
    try {
      final String response = await rootBundle.loadString(
        'assets/json/foods.json',
      );
      final data = json.decode(response);

      final recipes = data['popularFoods'];
      final quickRecipes = data['quickHealthyFoods'];

      emit(LoadedState(recipes, quickRecipes));
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: 'Error: $e');
      emit(ErrorState(e.toString()));
    }
  }
}
