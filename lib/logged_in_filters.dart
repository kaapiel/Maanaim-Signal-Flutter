import 'package:flutter/material.dart';
import 'package:maanaim_signal/fade_transictions.dart';
import 'package:maanaim_signal/signal.dart';
import 'package:maanaim_signal/signal_filters.dart';
import 'package:timeline_list/timeline.dart';
import 'package:maanaim_signal/timeline_data.dart';
import 'package:timeline_list/timeline_model.dart';

class LoggedInFilters extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Filtros',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoggedInFiltersPage(title: 'Filtros'),
    );
  }
}

class LoggedInFiltersPage extends StatefulWidget {
  LoggedInFiltersPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoggedInFiltersPageState createState() => _LoggedInFiltersPageState();
}

class _LoggedInFiltersPageState extends State<LoggedInFiltersPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String selectedRegion = "Selecione uma Região";
  String selectedSector = "Selecione um Setor";
  String selectedSupervision = "Selecione uma Supervisão";
  String selectedIC = "Selecione uma IC";
  List<String> setores = new List<String>();
  List<String> regioes = new List<String>();
  List<String> supervisoes = new List<String>();
  List<String> ics = new List<String>();

  @override
  void initState() {
    regioes.add("Cinza");
    regioes.add("Vermelha");
    regioes.add("Laranja");
    setores.add("joyce e flavio");
    setores.add("set2");
    setores.add("set3");
    supervisoes.add("sup1");
    supervisoes.add("sup2");
    supervisoes.add("sup3");
    ics.add("IC1");
    ics.add("IC2");
    ics.add("IC3");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 0, 20),
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text("66",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.assistant_photo,
                              size: 50,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, FadeRoute(
                            page: SignalFilters(status: 0)
                        ));
                      },
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    InkWell(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text("28",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.info,
                              size: 50,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, FadeRoute(
                            page: SignalFilters(status: 1)
                        ));
                      },
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    InkWell(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text("12",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 50,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, FadeRoute(
                            page: SignalFilters(status: 2)
                        ));
                      },
                    )
                  ],
                ),
              ),
              _getDrops(0)
            ],
          ),
        )
    );
  }


  Widget _getDrops(int function){

    switch (function) {
      case 0:
        return Column(
          children: <Widget>[
            _RegionDrops(),
            _SectorDrops(),
            _SupervisionDrops(),
            _ICDrops()
          ],
        );
        break;
      case 1:
        return Column(
          children: <Widget>[
            _SectorDrops(),
            _SupervisionDrops(),
            _ICDrops()
          ],
        );
        break;
      case 2:
        return Column(
          children: <Widget>[
            _SupervisionDrops(),
            _ICDrops()
          ],
        );
        break;
      case 3:
        return Column(
          children: <Widget>[
            _ICDrops()
          ],
        );
        break;
    }
  }

  Widget _ICDrops(){
    return Container (
      padding: EdgeInsets.fromLTRB(70, 0, 30, 20),
      child: DropdownButton<String>(
        hint: Text(
          selectedIC,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
        items: ics.map((String value) {
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
            selectedIC = value;
            Navigator.push(context, FadeRoute(
                page: Signal()
            ));
          });
        },
      ),
    );
  }

  Widget _SupervisionDrops(){
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

  Widget _SectorDrops(){
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

  Widget _RegionDrops(){
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

}
