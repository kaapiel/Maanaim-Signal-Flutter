import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maanaim_signal/fade_transictions.dart';
import 'package:maanaim_signal/login.dart';

void main() => runApp(Splash());

class Splash extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SplashPage(title: 'Splash Semáfoto'),
    );
  }
}

class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _getThingsOnStartup().then((value){
      Navigator.push(context, FadeRoute(
          page: Login()
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        body: Center(
          child: Container(
              width: 300,
              height: 120,
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("assets/logo_farol.jpeg"),
              ),
            ),
        ),
    );
  }

  _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 3));
  }
}
