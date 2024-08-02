import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_banking/services/auth_firebase_services.dart';
import 'package:online_banking/services/users_firebase_services.dart';

abstract class InterfaceUserRepository {
  Future<void> getUser();
  Future<void> registerUser(
    String fullName,
    String email,
    String password,
  );
  Future<void> loginUser(
    String email,
    String password,
  );
  Future<void> resetPassword(String email);
  Future<void> logout();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByEmail(String email);
}

class UserRepository implements InterfaceUserRepository {
  final AuthFirebaseServices authFirebaseServices;
  final UsersFirebaseServices usersFirebaseServices;

  UserRepository(this.authFirebaseServices, this.usersFirebaseServices);

  @override
  Future<void> getUser() async {}

  @override
  Future<void> registerUser(
      String fullName, String email, String password) async {
    await authFirebaseServices.register(
        emailAddress: email, password: password);

    await usersFirebaseServices.addUser(fullName, email);
  }

  @override
  Future<void> loginUser(String email, String password) async {
    await authFirebaseServices.login(emailAddress: email, password: password);
  }

  @override
  Future<void> resetPassword(String email) async {
    await authFirebaseServices.resetPassword(email: email);
  }

  @override
  Future<void> logout() async {
    await AuthFirebaseServices.logout();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByEmail(
      String email) async {
    return await usersFirebaseServices.getUserByEmail(email);
  }
}
