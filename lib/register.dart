import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maanaim_signal/sign_in.dart';

class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: RegisterPage(title: 'Cadastro'),
    );
  }
}

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> implements BaseAuth {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String registerMessage = "";
  String selectedFunction = "Selecione sua função";
  String selectedRegion = "Selecione uma Região";
  String selectedSector = "Selecione um Setor";
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
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
                keyboardType: TextInputType.emailAddress,
                maxLength: 50,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),
                    hintText: "E-mail",
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
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                controller: passController,
                maxLines: 1,
                obscureText: true,
                autofocus: false,
                style: style,
                maxLength: 16,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),
                    hintText: "Senha",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)
                    )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                controller: confirmPassController,
                maxLines: 1,
                obscureText: true,
                autofocus: false,
                style: style,
                maxLength: 16,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),
                    hintText: "Confirmar Senha",
                    icon: Icon(
                      Icons.lock,
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
                items: <String>[
                  'Pr. Presidente',
                  'Pr. de Região',
                  'Líder de Setor',
                  'Supervisor',
                  'Líder de IC'
                ].map((String value) {
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

  @override
  Future<String> signUp(String email, String password) {
    return null;
  }

  Widget _handleFuction() {

    List<String> regioes = new List<String>();
    regioes.add("Cinza");
    regioes.add("Vermelha");
    regioes.add("Laranja");

    List<String> setores = new List<String>();
    setores.add("joyce e flavio");
    setores.add("set2");
    setores.add("set3");

    if (selectedFunction == "Pr. Presidente") {

      //if pr presidente size > 2 remove
      //final snackBar = SnackBar(content: Text("Os pastores presidentes já foram cadastrados"));
      //scaffoldKey.currentState.showSnackBar(snackBar);

    } else if (selectedFunction == "Pr. de Região") {
      //get regioes
      return _getRegioesDropDown(regioes);

    } else if (selectedFunction == "Líder de Setor") {
      return _getSetorDropDown("Nome do setor", regioes);

    } else if (selectedFunction == "Supervisor") {
      return _getSupervisaoDropDown("Nome da supervisão", regioes, setores);

    } else if (selectedFunction == "Líder de IC"){
      return _getFieldWithHint("Nome da IC");
    }
    return SizedBox(
        height: 20
    );
  }

  _validateRegister() {

    if(emailController.text.isEmpty || passController.text.isEmpty ||
        confirmPassController.text.isEmpty || nameController.text.isEmpty){
      registerMessage = "Não podem haver campos vazios.";
      final snackBar = SnackBar(content: Text(registerMessage));
      scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }

    signUp(emailController.text, passController.text).then((String msg) {
      final snackBar = SnackBar(content: Text(msg));
      scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    });

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
            obscureText: true,
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
}