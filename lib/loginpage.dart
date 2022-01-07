import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:message_app/controllers/loginController.dart';
import 'package:message_app/controllers/pages/email.dart';
import 'package:message_app/controllers/pages/sms.dart';
import 'package:message_app/controllers/pages/whatsapp.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "S chat",
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontFamily: "Island"),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),

      // body of our ui
      extendBodyBehindAppBar: true,
      body: loginUI(),
    );
  }

  // creating a function loginUI

  loginUI() {
    // loggedINUI
    // loginControllers

    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Galaxy.png'), fit: BoxFit.cover)),
      child: Consumer<LoginController>(builder: (context, model, child) {
        // if we are already logged in
        if (model.userDetails != null) {
          return Center(
            child: HomeScreen(model),
          );
        } else {
          return loginControllers(context);
        }
      }),
    );
  }

  loggedInUI(LoginController model) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Galaxy.png'), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        // our ui will have 3 children, name, email, photo , logout button

        children: [
          CircleAvatar(
            backgroundImage:
                Image.network(model.userDetails!.photoURL ?? "").image,
            radius: 50,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.userDetails!.displayName ?? "",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.userDetails!.email ?? "",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),

          // logout
          ActionChip(
              avatar: Icon(Icons.logout),
              label: Text("Logout"),
              onPressed: () {
                Provider.of<LoginController>(context, listen: false).logout();
              })
        ],
      ),
    );
  }

  loginControllers(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              child: Image.asset(
                "assets/google_logo (1).png",
                //color: Colors.transparent,
                width: 250,
              ),
              onTap: () {
                Provider.of<LoginController>(context, listen: false)
                    .googleLogin();
              }),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              child: Image.asset(
                "assets/facebook_logo.png",
                //color: Colors.white,
                width: 250,
              ),
              onTap: () {
                Provider.of<LoginController>(context, listen: false)
                    .facebooklogin();
              }),
        ],
      ),
    );
  }

  HomeScreen(LoginController model) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(''),
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                icon: Image.asset(
                  'assets/whatsapp.png',
                  width: 40,
                ),
                text: "Whatsapp",
              ),
              Tab(
                icon: Image.asset(
                  'assets/email.png',
                  width: 40,
                ),
                text: "Mail",
              ),
              Tab(
                icon: Image.asset(
                  'assets/sms.png',
                  width: 40,
                ),
                text: "SMS",
              ),
              Tab(
                icon: Image.asset(
                  'assets/login.png',
                  width: 40,
                ),
                text: "Login Info",
              ),
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Galaxy.png'), fit: BoxFit.cover)),
          child: TabBarView(
            children: [
              Center(child: whatsapp()),
              Center(child: email()),
              Center(child: sms()),
              Center(child: loggedInUI(model)),
            ],
          ),
        ),
      ),
    );
  }
}
