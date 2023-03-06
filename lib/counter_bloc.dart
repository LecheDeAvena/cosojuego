import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;
  var precios = [10, 100, 500, 1000];
  var upgrades = [0, 0, 0, 0];

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink; //Input - Sink
  Stream<int> get counter => _counterStateController.stream; //Output - Stream

  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);

    load();
    startUpgrade();
  }
  Future<void> _mapEventToState(CounterEvent event) async {
    final prefs = await SharedPreferences.getInstance();
    if (event is IncrementEvent) {
      incrementCounter();
    } else if (event is Upgrade1Event) {
      int precio1 = precios[0] + (10 + (5 * upgrades[0]));
      if (_counter >= (precio1)) {
        buyUpgrade(precio1);
        upgrades[0]++;
        prefs.setInt('upgrade1', upgrades[0]);
      } else {
        print("Necesitas " + (precio1 - _counter).toString());
      }
    } else if (event is Upgrade2Event) {
      int precio2 = precios[1] + (50 + (25 * upgrades[1]));
      if (_counter >= (precio2)) {
        buyUpgrade(precio2);
        upgrades[1]++;
        prefs.setInt('upgrade2', upgrades[1]);
      } else {
        print("Necesitas " + (precio2 - _counter).toString());
      }
    } else if (event is Upgrade3Event) {
      int precio3 = precios[2] + (500 + (250 * upgrades[2]));
      if (_counter >= (precio3)) {
        buyUpgrade(precio3);
        upgrades[2]++;
        prefs.setInt('upgrade3', upgrades[2]);
      } else {
        print("Necesitas " + (precio3 - _counter).toString());
      }
    } else if (event is Upgrade4Event) {
      int precio4 = precios[3] + (1000 + (500 * upgrades[3]));
      if (_counter >= (precio4)) {
        buyUpgrade(precio4);
        upgrades[3]++;
        prefs.setInt('upgrade4', upgrades[3]);
      } else {
        print("Necesitas " + (precio4 - _counter).toString());
      }
    }
    _inCounter.add(_counter);
  }

  void startUpgrade() {
    var oneSec = Duration(seconds: 1);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
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
  }

  Future<void> upgradesCounter() async {
    final prefs = await SharedPreferences.getInstance();

    _counter = (prefs.getInt('counter') ?? 0) +
        (1 * upgrades[0]) +
        (3 * upgrades[1]) +
        (8 * upgrades[2]) +
        (15 * upgrades[3]);
    prefs.setInt('counter', _counter);
  }

  Future<void> buyUpgrade(int price) async {
    final prefs = await SharedPreferences.getInstance();

    _counter = (prefs.getInt('counter') ?? 0) - price;
    prefs.setInt('counter', _counter);
  }
}
