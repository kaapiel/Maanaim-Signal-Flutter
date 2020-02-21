import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maanaim_signal/register.dart';
import 'package:maanaim_signal/signal.dart';
import 'package:maanaim_signal/sign_in.dart';

class Login extends StatelessWidget {

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

class _LoginPageState extends State<LoginPage> implements BaseAuth {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String authMessage = "";

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
              width: 300,
              height: 200,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
              child: Image (
                image: AssetImage("assets/maanaim.png"),
              ),
            ),
            Container (
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                      hintText: "E-mail",
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
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Material (
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.deepOrange,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Register();
                          },
                        )
                    );
                  },
                  child: Text( "Cadastrar",
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
                height: 10
            ),
            _googleSignInButton(),
            SizedBox(
                height: 10
            ),
            _facebookSignInButton(),
            SizedBox(
                height: 30
            ),
          ],
        ),
      ),
    );
  }

  _validateCredentials(String email, String pass) {

    if(email.isEmpty || pass.isEmpty){
      authMessage = "Não podem haver campos vazios.";
      final snackBar = SnackBar(content: Text(authMessage));
      scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }

    signIn(email, pass).then((String msg) {
      final snackBar = SnackBar(content: Text(msg));
      scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    });

  }

  Widget _facebookSignInButton() {
    return Container (
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage("assets/facebook_logo.png"), height: 35.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Entrar com Facebook',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget _googleSignInButton() {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 13, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/google_logo.png"),
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Entrar com Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Future<String> signIn(String email, String password) async {

    AuthResult result;

    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } catch (e) {
      if (e.toString().contains("ERROR_INVALID_EMAIL")){
        authMessage = "Formato de e-mail inválido";
      } else if (e.toString().contains("ERROR_USER_NOT_FOUND")){
        authMessage = "Usuário não cadastrado";
      } else if (e.toString().contains("ERROR_WRONG_PASSWORD")){
        authMessage = "Senha inválida";
      }
      final snackBar = SnackBar(content: Text(authMessage));
      scaffoldKey.currentState.showSnackBar(snackBar);
    }


    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

}
