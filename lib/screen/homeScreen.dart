import 'package:flutter/material.dart';
import 'package:flutter_github_following_app/page/followingPage.dart';
import 'package:flutter_github_following_app/provider/userProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();

  void _getUser() {
    if (_controller.text == '') {
      Provider.of<UserProvider>(context, listen: false)
          .setErrorMessage("Please Enter Github UserName");
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .fetchUser(_controller.text)
          .then((data) {
        if (data) {
          Navigator.of(context).pushNamed(FollowingPage.routeName);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width as double) * 0.5,
                height: (MediaQuery.of(context).size.height as double) * 0.3,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(
                    "asset/image/github-logo.svg",
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Github Following",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: (MediaQuery.of(context).size.width as double) * 0.8,
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white.withOpacity(.2),
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Github UserName",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    errorText: Provider.of<UserProvider>(context, listen: false)
                        .getErrorMessage(),
                    errorStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  controller: _controller,
                  enabled: !Provider.of<UserProvider>(context, listen: false)
                      .isLoading(),
                  onChanged: (String value) {
                    Provider.of<UserProvider>(context, listen: false)
                        .setErrorMessage(null);
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: (MediaQuery.of(context).size.width as double) * 0.8,
                child: MaterialButton(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.blue,
                  child: Provider.of<UserProvider>(context, listen: false)
                          .isLoading()
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          "Get Your Following Here",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () => _getUser(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
