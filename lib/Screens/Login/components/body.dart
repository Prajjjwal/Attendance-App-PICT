import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pict_mis/Screens/Login/components/background.dart';
import 'package:pict_mis/components/rounded_button.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';
import 'package:pict_mis/components/text_field_container.dart';
import 'package:pict_mis/constants.dart';
import 'package:pict_mis/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController uid = TextEditingController();
    TextEditingController password = TextEditingController();

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),

            TextFieldContainer(
              child: TextField(
                controller: uid,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  hintText: "User Id",
                  border: InputBorder.none,
                ),
              ),
            ),
            // RoundedInputField(
            //   hintText: "User id",
            //   onChanged: (value) {},
            // ),
            TextFieldContainer(
              child: TextField(
                obscureText: true,
                cursorColor: kPrimaryColor,
                controller: password,
                decoration: const InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            // RoundedPasswordField(
            //   onChanged: (value) {
            //     pass = value;
            //   },
            // ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            RoundedButton(
                text: "LOGIN",
                press: () async {
                  String id = uid.text.trim();
                  String pass = password.text.trim();
                  if (id.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("User id is still empty"),
                      backgroundColor: kPrimaryColor,
                    ));
                  } else if (pass.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Password is stiil empty"),
                      backgroundColor: kPrimaryColor,
                    ));
                  } else {
                    try {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("user")
                          .where("id", isEqualTo: id)
                          .get();

                      if (pass == snap.docs[0]['password']) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: snap.docs[0]['email'], password: pass)
                            .then((value) => {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (_) => false),
                                });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Incorrect Password!!"),
                          backgroundColor: kPrimaryColor,
                        ));
                      }
                    } catch (e) {
                      if (e.toString() ==
                          "RangeError (index): Invalid value: Valid value range is empty: 0") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("User id does not exists."),
                          backgroundColor: kPrimaryColor,
                        ));
                      } else {
                        // print(e.toString());
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Error Occured!"),
                          backgroundColor: kPrimaryColor,
                        ));
                      }
                    }
                  }
                }),
            SizedBox(height: size.height * 0.03),
            // AlreadyHaveAnAccountCheck(
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return SignUpScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
