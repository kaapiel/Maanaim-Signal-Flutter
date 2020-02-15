import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maanaim_signal/signal.dart';

class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoginPage(title: 'Splash Semáfoto'),
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
              child: Image (
                image: AssetImage("assets/maanaim.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
            ),
            Container (
              width: 350,
              child: TextField(
                obscureText: false,
                style: style,
                keyboardType: TextInputType.emailAddress,
                maxLength: 50,
                controller: emailController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)
                    )
                ),
              ),
            ),
            Container(
              width: 350,
              child: TextField(
                obscureText: true,
                style: style,
                maxLength: 16,
                controller: passController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Senha",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)
                    )
                ),
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
}
