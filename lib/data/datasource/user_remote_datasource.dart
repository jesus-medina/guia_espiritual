import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class UserRemoteDataSource {
  final FirebaseAuth _auth;

  UserRemoteDataSource(this._auth);

  Future<User> getCurrentUser() {
    Completer<User> userCompleter = Completer();

    userCompleter.complete(_auth.currentUser);

    return userCompleter.future;
  }

  Stream<User> authStateChanges() => _auth.authStateChanges();

  Stream<User> idTokenChanges() => _auth.idTokenChanges();

  Stream<User> userChanges() => _auth.userChanges();

  Future<ConfirmationResult> signInWithPhoneNumber(String phoneNumber) =>
      _auth.signInWithPhoneNumber(phoneNumber);
}
