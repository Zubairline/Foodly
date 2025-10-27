abstract class ForgotPasswordState {}

class InitialState extends ForgotPasswordState {}

class LoadingState extends ForgotPasswordState {}

class SuccessState extends ForgotPasswordState {
  final String message;

  SuccessState(this.message);

  List<Object?> get props => [];
}

class ErrorState extends ForgotPasswordState {
  final String message;

  ErrorState(this.message);

  List<Object?> get props => [];
}
