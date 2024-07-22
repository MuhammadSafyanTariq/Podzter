import 'package:flutter/widgets.dart';
import 'package:insta_clone/Models/user.dart';
import 'package:insta_clone/Resource/Auth_Methods.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user = UserModel(
    username: '',
    uid: '',
    photoUrl: '',
    email: '',
    bio: '',
    followers: [],
    following: [],
  );
  final AuthMethods _authMethods = AuthMethods();

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

  UserModel get getUser => _user!;
}
