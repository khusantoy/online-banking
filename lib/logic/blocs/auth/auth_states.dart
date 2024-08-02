part of 'auth_bloc.dart';

// sealed abstract class faqat shu fayl ichida ishlaydi

sealed class AuthStates {}

final class InitialAuthState extends AuthStates {}

final class LoadingAuthState extends AuthStates {}

final class LoadedAuthState extends AuthStates {}

final class ErrorAuthState extends AuthStates {
  final String message;
  
  ErrorAuthState(this.message);
}