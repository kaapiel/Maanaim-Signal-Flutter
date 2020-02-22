import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maanaim_signal/sign_in.dart';

class ContinueRegister extends StatelessWidget {
  ContinueRegister({Key key, this.map}) : super(key: key);
  final Map<bool,String> map;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Cadastro Google/Facebook',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: ContinueRegisterPage(title: 'Cadastro Google/Facebook', map: map),
    );
  }
}

class ContinueRegisterPage extends StatefulWidget {
  ContinueRegisterPage({Key key, this.title, this.map}) : super(key: key);
  final String title;
  final Map<bool,String> map;

  @override
  _ContinueRegisterPageState createState() => _ContinueRegisterPageState();

}

class _ContinueRegisterPageState extends State<ContinueRegisterPage> implements BaseAuth {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String registerMessage = "";
  String selectedFunction = "Selecione sua função";
  String selectedRegion = "Selecione uma Região";
  String selectedSector = "Selecione um Setor";
  String selectedsupervision = "Selecione uma Supervisão";
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  List<String> functions = new List<String>();
  List<String> setores = new List<String>();
  List<String> regioes = new List<String>();
  List<String> supervisoes = new List<String>();
  String email;

  @override
  void initState() {

    try {
      var split = widget.map.values.first.split("email: ")[1].split(", pic")[0];
      email = split;
    } catch (e) {
      email = widget.map.values.first;
    }

    functions.add("Pr. Presidente");
    functions.add("Pr. de Região");
    functions.add("Líder de Setor");
    functions.add("Supervisor");
    functions.add("Líder de IC");
    regioes.add("Cinza");
    regioes.add("Vermelha");
    regioes.add("Laranja");
    setores.add("joyce e flavio");
    setores.add("set2");
    setores.add("set3");
    supervisoes.add("sup1");
    supervisoes.add("sup2");
    supervisoes.add("sup3");
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
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
            Container(
              width: 300,
              height: 200,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
              child: Image(
                image: AssetImage("assets/maanaim.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                controller: emailController,
                maxLines: 1,
                obscureText: false,
                autofocus: false,
                style: style,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                maxLength: 50,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),
                    hintText: email,
                    icon: Icon(
                      Icons.mail,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)
                    )
                ),
              ),
            ),
            Container (
              padding: EdgeInsets.fromLTRB(70, 0, 30, 20),
              child: DropdownButton<String>(
                hint: Text(
                  selectedFunction,
                  style: Theme.of(context).textTheme.headline,
                  textAlign: TextAlign.center,
                ),
                items: functions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFunction = value;
                    selectedRegion = "Selecione uma Região";
                    selectedSector = "Selecione um Setor";
                    selectedsupervision = "Selecione uma Supervisão";
                  });
                },
              ),
            ),
            _handleFuction(),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Material (
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.deepOrange,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () => _validateRegister(),
                  child: Text( "Finalizar cadastro",
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

  @override
  Future<FirebaseUser> getCurrentUser() {
    return null;
  }

  @override
  Future<bool> isEmailVerified() {
    return null;
  }

  @override
  Future<void> sendEmailVerification() {
    return null;
  }

  @override
  Future<String> signIn(String email, String password) {
    return null;
  }

  @override
  Future<void> signOut() {
    return null;
  }

  _waitForUserToRead() async {
    await Future.delayed(Duration(milliseconds: 1500));
  }

  Future<String> signUp(String email, String password) async {
    return null;
  }

  Widget _handleFuction() {

    if (selectedFunction == "Pr. de Região") {
      //get regioes
      return _getRegioesDropDown(regioes);

    } else if (selectedFunction == "Líder de Setor") {
      //get regioes
      return _getSetorDropDown("Nome do setor", regioes);

    } else if (selectedFunction == "Supervisor") {
      //get regioes
      //get setores
      return _getSupervisaoDropDown("Nome da supervisão", regioes, setores);

    } else if (selectedFunction == "Líder de IC"){
      //get regioes
      //get setores
      //get supervisoes
      return _getICDropDown("Nome da IC", regioes, setores, supervisoes);
    }
    return SizedBox(
        height: 20
    );
  }

  _validateRegister() {

    if (selectedFunction == "Selecione sua função") {
      registerMessage = selectedFunction+"!";
      final snackBar = SnackBar(content: Text(registerMessage));
      scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    } else if (selectedFunction == "Pr. Presidente") {
      //request pr president list size. If > 2 :
      //registerMessage = "Os pastores presidentes já foram cadastrados";
      //final snackBar = SnackBar(content: Text(registerMessage));
      //scaffoldKey.currentState.showSnackBar(snackBar);
    } else if (selectedFunction == "Pr. de Região") {
      if (selectedRegion == "Selecione uma Região"){
        registerMessage = selectedRegion+"!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
    } else if (selectedFunction == "Líder de Setor") {
      if (selectedRegion == "Selecione uma Região"){
        registerMessage = selectedRegion+"!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (nameController.text.isEmpty || nameController.text.length < 4){
        registerMessage = "Nome do setor inválido";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
    } else if (selectedFunction == "Supervisor") {
      if (selectedRegion == "Selecione uma Região"){
        registerMessage = selectedRegion+"!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (selectedSector == "Selecione um Setor"){
        registerMessage = selectedSector+"!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (nameController.text.isEmpty || nameController.text.length < 4){
        registerMessage = "Nome da supervisão inválida";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
    } else if (selectedFunction == "Líder de IC") {
      if (selectedRegion == "Selecione uma Região"){
        registerMessage = selectedRegion+"!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (selectedSector == "Selecione um Setor"){
        registerMessage = selectedSector+"!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (selectedsupervision == "Selecione uma Supervisão"){
        registerMessage = selectedsupervision+"!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (nameController.text.isEmpty || nameController.text.length < 4){
        registerMessage = "Nome da IC inválido";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }


    }

    //if pr presidente size > 2 remove
    //final snackBar = SnackBar(content: Text("Os pastores presidentes já foram cadastrados"));
    //scaffoldKey.currentState.showSnackBar(snackBar);

    //update info by email

    //set function code
    //set ic name
    //set admin level

  }

  Widget _getFieldWithHint(String hint) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column (
          children: <Widget>[
            TextFormField(
              controller: nameController,
              maxLines: 1,
              obscureText: false,
              autofocus: false,
              style: style,
              maxLength: 16,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                      20.0, 15.0, 20.0, 15.0),
                  hintText: hint,
                  icon: Icon(
                    Icons.border_color,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)
                  )
              ),
            ),
          ],
        )
    );
  }

  Widget _getRegioesDropDown(List<String> regioes){
    return Container (
      padding: EdgeInsets.fromLTRB(70, 0, 30, 20),
      child: DropdownButton<String>(
        hint: Text(
          selectedRegion,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
        items: regioes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedRegion = value;
          });
        },
      ),
    );
  }

  Widget _getSetoresDropDown(List<String> setores){
    return Container (
      padding: EdgeInsets.fromLTRB(70, 0, 30, 20),
      child: DropdownButton<String>(
        hint: Text(
          selectedSector,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
        items: setores.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedSector = value;
          });
        },
      ),
    );
  }

  Widget _getSupervisoesDropDown(List<String> supervisoes){
    return Container (
      padding: EdgeInsets.fromLTRB(70, 0, 30, 20),
      child: DropdownButton<String>(
        hint: Text(
          selectedsupervision,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
        items: supervisoes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedsupervision = value;
          });
        },
      ),
    );
  }

  Widget _getSetorDropDown(String hint, List<String> regioes) {
    return Container (
        child: Column(
          children: <Widget>[
            _getRegioesDropDown(regioes),
            _getFieldWithHint(hint)
          ],
        )
    );
  }

  Widget _getSupervisaoDropDown(String hint, List<String> regioes, List<String> setores) {
    return Container (
        child: Column(
          children: <Widget>[
            _getRegioesDropDown(regioes),
            _getSetoresDropDown(setores),
            _getFieldWithHint(hint)
          ],
        )
    );
  }

  Widget _getICDropDown(String hint, List<String> regioes, List<String> setores, List<String> supervisoes) {
    return Container (
        child: Column(
          children: <Widget>[
            _getRegioesDropDown(regioes),
            _getSetoresDropDown(setores),
            _getSupervisoesDropDown(supervisoes),
            _getFieldWithHint(hint)
          ],
        )
    );
  }
}