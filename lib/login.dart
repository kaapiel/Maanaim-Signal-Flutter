import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maanaim_signal/continue_register.dart';
import 'package:maanaim_signal/logged_in_filters.dart';
import 'package:maanaim_signal/maanaim_structure.dart';
import 'package:maanaim_signal/register.dart';
import 'package:maanaim_signal/sign_in.dart';
import 'package:maanaim_signal/signal.dart';

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
                image: AssetImage("assets/logo_farol.jpeg"),
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
                  validator: (value) => value.isEmpty ? 'O campo e-mail não pode estar vazio' : null
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
                  validator: (value) => value.isEmpty ? 'O campo senha não pode estar vazio' : null
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

    signIn(email, pass).then((Map<String, FirebaseUser> map) {
      final snackBar = SnackBar(content: Text(map.keys.first));
      scaffoldKey.currentState.showSnackBar(snackBar);

      _waitForUserToRead();

      FirebaseDatabase.instance.reference().once().then((DataSnapshot ds){
        var firebaseRetrieveData = new Map<String, dynamic>.from(ds.value);

        //logou?
        if(map.values.first != null){
          var structure = _privilegies(MaanaimStructure.fromJson(firebaseRetrieveData), email);
          _redirectLogin(structure);
        }
      });
      return;
    });

  }

  _waitForUserToRead() async {
    await Future.delayed(Duration(milliseconds: 1500));
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

                if (map.keys.first) {
                  FirebaseDatabase.instance.reference().once().then((DataSnapshot ds){
                    var firebaseRetrieveData = new Map<String, dynamic>.from(ds.value);
                    if (firebaseRetrieveData.toString().contains(map.values.first)){
                      var structure = _privilegies(MaanaimStructure.fromJson(firebaseRetrieveData), map.values.first);
                      _redirectLogin(structure);
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ContinueRegister(map: map);
                            },
                          )
                      );
                    }
                  });

                } else {
                  authMessage = "Falha no login";
                  final snackBar = SnackBar(content: Text(authMessage));
                  scaffoldKey.currentState.showSnackBar(snackBar);
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
              signInWithGoogle().then((Map<bool,String> map) {

                if (map.keys.first) {
                  FirebaseDatabase.instance.reference().once().then((DataSnapshot ds){
                    var firebaseRetrieveData = new Map<String, dynamic>.from(ds.value);
                    if (firebaseRetrieveData.toString().contains(map.values.first)){
                      var structure = _privilegies(MaanaimStructure.fromJson(firebaseRetrieveData), map.values.first);
                      _redirectLogin(structure);
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ContinueRegister(map: map);
                            },
                          )
                      );
                    }
                  });

                } else {
                  authMessage = "Falha no login";
                  final snackBar = SnackBar(content: Text(authMessage));
                  scaffoldKey.currentState.showSnackBar(snackBar);
                }

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

  Future<Map<String, FirebaseUser>> signIn(String email, String password) async {

    AuthResult result;

    authMessage = "Usuário autenticado com sucesso";

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
    }

    Map<String, FirebaseUser> map;

    try {

      FirebaseUser user = result.user;
      map = {
        authMessage: user,
      };
    } catch(e){
      map = {
        authMessage: null,
      };
    }

    return map;
  }

  Future<String> signUp(String email, String password) async {
    return null;
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

  Object _privilegies(MaanaimStructure ms, String email){

    //pr. presidente
    if(ms != null && ms.u != null && ms.u.containsValue(email)){
      return ms;
    }

    //pr. regiao
    if(ms.regs != null){
      for(Regiao r in ms.regs){
        if(r.u != null && r.u.containsValue(email)){
          return r;
        }
      }
    }

    //lider setor
    if(ms.regs != null){
      for(Regiao r in ms.regs){
        if(r.sets != null){
          for(Setor s in r.sets){
            if(s.u != null && s.u.containsValue(email)){
              return s;
            }
          }
        }
      }
    }

    //supervisor
    if(ms.regs != null){
      for(Regiao r in ms.regs){
        if(r.sets != null){
          for(Setor s in r.sets){
            if(s.sups != null){
              for(Supervisao sup in s.sups){
                if(sup.u != null && sup.u.containsValue(email)){
                  return sup;
                }
              }
            }
          }
        }
      }
    }

    //ics
    if(ms.regs != null){
      for(Regiao r in ms.regs){
        if(r.sets != null){
          for(Setor s in r.sets){
            if(s.sups != null){
              for(Supervisao sup in s.sups){
                if(sup.ics != null){
                  for(IC i in sup.ics){
                    if(i.u != null && i.u.containsValue(email)){
                      return i;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  _redirectLogin(Object o) {

    if (o is IC) {
      print("Olá Líder de IC");
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Signal(ic: o);
            },
          )
      );
    } else {

      if(o is MaanaimStructure){
        print("Olá Pastor Presidente");
      } else if (o is Regiao){
        print("Olá Pastor de Regiao");
      } else if (o is Setor){
        print("Olá Líder de Setor");
      } else if (o is Supervisao){
        print("Olá Supervisor");
      }

      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return LoggedInFilters(structure: o);
            },
          )
      );

    }
  }

}
