import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodly_backup/features/auth/forgot_password/managers/forgot_password_event.dart';
import 'package:foodly_backup/features/auth/forgot_password/managers/forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final FirebaseAuth auth;

  ForgotPasswordBloc(this.auth) : super(InitialState()) {
    on<ResetPassword>(_onResetPassword);
  }

  Future<void> _onResetPassword(
    ResetPassword event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(LoadingState());
    try {
      await auth.sendPasswordResetEmail(email: event.email);
      emit(SuccessState('Password reset email sent to ${event.email}'));
    } on FirebaseAuthException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: 'Error: $e');
      emit(ErrorState(e.message ?? 'Something went wrong'));
    }
  }
}
