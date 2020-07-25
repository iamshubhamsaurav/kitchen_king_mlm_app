import 'package:flutter/material.dart';
import 'member_page.dart';
import 'member_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  // static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userIdFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  String invalidLoginText = "";
  bool isLoginButtonEnabled = true;

  void _setFieldsToDefaults() {
    _userIdFieldController.text = "";
    _passwordFieldController.text = "";
  }

  void handleLogin() {
    setState(() {
      isLoginButtonEnabled = false;
      invalidLoginText = "";
    });
    if (!_userIdFieldController.text.startsWith('kk')) {
      // == "komal"
      loginAdmin();
    } else {
      if (_userIdFieldController.text.length == 6 &&
          _userIdFieldController.text.startsWith("kk")) {
        loginMember();
      } else {
        setState(() {
          invalidLoginText = "Invalid User Id";
        });
      }
    }
  }

  void loginAdmin() async {
    await Firestore.instance
        .collection('admin')
        .document('admin')
        .get()
        .then((DocumentSnapshot document) {
      if (document['password'] == _passwordFieldController.text &&
          document['id'] == _userIdFieldController.text) {
        setState(() {
          invalidLoginText = "";
          isLoginButtonEnabled = true;
        });
        _setFieldsToDefaults();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemberList()),
        );
      } else {
        setState(() {
          invalidLoginText = "Invalid Id/Password";
          isLoginButtonEnabled = true;
        });
      }
    });
  }

// Added toLowerCase() for ease of use.
  void loginMember() async {
    await Firestore.instance
        .collection('members')
        .document(_userIdFieldController.text.toLowerCase())
        .get()
        .then((DocumentSnapshot document) {
      if (document['password'] == _passwordFieldController.text &&
          document['id'] == _userIdFieldController.text.toLowerCase()) {
        setState(() {
          invalidLoginText = "";
          isLoginButtonEnabled = true;
        });
        _setFieldsToDefaults();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemberPage(
              isAdmin: false,
              document: document,
            ),
          ),
        );
      } else {
        setState(() {
          invalidLoginText = "Invalid Id/Password";
          isLoginButtonEnabled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        child: Image.asset(
          'lib/assets/icon/launcher_icon.jpeg',
        ),
        backgroundColor: Colors.grey,
        radius: 75.0,
//        child: Image.asset('assets/logo.png'),
      ),
    );

    final userId = TextFormField(
      controller: _userIdFieldController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'User Id',
        labelText: "User Id",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordFieldController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final invalidLogin =
        Text(invalidLoginText, style: TextStyle(color: Colors.red));

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: isLoginButtonEnabled ? handleLogin : null,
        padding: EdgeInsets.all(12),
        color: isLoginButtonEnabled ? Colors.lightBlueAccent : Colors.blueGrey,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            userId,
            SizedBox(height: 20.0),
            password,
            SizedBox(height: 8.0),
            invalidLogin,
            // SizedBox(height: 24.0),
            loginButton,
            // forgotLabel
          ],
        ),
      ),
    );
  }
}
