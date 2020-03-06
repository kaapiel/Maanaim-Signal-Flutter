import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:maanaim_signal/timeline_data.dart';
import 'package:timeline_list/timeline_model.dart';

import 'maanaim_structure.dart';

class Signal extends StatelessWidget {
  Signal({Key key, this.ic}) : super(key: key);
  final IC ic;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Semáforo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SignalPage(title: ic.n, ic: ic),
    );
  }
}

class SignalPage extends StatefulWidget {
  SignalPage({Key key, this.title, this.ic, this.function}) : super(key: key);
  final int function;
  final String title;
  final IC ic;

  @override
  _SignalPageState createState() => _SignalPageState(ic: ic);
}

class _SignalPageState extends State<SignalPage> {
  _SignalPageState({Key key, this.ic});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController =
  PageController(initialPage: 1, keepPage: true);
  int pageIx = 1;
  IC ic;

  @override
  void initState() {
    print(ic.n);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      timelineModel(TimelinePosition.Left),
      timelineModel(TimelinePosition.Center),
      timelineModel(TimelinePosition.Right)
    ];

    List<String> options;

    switch (widget.function) {
      case 4:
        options = [
          "Alterar status da IC",
          "Alterar nome da IC"
        ];
        break;
      default:
        options = [
          "Alterar status da IC",
          "Alterar nome da IC",
          "Alterar líder",
          "Remover IC"
        ];
    }

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            PopupMenuButton<String> (
              onSelected: _menuSelected(),
              itemBuilder: (BuildContext context) {
                return options.map((String option){
                  return PopupMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: PageView(
          onPageChanged: (i) => setState(() => pageIx = i),
          controller: pageController,
          children: pages,
        )
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: doodles.length,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodles[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        Card(
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(doodle.doodle),
                const SizedBox(
                  height: 20,
                ),
                Text(doodle.time, style: textTheme.caption),
                const SizedBox(
                  height: 0,
                ),
                Text(
                  doodle.name,
                  style: textTheme.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        ),
        position:
        i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }

  _menuSelected() {

  }
}
