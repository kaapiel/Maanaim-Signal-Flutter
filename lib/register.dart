import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maanaim_signal/fade_transictions.dart';
import 'package:maanaim_signal/login.dart';
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
  String selectedSupervision = "Selecione uma Supervisão";
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();
  String authMessage = "";
  List<String> functions = new List<String>();
  List<String> setores = new List<String>();
  List<String> supervisoes = new List<String>();
  List<String> regioes = new List<String>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Você tem certeza?'),
        content: new Text('Você quer sair do app'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Não'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Sim'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  void initState() {
    functions.add("Pr. Presidente");
    functions.add("Pr. de Região");
    functions.add("Líder de Setor");
    functions.add("Supervisor");
    functions.add("Líder de IC");
    _updateRegioesList();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                    image: AssetImage("assets/logo_farol.jpeg"),
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
                Container(
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
                        selectedSupervision = "Selecione uma Supervisão";
                      });
                    },
                  ),
                ),
                _handleContainerDropDowns(),
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
                SizedBox(
                    height: 20
                ),
              ],
            ),
          ),
        )
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
  Future<Map<String, FirebaseUser>> signIn(String email, String password) {
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
    AuthResult result;

    try {
      result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      if (e.toString().contains("ERROR_INVALID_EMAIL")){
        registerMessage = "Formato de e-mail inválido";
      } else if (e.toString().contains("ERROR_WEAK_PASSWORD")){
        registerMessage = "A senha deve conter no mínimo 6 caracteres";
      } else if (e.toString().contains("ERROR_EMAIL_ALREADY_IN_USE")) {
        registerMessage = "Este e-mail já está sendo usado por outro usuário";
      }

      final snackBar = SnackBar(content: Text(registerMessage));
      scaffoldKey.currentState.showSnackBar(snackBar);
    }

    FirebaseUser user = result.user;
    return user.uid;
  }

  Widget _handleContainerDropDowns() {

    if (selectedFunction == "Pr. de Região") {
      return _getRegioesDropDown();

    } else if (selectedFunction == "Líder de Setor") {
      return _getSetorContainer("Nome do setor");

    } else if (selectedFunction == "Supervisor") {
      return _getSupervisaoContainer("Nome da supervisão");

    } else if (selectedFunction == "Líder de IC"){
      return _getICContainer("Nome da IC");
    }
    return SizedBox(
        height: 20
    );
  }

  _validateRegister() {

    FirebaseDatabase.instance.reference().child("ae").once().then((DataSnapshot ds){
      var firebaseRetrieveData = new Map<String, dynamic>.from(ds.value);
      if(!firebaseRetrieveData.containsValue(emailController.text)){
        print("Usuário não autorizado");
        authMessage = "Usuário não autorizado";
        final snackBar = SnackBar(content: Text(authMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
    });

    if (emailController.text.isEmpty || passController.text.isEmpty || confirmPassController.text.isEmpty) {
      registerMessage = "Não podem haver campos vazios.";
      final snackBar = SnackBar(content: Text(registerMessage));
      scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }
     else if (passController.text != confirmPassController.text) {
      registerMessage = "As senhas não conferem";
      final snackBar = SnackBar(content: Text(registerMessage));
      scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }
    if (selectedFunction == "Selecione sua função") {
      registerMessage = selectedFunction + "!";
      final snackBar = SnackBar(content: Text(registerMessage));
      scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }
    else if (selectedFunction == "Pr. Presidente") {
      var child = FirebaseDatabase.instance.reference().child("u");
      child.once().then((DataSnapshot ds) {
        Map<String, dynamic> map;
        try {
          map = new Map<String, dynamic>.from(ds.value);
        } catch (e) {
          child.set({
            'e0': emailController.text
          });

          signUp(emailController.text, passController.text).then((String msg) {
            if (msg.isNotEmpty) {
              registerMessage = "Usuário cadastrado com sucesso";
              final snackBar = SnackBar(content: Text(registerMessage));
              scaffoldKey.currentState.showSnackBar(snackBar);

              _waitForUserToRead().then((value) {
                Navigator.push(context, FadeRoute(
                    page: Login()
                ));
              });

              return;
            }
          });

          return;
        }

        if (map.length >= 2) {
          final snackBar = SnackBar(
              content: Text("Os pastores presidentes já foram cadastrados"));
          scaffoldKey.currentState.showSnackBar(snackBar);
          return;
        } else {
          var currentValue = map.keys.last.split("e")[1];
          var newValue = int.parse(currentValue) + 1;
          String newKey = "e" + newValue.toString();

          child.update({
            newKey: emailController.text
          });

          signUp(emailController.text, passController.text).then((String msg) {
            if (msg.isNotEmpty) {
              registerMessage = "Usuário cadastrado com sucesso";
              final snackBar = SnackBar(content: Text(registerMessage));
              scaffoldKey.currentState.showSnackBar(snackBar);

              _waitForUserToRead().then((value) {
                Navigator.push(context, FadeRoute(
                    page: Login()
                ));
              });

              return;
            }
          });
        }
      });
    }
    else if (selectedFunction == "Pr. de Região") {
      if (selectedRegion == "Selecione uma Região") {
        registerMessage = selectedRegion + "!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      } else {
        var child;
        selectedRegion == "Cinza" ? child =
            FirebaseDatabase.instance.reference().child("regs")
                .child("0")
                .child("u") :
        selectedRegion == "Laranja" ? child =
            FirebaseDatabase.instance.reference().child("regs")
                .child("1")
                .child("u") :
        child = FirebaseDatabase.instance.reference().child("regs")
            .child("2")
            .child("u");

        child.once().then((DataSnapshot ds) {
          Map<String, dynamic> map;
          try {
            map = new Map<String, dynamic>.from(ds.value);
          } catch (e) {
            child.set({
              'e0': emailController.text
            });

            signUp(emailController.text, passController.text).then((
                String msg) {
              if (msg.isNotEmpty) {
                registerMessage = "Usuário cadastrado com sucesso";
                final snackBar = SnackBar(content: Text(registerMessage));
                scaffoldKey.currentState.showSnackBar(snackBar);

                _waitForUserToRead().then((value) {
                  Navigator.push(context, FadeRoute(
                      page: Login()
                  ));
                });

                return;
              }
            });
            return;
          }

          var currentValue = map.keys.last.split("e")[1];
          var newValue = int.parse(currentValue) + 1;
          String newKey = "e" + newValue.toString();

          child.update({
            newKey: emailController.text
          });

          signUp(emailController.text, passController.text).then((String msg) {
            if (msg.isNotEmpty) {
              registerMessage = "Usuário cadastrado com sucesso";
              final snackBar = SnackBar(content: Text(registerMessage));
              scaffoldKey.currentState.showSnackBar(snackBar);

              _waitForUserToRead().then((value) {
                Navigator.push(context, FadeRoute(
                    page: Login()
                ));
              });

              return;
            }
          });
        });
      }
    }
    else if (selectedFunction == "Líder de Setor") {
      if (selectedRegion == "Selecione uma Região") {
        registerMessage = selectedRegion + "!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (nameController.text.isEmpty || nameController.text.length < 4) {
        registerMessage = "Nome do setor inválido";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      } else {
        var child;
        selectedRegion == "Cinza" ? child =
            FirebaseDatabase.instance.reference().child("regs")
                .child("0")
                .child("sets") :
        selectedRegion == "Laranja" ? child =
            FirebaseDatabase.instance.reference().child("regs")
                .child("1")
                .child("sets") :
        child = FirebaseDatabase.instance.reference().child("regs")
            .child("2")
            .child("sets");

        child.once().then((DataSnapshot ds) {
          List<dynamic> list;

          list = new List<dynamic>.from(ds.value);
          int size = 0;

          for (dynamic o in list) {
            size++;
          }

          if (size == 0) {
            child.child('0').update({
              'n': nameController.text
            });
            child.child('0').child('u').update({
              'e0': emailController.text
            });
          } else {
            child.child(size.toString()).update({
              'n': nameController.text
            });
            child.child(size.toString()).child('u').update({
              'e0': emailController.text
            });
          }

          signUp(emailController.text, passController.text).then((String msg) {
            if (msg.isNotEmpty) {
              registerMessage = "Usuário cadastrado com sucesso";
              final snackBar = SnackBar(content: Text(registerMessage));
              scaffoldKey.currentState.showSnackBar(snackBar);

              _waitForUserToRead().then((value) {
                Navigator.push(context, FadeRoute(
                    page: Login()
                ));
              });

              return;
            }
          });
        });
      }
    }
    else if (selectedFunction == "Supervisor") {
      if (selectedRegion == "Selecione uma Região") {
        registerMessage = selectedRegion + "!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (selectedSector == "Selecione um Setor") {
        registerMessage = selectedSector + "!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (nameController.text.isEmpty || nameController.text.length < 4) {
        registerMessage = "Nome da supervisão inválida";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }

      var child;
      selectedRegion == "Cinza" ?
      child = FirebaseDatabase.instance.reference().child("regs")
          .child("0").child("sets").orderByChild("n")
          .equalTo(selectedSector)
          .reference() :

      selectedRegion == "Laranja" ?
      child = FirebaseDatabase.instance.reference().child("regs")
          .child("1").child("sets").orderByChild("n")
          .equalTo(selectedSector)
          .reference() :

      child =
          FirebaseDatabase.instance.reference().child("regs").child("2").child(
              "sets")
              .orderByChild("n").equalTo(selectedSector).reference();

      child.once().then((DataSnapshot ds) {
        List<dynamic> list;
        list = new List<dynamic>.from(ds.value);

        int count = -1;
        int counter = 0;
        for (dynamic obj in list) {
          count++;
          if (obj['n'] == selectedSector) {
            try {
              var a = obj['sups'][0];

              for (dynamic sup in obj['sups']) {
                counter++;
              }
              child.child(count.toString()).child('sups').child(
                  counter.toString()).update({
                'n': nameController.text
              });
              child.child(count.toString()).child('sups').child(
                  counter.toString()).child('u').update({
                'e0': emailController.text
              });
            } catch (e) {
              child.child(count.toString()).child('sups').child(
                  counter.toString()).update({
                'n': nameController.text
              });
              child.child(count.toString()).child('sups').child(
                  counter.toString()).child('u').update({
                'e0': emailController.text
              });
            }
            break;
          }
        }

        signUp(emailController.text, passController.text).then((String msg) {
          if (msg.isNotEmpty) {
            registerMessage = "Usuário cadastrado com sucesso";
            final snackBar = SnackBar(content: Text(registerMessage));
            scaffoldKey.currentState.showSnackBar(snackBar);

            _waitForUserToRead().then((value) {
              Navigator.push(context, FadeRoute(
                  page: Login()
              ));
            });

            return;
          }
        });
      });
    }
    else if (selectedFunction == "Líder de IC") {
      if (selectedRegion == "Selecione uma Região") {
        registerMessage = selectedRegion + "!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (selectedSector == "Selecione um Setor") {
        registerMessage = selectedSector + "!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (selectedSupervision == "Selecione uma Supervisão") {
        registerMessage = selectedSupervision + "!";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }
      if (nameController.text.isEmpty || nameController.text.length < 4) {
        registerMessage = "Nome da IC inválido";
        final snackBar = SnackBar(content: Text(registerMessage));
        scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      }

      var child;
      selectedRegion == "Cinza" ?
      child = FirebaseDatabase.instance.reference().child("regs")
          .child("0").child("sets").orderByChild("n").equalTo(selectedSector)
          .reference()
          .orderByChild("n").equalTo(selectedSupervision)
          .reference() :

      selectedRegion == "Laranja" ?
      child = FirebaseDatabase.instance.reference().child("regs")
          .child("1").child("sets").orderByChild("n").equalTo(selectedSector)
          .reference()
          .orderByChild("n").equalTo(selectedSupervision)
          .reference() :

      child =
          FirebaseDatabase.instance.reference().child("regs").child("2").child(
              "sets")
              .orderByChild("n").equalTo(selectedSector).reference()
              .orderByChild("n").equalTo(selectedSupervision).reference();

      child.once().then((DataSnapshot ds) {
        List<dynamic> sets;
        sets = new List<dynamic>.from(ds.value);

        int setsCount = -1;
        int supsCount = -1;
        int countIcs = 0;

        for (dynamic set in sets) {
          setsCount++;

          if (set['n'] == selectedSector) {
            for (dynamic sup in set['sups']) {
              supsCount++;

              if (sup['n'] == selectedSupervision) {
                try {
                  var a = sup['ics'][0];

                  for (dynamic ic in sup['ics']) {
                    countIcs++;
                  }

                  child.child(setsCount.toString()).child('sups').child(
                      supsCount.toString()).child('ics').child(
                      countIcs.toString()).update({
                    'n': nameController.text
                  });

                  child.child(setsCount.toString()).child('sups').child(
                      supsCount.toString()).child('ics').child(
                      countIcs.toString()).update({
                    's': 0
                  });

                  child.child(setsCount.toString()).child('sups').child(
                      supsCount.toString()).child('ics').child(
                      countIcs.toString()).child('u').update({
                    'e0': emailController.text
                  });
                } catch (e) {
                  child.child(setsCount.toString()).child('sups').child(
                      supsCount.toString()).child('ics').child('0').update({
                    'n': nameController.text
                  });

                  child.child(setsCount.toString()).child('sups').child(
                      supsCount.toString()).child('ics').child('0').update({
                    's': 0
                  });

                  child.child(setsCount.toString()).child('sups').child(
                      supsCount.toString()).child('ics').child('0')
                      .child('u')
                      .update({
                    'e0': emailController.text
                  });
                }

                break;
              }
            }
          }
        }

        signUp(emailController.text, passController.text).then((String msg) {
          if (msg.isNotEmpty) {
            registerMessage = "Usuário cadastrado com sucesso";
            final snackBar = SnackBar(content: Text(registerMessage));
            scaffoldKey.currentState.showSnackBar(snackBar);

            _waitForUserToRead().then((value) {
              Navigator.push(context, FadeRoute(
                  page: Login()
              ));
            });
            return;
          }
        });
      });
    }
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

  Widget _getRegioesDropDown(){
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
            selectedSector = "Selecione um Setor";
            selectedSupervision = "Selecione uma Supervisão";
            _updateSetoresList();
          });
        },
      ),
    );
  }

  Widget _getSetoresDropDown(){
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
            _updateSupervisionList();
          });
        },
      ),
    );
  }

  Widget _getSupervisoesDropDown(){
    return Container (
      padding: EdgeInsets.fromLTRB(70, 0, 30, 20),
      child: DropdownButton<String>(
        hint: Text(
          selectedSupervision,
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
            selectedSupervision = value;
          });
        },
      ),
    );
  }

  Widget _getSetorContainer(String hint) {
    return Container (
        child: Column(
          children: <Widget>[
            _getRegioesDropDown(),
            _getFieldWithHint(hint)
          ],
        )
    );
  }

  Widget _getSupervisaoContainer(String hint) {
    return Container (
        child: Column(
          children: <Widget>[
            _getRegioesDropDown(),
            _getSetoresDropDown(),
            _getFieldWithHint(hint)
          ],
        )
    );
  }

  Widget _getICContainer(String hint) {
    return Container (
        child: Column(
          children: <Widget>[
            _getRegioesDropDown(),
            _getSetoresDropDown(),
            _getSupervisoesDropDown(),
            _getFieldWithHint(hint)
          ],
        )
    );
  }

  void _updateRegioesList() {
    var regs;
    regs = FirebaseDatabase.instance.reference().child("regs");
    regs.once().then((DataSnapshot ds){

      List<dynamic> list = new List<dynamic>.from(ds.value);
      regioes = new List<String>();
      for(dynamic regiao in list){
        regioes.add(regiao['cor']);
      }
    });
  }

  void _updateSetoresList() {
    var regs;
    regs = FirebaseDatabase.instance.reference().child("regs").orderByChild("cor").equalTo(selectedRegion);
    regs.once().then((DataSnapshot ds){

      List<dynamic> list;
      Map<dynamic,dynamic> map;

      setState(() {
        setores = new List<String>();
      });
      FocusScope.of(context).requestFocus(new FocusNode());

      try {
        list = new List<dynamic>.from(ds.value);

        try {
          for(dynamic setor in list.elementAt(0)['sets']){
            setores.add(setor['n']);
          }
        } catch(e){

          try {
            for(dynamic setor in list.elementAt(1)['sets']){
              setores.add(setor['n']);
            }
          } catch(e){
            selectedSector = "Selecione um Setor";
          }
        }

      } catch(e){
        map = new Map<dynamic,dynamic>.from((ds.value));
        for(dynamic setor in map['2']['sets']){
          setores.add(setor['n']);
        }
      }
    });
  }

  void _updateSupervisionList() {
    var regs;
    regs = FirebaseDatabase.instance.reference().child("regs").orderByChild("cor").equalTo(selectedRegion);
    regs.once().then((DataSnapshot ds){

      List<dynamic> list;
      Map<dynamic,dynamic> map;

      setState(() {
        supervisoes = new List<String>();
      });
      FocusScope.of(context).requestFocus(new FocusNode());

      try {
        list = new List<dynamic>.from(ds.value);

        try {
          for(dynamic setor in list.elementAt(0)['sets']){
            if(setor['n'] == selectedSector){

              for(dynamic sups in setor['sups']){
                supervisoes.add(sups['n']);
              }
              return;
            }
          }
        } catch(e){

          try {
            for(dynamic setor in list.elementAt(1)['sets']){
              if(setor['n'] == selectedSector){

                for(dynamic sups in setor['sups']){
                  supervisoes.add(sups['n']);
                }
                return;
              }
            }
          } catch(e){
            selectedSupervision = "Selecione um Setor";
          }
        }

      } catch(e){
        map = new Map<dynamic,dynamic>.from((ds.value));

        for(dynamic setor in map['2']['sets']){

          if(setor['n'] == selectedSector){

            for(dynamic sups in setor['sups']){
              supervisoes.add(sups['n']);
            }
            return;
          }
        }
      }
    });
  }
}