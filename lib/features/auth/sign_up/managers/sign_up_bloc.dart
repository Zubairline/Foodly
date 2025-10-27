import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/auth/sign_up/managers/sign_up_event.dart';
import 'package:foodly_backup/features/auth/sign_up/managers/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth auth;

  SignUpBloc(this.auth) : super(InitialState()) {
    on<OnSignUp>(_onSignUp);
  }

  Future<void> _onSignUp(OnSignUp event, Emitter<SignUpState> emit) async {
    emit(LoadingState());
    try {
      await auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SuccessState());
    } on FirebaseAuthException catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: 'Sign Up Error: $error');
      emit(ErrorState(error.message ?? 'Something went wrong.'));
    }
  }
}
