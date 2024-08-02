import 'package:cloud_firestore/cloud_firestore.dart';

class UsersFirebaseServices {
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getUsers() async* {
    yield* _usersCollection.snapshots();
  }

  Future<void> addUser(
    String fullName,
    String email,
  ) async {
    await _usersCollection.add({
      "username": fullName,
      "email": email,
    });
  }

  // Function to get user data by email
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByEmail(
      String email) async {
    final querySnapshot =
        await _usersCollection.where('email', isEqualTo: email).get();

    return querySnapshot.docs.first;
  }
}
