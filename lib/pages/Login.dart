import 'package:flutter/material.dart';
import 'package:flutter_app1/HomePage.dart';
import 'package:flutter_app1/pages/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKy = GlobalKey<FormState>();
  TextEditingController _emailTextEditControler = new TextEditingController();
  TextEditingController _passwordTextEditControler =
      new TextEditingController();
  SharedPreferences preferences;
  bool Loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  /// method to check if SignedIn */
  void isSignedIn() async {
    setState(() {
      Loading = true;
    });
    await firebaseAuth.currentUser().then((user) {
      if (user != null) {
        setState(() {
          Loading = false;
        });
      }
    });
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    /// return true or false if user did login

    /// to get user authontication if user login
    /// check if user is login
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));

      /// will move to HomePage whene ensure the user is definitly loged in .
    }

    /// will change the state of loding to false after the user do sighn in .
    setState(() {
      Loading = false;
    });
  }

  /// end of isSignedIn method

  /// start handelSignInWithEmailAndPass method
  Future handelSignInWithEmailAndPass() async {
    preferences = await SharedPreferences.getInstance();

    ///  persistent store for simple and critical data.
    isLogedin = await googleSignIn.isSignedIn();

    /// to check if the user did login
    setState(() {
      Loading = true;

      /// to change the state of loding variable.
    });

    try {
      AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: _emailTextEditControler.text,
          password: _passwordTextEditControler.text);
      final FirebaseUser user = authResult.user;
      //  assert(user != null);
      //  assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await firebaseAuth.currentUser();
      //  assert(user.uid == currentUser.uid);
      print('signInEmail succeeded: $user');
      if (currentUser.uid != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "your email or password was Wrong ",
          toastLength: Toast.LENGTH_SHORT);
      setState(() {
        Loading = false;

        /// to change the state of loding variable.
      });
    }
  }

  /// End  handelSignInWithEmailAndPass method
  //*************************************************************
  /// start handleSignIn method
  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      Loading = true;
    });
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult =
        await firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    /// check if the user has google account .
    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> document = result.documents;

      /// if we dont have a user with the same id in firebas
      if (document.length == 0) {
        /// insert the user to our collection
        Firestore.instance.collection("users").document(user.uid).setData({
          'id': user.uid,
          "username": user.displayName,
          "photoUrl": user.photoUrl,
        });
        await preferences.setString("id", user.uid);
        await preferences.setString("username", user.displayName);
        await preferences.setString("photoUrl", user.photoUrl);

        /// if the user is exist .....
      } else {
        await preferences.setString("id", document[0]["id"]);
        await preferences.setString("username", document[0]["username"]);
        await preferences.setString("photoUrl", document[0]["photoUrl"]);
      }

      /// to move to home activity when user login
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      setState(() {
        Loading = false;
        isLogedin = true;
      }); // modify Loding variable to false ;

    } else {
      Fluttertoast.showToast(msg: "the user undefind");

      /// show message if user dosent definded
    }
  }

  /// End handleSignIn method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/login/loginpic.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          /// shado countener
          Container(
            color: Colors.black.withOpacity(0.6),
            width: double.infinity,
            height: double.infinity,
          ),

          /// logo image login
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Image.asset(
                "images/login/logofashion.png",
                width: 200,
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[350], blurRadius: 20.0)
                  ]),
              child: Form(
                key: _formKy,
                child: ListView(
                  children: <Widget>[
                    /// email text feaild
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _emailTextEditControler,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              icon: Icon(Icons.alternate_email),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    /// password text feaild
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _passwordTextEditControler,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              icon: Icon(Icons.lock_outline),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'password faild cont be empty';
                                if (value.length < 6) {
                                  return 'Please make sure your password at least 6 caracters';
                                } else
                                  return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    /// login boutton
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.blue.withOpacity(0.8),
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: () {
                            handelSignInWithEmailAndPass();
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "Login ",
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

                    /// forgot password
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Forgot password",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    /**   dont have an account sighn up        */
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Dont have an account ? click here to ",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SighnUp()));
                            },
                            child: Text(
                              "sighn up!",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(color: Colors.white),

                    /// outher sighn in with Option
                    Text(
                      "Outher sighn in with Option ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    /// button sighn in with google
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.red.shade700,
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: () {
                            handleSignIn();
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "images/login/google.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Text(
                                "Sighn In With Google",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// text Or login with
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
                              'Or Login with',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
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

                    /// Buttion login with google or facebook
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
                              onPressed: () {},
                              child: Image.asset(
                                "images/ggg.png",
                                width: 60,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          /// to visible the circle loder when do login
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
        ],
      ),
    );
  }
}
