abstract class ForgotPasswordEvent {}

class ResetPassword extends ForgotPasswordEvent {
  final String email;

  ResetPassword(this.email);
}
