import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maanaim_signal/signal.dart';
import 'package:maanaim_signal/sign_in.dart';

class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoginPage(title: 'Login'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    setState(() {

    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[

            Container (
              width: 350,
              height: 150,
              margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Image (
                image: AssetImage("assets/maanaim.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
            ),
            Container (
              width: 350,
              child: TextFormField(
                maxLines: 1,
                obscureText: false,
                autofocus: false,
                style: style,
                keyboardType: TextInputType.emailAddress,
                maxLength: 50,
                controller: emailController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    icon: Icon(
                      Icons.mail,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)
                    )
                ),
                validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null
              ),
            ),
            Container(
              width: 350,
              child: TextFormField(
                maxLines: 1,
                obscureText: true,
                autofocus: false,
                style: style,
                maxLength: 16,
                controller: passController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Senha",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)
                    )
                ),
                validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null
              ),
            ),
            Container(
              width: 350,
              child: Material (
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.deepOrange,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () => _validateCredentials("${emailController.text}", "${passController.text}"),
                  child: Text( "Login",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            _googleSignInButton(),
            SizedBox(
                height: 10
            ),
            _facebookSignInButton()
          ],
        ),
      ),
    );
  }

  _validateCredentials(String email, String pass) {

    String message = "";

    if (email.isEmpty | pass.isEmpty) {
      message = "Credentials must not be empty";
    } else if (pass == "123"){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Signal()
      ));
    } else {
      message = "Invalid username or password";
    }
    final snackBar = SnackBar(content: Text(message));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _facebookSignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithFacebook().then((Map<bool,String> map){
          if (map.keys.iterator.moveNext()) {
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Signal();
                  },
                  settings: RouteSettings(
                      arguments: map
                  ),
                )
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/facebook_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Facebook',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Signal();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
