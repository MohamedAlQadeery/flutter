import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/HomePage.dart';
import 'package:flutter_app1/commons/common.dart';
import 'package:flutter_app1/db/auth.dart';
import '../db/users.dart';

class SighnUp extends StatefulWidget {
  @override
  _SighnUpState createState() => _SighnUpState();
}

class _SighnUpState extends State<SighnUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// to get firebase requste
  final _formKy = GlobalKey<FormState>();
  UserServise _userServise = UserServise();
  TextEditingController _emailTextEditControler = new TextEditingController();
  TextEditingController _passwordTextEditControler =
      new TextEditingController();
  TextEditingController _confermPasswordTextEditControler =
      new TextEditingController();
  TextEditingController _nameTextEditControler = new TextEditingController();
  String gender;
  String groupValue = "male";
  bool hidePass = true;
  bool Loading = false;

  Auth  auth =Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Form(
              key: _formKy,
              child: ListView(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "images/login/logofashion.png",
                        width: 120,
                      ),
                    ),
                  ),

                  /// name text feaild
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: ListTile(
                          title: TextFormField(
                            controller: _nameTextEditControler,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              icon: Icon(Icons.person_outline),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "the name feaild cant be embty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// end name text feaild

                  /// email text feaild
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: ListTile(
                          title: TextFormField(
                            controller: _emailTextEditControler,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              icon: Icon(Icons.alternate_email),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please the email feaild cant be empty';
                              } else {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Please make sure your email address is valid';
                                } else {
                                  return null;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// end email text feaild

                  /// password text feaild
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: ListTile(
                          title: TextFormField(
                              controller: _passwordTextEditControler,
                              obscureText: hidePass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                icon: Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'password faild cont be empty';
                                } else if (value.length < 6) {
                                  return 'Please make sure your password at least 6 caracters';
                                } else
                                  return null;
                              }),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                hidePass = false;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// start confearm password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.withOpacity(0.2),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: ListTile(
                          title: TextFormField(
                            controller: _confermPasswordTextEditControler,
                            obscureText: hidePass,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confearm Password",
                              icon: Icon(Icons.lock_outline),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'password faild cont be empty';
                              } else if (value.length < 6) {
                                return 'Please make sure your password at least 6 caracters';
                              } else if (_confermPasswordTextEditControler
                                      .text !=
                                  value) {
                                return " password dosnt match";
                              }
                              return null;
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                hidePass = false;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// end confearm password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: Text(
                            "male",
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Radio(
                              value: "male",
                              groupValue: groupValue,
                              onChanged: (e) => (valueChanged(e))),
                        )),
                        Expanded(
                            child: ListTile(
                          title: Text("female",
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.black)),
                          trailing: Radio(
                              value: "female",
                              groupValue: groupValue,
                              onChanged: (e) => (valueChanged(e))),
                        )),
                      ],
                    ),
                  ),

                  /// start Sign up boutton
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue.shade700,
                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: () async {
                          validateForm();
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Sign up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //// login
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "I already have an account",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.normal,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Or sign up with',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          child: MaterialButton(
                            onPressed: () {},
                            child: Image.asset(
                              "images/fb.png",
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          child: MaterialButton(
                            onPressed: () async{
                              /// sign in with google
                              FirebaseUser user  = await auth.googleSignin();
                              if(user == null){
                                _userServise.createUser({
                                  "name":user.displayName,
                                  "photo":user.photoUrl,
                                  "email":user.email,
                                  "userId":user.uid
                                });
                                ChangeScreenReplacement(context,HomePage());
                              }
                            },
                            child: Image.asset(
                              "images/ggg.png",
                              width: 60,
                            ),
                          ),
                        ),
                      )
                    ],
                  )

                  ///end of login
                  /// start gender radio button
                ],
              ),
            ),
          ),

          ///  start to visible the circle loder when do login
          Visibility(
            visible: Loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.7),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              ),
            ),
          ),

          /// end  to visible the circle loder when do login
        ],
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    FormState formState = _formKy.currentState;

    if (formState.validate()) {
      FirebaseUser user = await firebaseAuth.currentUser();

      if (user.uid != null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextEditControler.text,
                password: _passwordTextEditControler.text)
            .then((user) => {
                  _userServise.createUser({
                    "userName": _nameTextEditControler.text,
                    "email": _emailTextEditControler.text,
                    "gender": gender,
                    "userId": user.user.uid,
                  })
                })
            .catchError((err) => {print('error is: ' + err.toString())});
        print(
            "user_________-------------------------------- idddddd" + user.uid);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
