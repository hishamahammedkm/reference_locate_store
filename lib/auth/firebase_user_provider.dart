import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FindBestDealFirebaseUser {
  FindBestDealFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

FindBestDealFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FindBestDealFirebaseUser> findBestDealFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FindBestDealFirebaseUser>(
            (user) => currentUser = FindBestDealFirebaseUser(user));
