import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_following_app/service/githubService.dart';
import 'package:provider/provider.dart';
import 'package:flutter_github_following_app/model/userModel.dart';

class UserProvider with ChangeNotifier {
  User user;
  String errorMessage;
  bool _loading = false;

  Future<bool> fetchUser(String UserName) async {
    setLoading(true);
    await Github(githubUserName: UserName).fetchUser().then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setUser(User.fromJson(json.decode(data.body)));
      } else {
        Map<String, dynamic> result = json.decode(data.body);
        setErrorMessage(result['message']);
      }
    });
    return isUser();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return _loading;
  }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  User getUser() {
    return user;
  }

  void setErrorMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool isUser() {
    return user != null ? true : false;
  }
}
