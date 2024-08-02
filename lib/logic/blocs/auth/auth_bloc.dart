import 'package:bloc/bloc.dart';
import 'package:online_banking/data/repositories/user_repository.dart';

part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc(this.interfaceUserRepository) : super(InitialAuthState()) {
    on<RegisterAuthEvent>(_register);
    on<LoginAuthEvent>(_login);
    on<ResetPasswordAuthEvent>(_resetPassword);
    on<LogoutAuthEvent>(_logout);
  }

  final InterfaceUserRepository interfaceUserRepository;

  void _register(RegisterAuthEvent event, emit) async {
    emit(LoadingAuthState());

    try {
      await interfaceUserRepository.registerUser(
          event.fullName, event.email, event.password);
      emit(LoadedAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _login(LoginAuthEvent event, emit) async {
    emit(LoadingAuthState());

    try {
      await interfaceUserRepository.loginUser(event.email, event.password);
      emit(LoadedAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _logout(LogoutAuthEvent event, emit) async {
    emit(LoadingAuthState());
    try {
      await interfaceUserRepository.logout();
      emit(LoadedAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _resetPassword(ResetPasswordAuthEvent event, emit) async {
    emit(LoadedAuthState());
    try {
      await interfaceUserRepository.resetPassword(event.email);
      emit(LoadedAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }
}
