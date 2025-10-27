abstract class SignInState {}

class InitialState extends SignInState {}

class LoadingState extends SignInState {}

class SuccessState extends SignInState {
  final String userId;

  SuccessState(this.userId);

  List<Object?> get props => [userId];
}

class ErrorState extends SignInState {
  final String message;

  ErrorState(this.message);

  List<Object?> get props => [message];
}
