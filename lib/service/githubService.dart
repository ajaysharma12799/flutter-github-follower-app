import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Github {
  final String githubUserName;
  final String apiURL = "https://api.github.com";
  static String clientID = "e0bb9bf5b6b69d0b3b13";
  static String clientSecret = "bf87aae5a9f4f3bfe8e530704a14214372605405";
  final String query = "?client_id=${clientID}&client_secret=${clientSecret}";

  Github({@required this.githubUserName});

  Future<http.Response> fetchUser() async {
    final response =
        await http.get(Uri.parse("${apiURL}/users/${githubUserName}" + query));
    print(response.body);
    return response;
  }

  Future<http.Response> fetchFollowing() async {
    final response = await http
        .get(Uri.parse("${apiURL}/users/${githubUserName}/following" + query));
    print(response.body);
    return response;
  }
}

/* 
  http.Response => Contain Data From Successfull Network Call
*/