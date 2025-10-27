abstract class SignUpEvent {}

class OnSignUp extends SignUpEvent {
  final String email;
  final String password;

  OnSignUp(this.email, this.password);
}
