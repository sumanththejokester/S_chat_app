import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class sms extends StatefulWidget {
  const sms({Key? key}) : super(key: key);

  @override
  _smsState createState() => _smsState();
}

class _smsState extends State<sms> {
  var phone = "";
  var msg = "";
  var code = "+91";

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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white60,
                  ),
                  child: CountryCodePicker(
                    onChanged: (val) {
                      code = val.toString();
                    },
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: 'IN',
                    favorite: ['+91', 'IN'],
                    // optional. Shows only country name and flag
                    showCountryOnly: false,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.phone,
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
                      hintText: "Phone",
                      labelText: "Mobile number",
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
                  minLines: 3,
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
                      labelText: "Message"),
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
                            msg: "Enter a valid phone number",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            webPosition: "center",
                            fontSize: 16.0);
                      } else {
                        code = code.replaceAll("+", "");

                        var url = "sms:$code$phone?body=$msg";
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
