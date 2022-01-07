import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class email extends StatefulWidget {
  const email({Key? key}) : super(key: key);

  @override
  _emailState createState() => _emailState();
}

class _emailState extends State<email> {
  var phone = "";
  var sub = "";
  var msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Galaxy.png'), fit: BoxFit.cover)),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    phone = value;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white60,
                      filled: true,
                      focusColor: Colors.white60,
                      hoverColor: Colors.white60,
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white60),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      hintText: "Receiver Email",
                      labelText: "To",
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    sub = value;
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white60,
                      filled: true,
                      focusColor: Colors.white60,
                      hoverColor: Colors.white60,
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white60),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      hintText: "Add your Subject here",
                      labelText: "Subject",
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    msg = value;
                  },
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                      fillColor: Colors.white60,
                      filled: true,
                      focusColor: Colors.white60,
                      hoverColor: Colors.white60,
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white60),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      hintText: "Enter your Message here",
                      labelText: "Message",
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white60,
                  elevation: 5,
                  child: MaterialButton(
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      // https://wa.me/1XXXXXXXXXX?text=I'm%20interested%20in%20your%20car%20for%20sale

                      if (phone.length < 10) {
                        Fluttertoast.showToast(
                            msg: "Enter a valid Email",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            webPosition: "center",
                            fontSize: 16.0);
                      } else {
                        var url =
                            "mailto:$phone?subject=${Uri.encodeFull(sub)}&body=${Uri.encodeFull(msg)}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          Fluttertoast.showToast(msg: "Could not launch $url");
                        }
                        // print(code);
                      }
                    },
                    minWidth: 130,
                    height: 40,
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
