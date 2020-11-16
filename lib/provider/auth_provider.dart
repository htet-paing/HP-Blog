import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_and_fstore/model/user.dart';


enum AuthStatus { Uninitialized, Authenticated, Authenticating, Unauthenticated}

class AuthProvider with ChangeNotifier {

  FirebaseAuth _auth;
  User _user;
  AuthStatus _status = AuthStatus.Uninitialized;

  AuthProvider.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  User get user => _user;
  AuthStatus get status => _status;


  
  Future<bool> signin(AUser user) async{
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: user.email, password: user.password);
      return true;
    }catch (e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      print(e);
      return false;
    }
  }

  Future<bool> signup(AUser user) async {
    try {
      _status = AuthStatus.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      return true;
    }catch (e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  Future<void> _onAuthStateChanged(User user) async {
    if (user == null) {
      _status = AuthStatus.Unauthenticated;
    }else {
      _user = user;
      _status = AuthStatus.Authenticated;
    }
    notifyListeners();
  }

  Future signout() async {
     _auth.signOut();
     _status = AuthStatus.Unauthenticated;
     notifyListeners();
     return Future.delayed(Duration.zero);
  }

  
}