import 'package:flutter/material.dart';
import 'package:flutter_github_following_app/model/userModel.dart';
import 'package:flutter_github_following_app/provider/userProvider.dart';
import 'package:flutter_github_following_app/service/githubService.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class FollowingPage extends StatefulWidget {
  const FollowingPage({Key key}) : super(key: key);
  static const routeName = "/FollowingScreen";

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  User user;
  List<User> users;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).getUser();
    Github(githubUserName: user.login).fetchFollowing().then((data) {
      Iterable list = json.decode(data.body);
      setState(() {
        users = list.map((element) => User.fromJson(element)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.blue,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          radius: 100.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(user.avatarURL),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        user.login,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 600,
                  child: users != null
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: 60,
                                          height: 60,
                                          child: users[index].avatarURL == null
                                              ? CircularProgressIndicator(
                                                  backgroundColor: Colors.white,
                                                  strokeWidth: 2,
                                                )
                                              : CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      users[index].avatarURL),
                                                )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        users[index].login,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : Container(
                          child: Align(child: Text('Data is loading ...'))),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
