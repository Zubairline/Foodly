abstract class SignInEvent{}

class OnSignIn extends SignInEvent{
  final String email;
  final String password;

  OnSignIn(this.email, this.password);
}