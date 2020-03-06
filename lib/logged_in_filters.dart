import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maanaim_signal/fade_transictions.dart';
import 'package:maanaim_signal/maanaim_structure.dart';
import 'package:maanaim_signal/signal.dart';
import 'package:maanaim_signal/signal_filters.dart';

class LoggedInFilters extends StatelessWidget {
  LoggedInFilters({Key key, this.structure}) : super(key: key);
  final Object structure;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Filtros',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoggedInFiltersPage(title: 'Filtros', structure: structure),
    );
  }
}

class LoggedInFiltersPage extends StatefulWidget {
  LoggedInFiltersPage({Key key, this.title, this.structure}) : super(key: key);
  final String title;
  final Object structure;

  @override
  _LoggedInFiltersPageState createState() => _LoggedInFiltersPageState(structure: structure);
}

class _LoggedInFiltersPageState extends State<LoggedInFiltersPage> {
  _LoggedInFiltersPageState({Key key, this.structure});

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
  Object structure;
  int function = 3;
  int redICs = 0;
  int yellowICs = 0;
  int greenICs = 0;

  @override
  void initState() {
    regioes.add("Cinza");
    regioes.add("Vermelha");
    regioes.add("Laranja");

    if(structure is MaanaimStructure){
      function = 0;
    } else if (structure is Regiao){
      function = 1;
    } else if (structure is Setor){
      function = 2;
    } else if (structure is Supervisao) {
      function = 3;
    }

    _countICsPerStatus(structure);
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
                            Text(redICs.toString(),
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
                            Text(yellowICs.toString(),
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
                            Text(greenICs.toString(),
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
              _getDrops(function)
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

  void _countICsPerStatus(Object o) {

    MaanaimStructure ms;
    Regiao r;
    Setor s;
    Supervisao sup;

    if(o is Supervisao){
      sup = o;
      if(sup.ics != null){
        for(IC i in sup.ics){
          if(i.s == 0){
            redICs++;
          } else if (i.s == 1){
            yellowICs++;
          } else if (i.s == 2) {
            greenICs++;
          }
        }
      }

    } else if (o is Setor) {
      s = o;
      if(s.sups != null){
        for(Supervisao sup in s.sups){
          if(sup.ics != null){
            for(IC i in sup.ics){
              if(i.s == 0){
                redICs++;
              } else if (i.s == 1){
                yellowICs++;
              } else if (i.s == 2) {
                greenICs++;
              }
            }
          }
        }
      }

    } else if (o is Regiao) {
      r = o;
      if(r.sets != null){
        for(Setor s in r.sets){
          if(s.sups != null){
            for(Supervisao sup in s.sups){
              if(sup.ics != null){
                for(IC i in sup.ics){
                  if(i.s == 0){
                    redICs++;
                  } else if (i.s == 1){
                    yellowICs++;
                  } else if (i.s == 2) {
                    greenICs++;
                  }
                }
              }
            }
          }
        }
      }

    } else if (o is MaanaimStructure) {
      ms = o;
      for(Regiao r in ms.regs){
        if(r.sets != null){
          for(Setor s in r.sets){
            if(s.sups != null){
              for(Supervisao sup in s.sups){
                if(sup.ics != null){
                  for(IC i in sup.ics){
                    if(i.s == 0){
                      redICs++;
                    } else if (i.s == 1){
                      yellowICs++;
                    } else if (i.s == 2) {
                      greenICs++;
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

}
