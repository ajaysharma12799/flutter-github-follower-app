import 'package:flutter/foundation.dart';

class User {
  final String login;
  final String avatarURL;
  final String htmlURL;

  User({
    @required this.login,
    @required this.avatarURL,
    @required this.htmlURL,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        avatarURL: json["avatar_url"],
        htmlURL: json["html_url"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "avatarURL": avatarURL,
        "htmlURL": htmlURL,
      };
}
