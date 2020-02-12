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
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[

            Container(
              width: 350,
              height: 150,
              child: Image(
                image: AssetImage("assets/maanaim.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
            ),
            Container(
              width: 200,
              child: Material (
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.deepOrange,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login()
                        )
                    );
                  },
                  child: Text( "Ir Para Login",
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
}
