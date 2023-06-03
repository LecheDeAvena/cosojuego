import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:incremental_game/services/account.dart';
import 'package:incremental_game/services/managerBBDD.dart';

import '../tools/counter_bloc.dart';
import '../tools/stats_bloc.dart';
import '../tools/text_bloc.dart';

final _bloc = CounterBloc();
final _text = TextBloc();
final _statsBloc = StatsBloc();
int cont = 0;

class GameWidget extends StatefulWidget {
  GameWidget({required this.userInfo}) : super();
  Map<String, dynamic> userInfo;
  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Barco de ' + (widget.userInfo['name'])),
        backgroundColor: Color.fromARGB(255, 31, 15, 62),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "Config");
          },
          child: Text(
            "Options",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        leadingWidth: 65,
      ),
      body: Container(
        color: Color.fromARGB(255, 102, 63, 206),
        /*decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo2.png"),
            fit: BoxFit.fitHeight,
          ),
        ),*/
        child: Center(
          child: StreamBuilder(
            stream: _bloc.counter,
            initialData: cont,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 5),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Color.fromARGB(255, 63, 31, 158),
                    width: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Text(
                              '${snapshot.data} peces',
                              style: new TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        new SizedBox(
                            height: 150.0,
                            width: 150.0,
                            child: IconButton(
                                onPressed: () {
                                  _bloc.counterEventSink.add("IncrementEvent");
                                  _statsBloc.addClick();
                                },
                                splashRadius: 80,
                                splashColor: Colors.greenAccent,
                                color: Color.fromARGB(255, 13, 100, 144),
                                icon: Image.asset('assets/images/fishbtn.png',
                                    fit: BoxFit.contain))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.white,
                      child: ListView(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        //crossAxisSpacing: 10,
                        //mainAxisSpacing: 10,
                        shrinkWrap: true,
                        //crossAxisCount: 2,
                        physics: BouncingScrollPhysics(),
                        children: [
                          _UpgradeBox(
                              title: "Red",
                              index: 1,
                              price: _bloc.precios[0] +
                                  (10 + (5 * _bloc.upgrades[0])),
                              purchased: false,
                              img: 'assets/images/fishnet.png',
                              number: _bloc.upgrades[0]),
                          _UpgradeBox(
                              title: "Pescador",
                              index: 2,
                              price: _bloc.precios[1] +
                                  (50 + (25 * _bloc.upgrades[1])),
                              purchased: false,
                              img: 'assets/images/FishingBait.png',
                              number: _bloc.upgrades[1]),
                          _UpgradeBox(
                              title: "Barco",
                              index: 3,
                              price: _bloc.precios[2] +
                                  (500 + (250 * _bloc.upgrades[2])),
                              purchased: false,
                              img: 'assets/images/barco.png',
                              number: _bloc.upgrades[2]),
                          _UpgradeBox(
                              title: "Piscifactoria",
                              index: 4,
                              img: 'assets/images/fishfarm.png',
                              price: _bloc.precios[3] +
                                  (1000 + (500 * _bloc.upgrades[3])),
                              purchased: false,
                              number: _bloc.upgrades[3])
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    color: Color.fromARGB(255, 31, 15, 62),
                    child: GestureDetector(
                      onTap: () {
                        _text.cambiarTexto();
                      },
                      child: Container(
                          //color: Color.fromARGB(255, 158, 138, 165),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 158, 138, 165),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 158, 138, 165),
                                  spreadRadius: 3),
                              BoxShadow(color: Colors.white, spreadRadius: 1),
                            ],
                          ),
                          /*decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/fondo2.jpg"),
                              fit: BoxFit.fitWidth,
                            ),
                          ),*/
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: 60,
                          width: screenWidth * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _text.getTexto(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title}) : super();

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
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  void timerCerrar(BuildContext cont) {
    int tiempo = 2;
    var oneSec = Duration(seconds: 1);
    Timer timer = new Timer.periodic(
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
}*/

class _UpgradeBox extends StatefulWidget {
  _UpgradeBox(
      {required this.title,
      required this.price,
      required this.purchased,
      required this.number,
      required this.img,
      required this.index})
      : super();

  final String title;
  final int index;
  final int price;
  final bool purchased;
  final int number;
  final String img;

  final upgrades = [
    "Upgrade1Event",
    "Upgrade2Event",
    "Upgrade3Event",
    "Upgrade4Event"
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
        color: Color.fromARGB(255, 60, 5, 122),
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.green,
        child: InkWell(
          onTap: () =>
              _bloc.counterEventSink.add(widget.upgrades[widget.index - 1]),
          child: Container(
            height: 100,
            width: 150,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, //+ ' (' + (widget.number.toString()) + ')'
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(widget.img),
                          fit: BoxFit.fitWidth,
                          height: 80,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            style: new TextStyle(
                                fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.number.toString(),
                      style: new TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameIni extends StatefulWidget {
  GameIni({super.key});

  @override
  GameIniState createState() => GameIniState();
}

class GameIniState extends State<GameIni> {
  Widget _body = CircularProgressIndicator();
  Map<String, dynamic> uInfo = <String, dynamic>{'name': 'nobody'};
  @override
  void initState() {
    _gotoHomeScreen();
    _statsBloc.load();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  Widget _gotoHomeScreen() {
    DatabaseManager().getUserInfo(Account.getuserID()).then((cosa) {
      if (cosa['name'] == null) {
        setState(() => _body = CircularProgressIndicator());
      } else {
        Account.setData(
          cosa['name'],
          cosa['score'] as int,
          cosa['totalScore'] as int,
          cosa['recordScore'] as int,
          cosa['maxUpgrade1'] as int,
          cosa['maxUpgrade2'] as int,
          cosa['maxUpgrade3'] as int,
          cosa['maxUpgrade4'] as int,
          cosa['upgrade1'] as int,
          cosa['upgrade2'] as int,
          cosa['upgrade3'] as int,
          cosa['upgrade4'] as int,
          cosa['clicks'] as int,
          cosa['totalClicks'] as int,
          cosa['loops'] as int,
        );
        _statsBloc.compareData(cosa);
        setState(() => _body = GameWidget(
              userInfo: cosa,
            ));
      }
    });
    return CircularProgressIndicator();
  }
}
