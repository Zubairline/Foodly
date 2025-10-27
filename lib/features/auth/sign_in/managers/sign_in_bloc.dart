import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/auth/sign_in/managers/sign_in_event.dart';
import 'package:foodly_backup/features/auth/sign_in/managers/sign_in_state.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _auth;

  SignInBloc(this._auth) : super(InitialState()) {
    on<OnSignIn>(_onSignIn);
  }

  Future<void> _onSignIn(OnSignIn event, Emitter<SignInState> emit) async {
    emit(LoadingState());
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SuccessState(userCredential.user!.uid));

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', userCredential.user!.uid);
    } on FirebaseAuthException catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: 'Sign in Error: $error');
      emit(ErrorState(error.message ?? 'Something went wrong'));
    }
  }
}
