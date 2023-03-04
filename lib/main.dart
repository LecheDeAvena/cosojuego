import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'counter_bloc.dart';
import 'counter_event.dart';

final _bloc = CounterBloc();
int cont = 0;
Timer timer;
BuildContext placeholder = null;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego fluter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'FishFactory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cont = (prefs.getInt('counter') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    placeholder = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.counter,
          initialData: cont,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 30),
                    child: Text(
                      '${snapshot.data} peces',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                new SizedBox(
                    height: 150.0,
                    width: 150.0,
                    child: IconButton(
                        onPressed: () =>
                            _bloc.counterEventSink.add(IncrementEvent()),
                        splashRadius: 80,
                        splashColor: Colors.greenAccent,
                        color: Color.fromARGB(255, 13, 100, 144),
                        icon: Image.asset('assets/images/fishbtn.png',
                            fit: BoxFit.contain))),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
                  child: Wrap(
                    children: [
                      _UpgradeBox(
                        title: "Red",
                        index: 1,
                        price:
                            _bloc.precios[0] + (10 + (5 * _bloc.upgrades[0])),
                        purchased: false,
                      ),
                      _UpgradeBox(
                        title: "Pescador",
                        index: 2,
                        price:
                            _bloc.precios[1] + (50 + (25 * _bloc.upgrades[1])),
                        purchased: false,
                      ),
                      _UpgradeBox(
                        title: "Barco",
                        index: 3,
                        price: _bloc.precios[2] +
                            (500 + (250 * _bloc.upgrades[2])),
                        purchased: false,
                      ),
                      _UpgradeBox(
                        title: "Piscifactoria",
                        index: 4,
                        price: _bloc.precios[3] +
                            (1000 + (500 * _bloc.upgrades[3])),
                        purchased: false,
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  void timerCerrar(BuildContext cont) {
    int tiempo = 2;
    var oneSec = Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (timer) {
        if (tiempo == 0) {
          Navigator.of(cont).pop();
          timer.cancel();
        } else {
          tiempo--;
        }
      },
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    if (Random().nextInt(10) == 1) {
      timerCerrar(context);
      return new AlertDialog(
        content: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          splashColor: Colors.brown.withOpacity(0.5),
          child: Ink(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/goldenfish.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    } else {
      Navigator.of(context).pop();
      return new AlertDialog(
        title: const Text('Pez dorado'),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Click"),
          ],
        ),
        actions: <Widget>[
          new ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              timer.cancel();
            },
            child: Text('Close'),
          ),
        ],
      );
    }
  }
}

class _UpgradeBox extends StatefulWidget {
  _UpgradeBox({Key key, this.title, this.price, this.purchased, this.index})
      : super(key: key);

  final String title;
  final int index;
  final int price;
  bool purchased;

  var upgrades = [
    Upgrade1Event(),
    Upgrade2Event(),
    Upgrade3Event(),
    Upgrade4Event()
  ];

  @override
  _UpgradeBoxState createState() => _UpgradeBoxState();
}

class _UpgradeBoxState extends State<_UpgradeBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Material(
        color: Colors.blue,
        child: InkWell(
          onTap: () =>
              _bloc.counterEventSink.add(widget.upgrades[widget.index - 1]),
          child: Container(
            height: 150,
            width: 150,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: new TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.price.toString() + " peces",
                    style: new TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
