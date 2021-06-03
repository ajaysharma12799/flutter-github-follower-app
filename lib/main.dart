import 'package:flutter/material.dart';
import 'package:flutter_github_following_app/page/followingPage.dart';
import 'package:flutter_github_following_app/provider/userProvider.dart';
import 'package:flutter_github_following_app/screen/homeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (ctx) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: <String, WidgetBuilder>{
          FollowingPage.routeName: (ctx) => FollowingPage()
        },
      ),
    );
  }
}
