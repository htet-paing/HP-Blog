import 'package:flutter/foundation.dart';
import 'package:provider_and_fstore/model/user.dart';
import 'package:provider_and_fstore/reposities/post_reposity.dart';

class AuthProvider with ChangeNotifier {

  final _postReposity = PostReposity();

  AUser _user;
  AUser get user => _user;
  
  void setUser(AUser user) {
    _user = user;
    print(user.email);
    notifyListeners();
  }

  Future<void> login(AUser user) async{
   _user = await _postReposity.login(user);
    notifyListeners();
  }

  Future<void> signup(AUser user) async{
    await _postReposity.signup(user);
    notifyListeners();
  }

  Future<void> logout() async {
    await _postReposity.logout();
    setUser(null);
  }

  
}