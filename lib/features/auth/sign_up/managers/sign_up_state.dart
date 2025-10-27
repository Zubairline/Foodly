abstract class SignUpState {}

class InitialState extends SignUpState {}

class LoadingState extends SignUpState {}

class SuccessState extends SignUpState {}

class ErrorState extends SignUpState {
  final String message;

  ErrorState(this.message);

  List<Object?> get props => [message];
}
