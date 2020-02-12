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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
            Padding(
              padding: EdgeInsets.all(30),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text( "Voltar para Splash",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            )
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
