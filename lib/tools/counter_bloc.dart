import 'dart:async';
import 'dart:ffi';
import 'package:incremental_game/services/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import '../services/managerBBDD.dart';

class CounterBloc {
  int _counter = 0;
  var precios = [10, 100, 1000, 5000];
  var upgrades = [0, 0, 0, 0];
  late Timer _timer;

  final _counterStateController = BehaviorSubject<int>();
  Sink<int> get _inCounter => _counterStateController.sink; //Input - Sink
  Stream<int> get counter => _counterStateController.stream; //Output - Stream

  final _counterEventController = BehaviorSubject<String>();
  Sink<String> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);

    load();
    startUpgrade();
  }

  Future<void> _mapEventToState(String event) async {
    final prefs = await SharedPreferences.getInstance();
    if (event == "IncrementEvent") {
      incrementCounter();
    } else if (event == "Upgrade1Event") {
      int precio1 = precios[0] + (10 + (5 * upgrades[0]));
      if (_counter >= (precio1)) {
        buyUpgrade(precio1);
        upgrades[0]++;
        prefs.setInt('upgrade1', upgrades[0]);
        if ((prefs.getInt('upgrade1Max') ?? 0) < upgrades[0]) {
          prefs.setInt('upgrade1Max', upgrades[0]);
        }
      } else {
        print("Necesitas " + (precio1 - _counter).toString());
      }
    } else if (event == "Upgrade2Event") {
      int precio2 = precios[1] + (50 + (25 * upgrades[1]));
      if (_counter >= (precio2)) {
        buyUpgrade(precio2);
        upgrades[1]++;
        prefs.setInt('upgrade2', upgrades[1]);
        if ((prefs.getInt('upgrade2Max') ?? 0) < upgrades[1]) {
          prefs.setInt('upgrade2Max', upgrades[1]);
        }
      } else {
        print("Necesitas " + (precio2 - _counter).toString());
      }
    } else if (event == "Upgrade3Event") {
      int precio3 = precios[2] + (500 + (250 * upgrades[2]));
      if (_counter >= (precio3)) {
        buyUpgrade(precio3);
        upgrades[2]++;
        prefs.setInt('upgrade3', upgrades[2]);
        if ((prefs.getInt('upgrade3Max') ?? 0) < upgrades[2]) {
          prefs.setInt('upgrade3Max', upgrades[2]);
        }
      } else {
        print("Necesitas " + (precio3 - _counter).toString());
      }
    } else if (event == "Upgrade4Event") {
      int precio4 = precios[3] + (1000 + (500 * upgrades[3]));
      if (_counter >= (precio4)) {
        buyUpgrade(precio4);
        upgrades[3]++;
        prefs.setInt('upgrade4', upgrades[3]);
        if ((prefs.getInt('upgrade4Max') ?? 0) < upgrades[3]) {
          prefs.setInt('upgrade4Max', upgrades[3]);
        }
      } else {
        print("Necesitas " + (precio4 - _counter).toString());
      }
    }
    _inCounter.add(_counter);
  }

  void startUpgrade() {
    var oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (timer) {
        upgradesCounter();
        _inCounter.add(_counter);
      },
    );
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
    _timer.cancel();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = (prefs.getInt('counter') ?? 0);
    upgrades[0] = (prefs.getInt('upgrade1') ?? 0);
    upgrades[1] = (prefs.getInt('upgrade2') ?? 0);
    upgrades[2] = (prefs.getInt('upgrade3') ?? 0);
    upgrades[3] = (prefs.getInt('upgrade4') ?? 0);
  }

  Future<void> incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();

    _counter = (prefs.getInt('counter') ?? 0) + 1;
    prefs.setInt('counter', _counter);
    prefs.setInt('counterTotal', (prefs.getInt('counterTotal') ?? 0) + 1);
    prefs.setInt('clickCurrent', (prefs.getInt('clickCurrent') ?? 0) + 1);
    prefs.setInt('clickTotal', (prefs.getInt('clickTotal') ?? 0) + 1);

    if (_counter > (prefs.getInt('counterMax') ?? 0)) {
      prefs.setInt('counterMax', _counter);
    }
  }

  Future<void> upgradesCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int suma = ((1 * upgrades[0]) +
        (3 * upgrades[1]) +
        (8 * upgrades[2]) +
        (15 * upgrades[3]) +
        (5 * (prefs.getInt('loops') ?? 0)));

    _counter = (prefs.getInt('counter') ?? 0) + suma;
    prefs.setInt('counter', _counter);

    prefs.setInt('counterTotal', (prefs.getInt('counterTotal') ?? 0) + suma);

    if (_counter > (prefs.getInt('counterMax') ?? 0)) {
      prefs.setInt('counterMax', _counter);
    }
  }

  Future<void> buyUpgrade(int price) async {
    final prefs = await SharedPreferences.getInstance();

    _counter = (prefs.getInt('counter') ?? 0) - price;
    prefs.setInt('counter', _counter);
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    DatabaseManager().updateUserList(
        Account.getName(),
        prefs.getInt('counter') ?? 0,
        prefs.getInt('clickCurrent') ?? 0,
        prefs.getInt('loops') ?? 0,
        prefs.getInt('upgrade1Max') ?? 0,
        prefs.getInt('upgrade2Max') ?? 0,
        prefs.getInt('upgrade3Max') ?? 0,
        prefs.getInt('upgrade4Max') ?? 0,
        prefs.getInt('counterMax') ?? 0,
        prefs.getInt('clickTotal') ?? 0,
        prefs.getInt('counterTotal') ?? 0,
        prefs.getInt('upgrade1') ?? 0,
        prefs.getInt('upgrade2') ?? 0,
        prefs.getInt('upgrade3') ?? 0,
        prefs.getInt('upgrade4') ?? 0,
        Account.getuserID());
  }

  Future<void> updateUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();

    Account.setName(name);
    DatabaseManager().updateUserList(
        name,
        prefs.getInt('counter') ?? 0,
        prefs.getInt('clickCurrent') ?? 0,
        prefs.getInt('loops') ?? 0,
        prefs.getInt('upgrade1Max') ?? 0,
        prefs.getInt('upgrade2Max') ?? 0,
        prefs.getInt('upgrade3Max') ?? 0,
        prefs.getInt('upgrade4Max') ?? 0,
        prefs.getInt('counterMax') ?? 0,
        prefs.getInt('clickTotal') ?? 0,
        prefs.getInt('counterTotal') ?? 0,
        prefs.getInt('upgrade1') ?? 0,
        prefs.getInt('upgrade2') ?? 0,
        prefs.getInt('upgrade3') ?? 0,
        prefs.getInt('upgrade4') ?? 0,
        Account.getuserID());
  }

  Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', 0);
    prefs.setInt('upgrade1', 0);
    prefs.setInt('upgrade2', 0);
    prefs.setInt('upgrade3', 0);
    prefs.setInt('upgrade4', 0);
    prefs.setInt('clickCurrent', 0);
    prefs.setInt('loops', (prefs.getInt('loops') ?? 0) + 1);

    _counter = 0;
    upgrades[0] = 0;
    upgrades[1] = 0;
    upgrades[2] = 0;
    upgrades[3] = 0;

    DatabaseManager().updateUserList(
        Account.getName(),
        0,
        0,
        prefs.getInt('loops') ?? 0,
        prefs.getInt('upgrade1Max') ?? 0,
        prefs.getInt('upgrade2Max') ?? 0,
        prefs.getInt('upgrade3Max') ?? 0,
        prefs.getInt('upgrade4Max') ?? 0,
        prefs.getInt('counterMax') ?? 0,
        prefs.getInt('clickTotal') ?? 0,
        prefs.getInt('counterTotal') ?? 0,
        0,
        0,
        0,
        0,
        Account.getuserID());
  }

  Future<void> trueDeleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', 0);
    prefs.setInt('upgrade1', 0);
    prefs.setInt('upgrade2', 0);
    prefs.setInt('upgrade3', 0);
    prefs.setInt('upgrade4', 0);
    prefs.setInt('counterTotal', 0);
    prefs.setInt('counterMax', 0);
    prefs.setInt('clickCurrent', 0);
    prefs.setInt('clickTotal', 0);
    prefs.setInt('upgrade1Max', 0);
    prefs.setInt('upgrade2Max', 0);
    prefs.setInt('upgrade3Max', 0);
    prefs.setInt('upgrade4Max', 0);
    prefs.setInt('loops', 0);

    _counter = 0;
    upgrades[0] = 0;
    upgrades[1] = 0;
    upgrades[2] = 0;
    upgrades[3] = 0;

    DatabaseManager().updateUserList(Account.getName(), 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, Account.getuserID());
  }
}
