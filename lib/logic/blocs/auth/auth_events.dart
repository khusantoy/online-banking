part of 'auth_bloc.dart';

sealed class AuthEvents {}

final class RegisterAuthEvent extends AuthEvents {
  final String fullName;
  final String email;
  final String password;

  RegisterAuthEvent(this.fullName,this.email, this.password);
}

final class LoginAuthEvent extends AuthEvents {
  final String email;
  final String password;

  LoginAuthEvent(this.email, this.password);
}

final class ResetPasswordAuthEvent extends AuthEvents {
  final String email;

  ResetPasswordAuthEvent(this.email);
}

final class LogoutAuthEvent extends AuthEvents {}