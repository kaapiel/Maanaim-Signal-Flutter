import 'package:flutter/material.dart';
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
      print('Async done');
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Login()
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
              width: 350,
              height: 150,
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("assets/maanaim.png"),
              ),
            ),
        ),
    );
  }

  _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 3));
  }
}
