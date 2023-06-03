import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class StatsBloc {
  int _currentClick = 0, _clicksTotal = 0;
  int _currentFish = 0, _totalFish = 0, _recordFish = 0;
  int _mejorasTotal = 0;
  var _maxMejoras = [0, 0, 0, 0];
  var upgrades = [0, 0, 0, 0];
  int _reinicios = 0, _tiempo = 0;
  StatsBloc() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _currentFish = (prefs.getInt('counter') ?? 0);
    _totalFish = (prefs.getInt('counterTotal') ?? 0);
    _recordFish = (prefs.getInt('counterMax') ?? 0);
    _maxMejoras[0] = (prefs.getInt('upgrade1Max') ?? 0);
    _maxMejoras[1] = (prefs.getInt('upgrade2Max') ?? 0);
    _maxMejoras[2] = (prefs.getInt('upgrade3Max') ?? 0);
    _maxMejoras[3] = (prefs.getInt('upgrade4Max') ?? 0);
    _currentClick = (prefs.getInt('clickCurrent') ?? 0);
    _clicksTotal = (prefs.getInt('clickTotal') ?? 0);
    _reinicios = (prefs.getInt('loops') ?? 0);
    _mejorasTotal = (prefs.getInt('upgrade1') ?? 0) +
        (prefs.getInt('upgrade2') ?? 0) +
        (prefs.getInt('upgrade3') ?? 0) +
        (prefs.getInt('upgrade4') ?? 0);
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counterTotal', _totalFish);
    if (_recordFish > (prefs.getInt('counter') ?? 0)) {
      prefs.setInt('counterMax', _recordFish);
    }
    if (_maxMejoras[0] < (prefs.getInt('upgrade1') ?? 0)) {
      prefs.setInt('upgrade1Max', _maxMejoras[0]);
    }
    if (_maxMejoras[1] < (prefs.getInt('upgrade2') ?? 0)) {
      prefs.setInt('upgrade2Max', _maxMejoras[1]);
    }
    if (_maxMejoras[2] < (prefs.getInt('upgrade3') ?? 0)) {
      prefs.setInt('upgrade3Max', _maxMejoras[2]);
    }
    if (_maxMejoras[3] < (prefs.getInt('upgrade4') ?? 0)) {
      prefs.setInt('upgrade4Max', _maxMejoras[3]);
    }
    prefs.setInt('clickCurrent', _currentClick);
    prefs.setInt('clickTotal', _clicksTotal);
    prefs.setInt('loops', _reinicios);
  }

  Future<void> totalCount() async {
    final prefs = await SharedPreferences.getInstance();
    _totalFish = _totalFish + (prefs.getInt('counter') ?? 0);
  }

  Future<void> addClick() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('clickCurrent', _currentClick + 1);
    prefs.setInt('clickTotal', _clicksTotal + 1);
  }

  Map<String, int> getStats() {
    List<int> stats = [
      _currentFish,
      _totalFish,
      _recordFish,
      _mejorasTotal,
      _maxMejoras[0],
      _maxMejoras[1],
      _maxMejoras[2],
      _maxMejoras[3],
      _currentClick,
      _clicksTotal,
      _reinicios
    ];
    return <String, int>{
      'score': stats[0],
      'totalScore': stats[1],
      'maxScore': stats[2],
      'totalUpgrades': stats[3],
      'maxUpgrade1': stats[4],
      'maxUpgrade2': stats[5],
      'maxUpgrade3': stats[6],
      'maxUpgrade4': stats[7],
      'clicks': stats[8],
      'totalClicks': stats[9],
      'loops': stats[10]
    };
  }

  compareData(Map<String, dynamic> dataInput) async {
    /*Map<String, int> dataLocal = {
      'score': _currentFish,
      'totalScore': _totalFish,
      'maxScore': _recordFish,
      'totalUpgrades': _mejorasTotal,
      'maxUpgrade1': _maxMejoras[0],
      'maxUpgrade2': _maxMejoras[1],
      'maxUpgrade3': _maxMejoras[2],
      'maxUpgrade4': _maxMejoras[3],
      'clicks': _currentClick,
      'totalClicks': _clicksTotal,
      'loops': _reinicios
    };*/

    final prefs = await SharedPreferences.getInstance();
    if (dataInput['score'] > prefs.get('counter')) {
      prefs.setInt('counter', dataInput['score']);
    }
    if (dataInput['upgrade1'] > prefs.get('upgrade1')) {
      prefs.setInt('upgrade1', dataInput['upgrade1']);
    }
    if (dataInput['upgrade2'] > prefs.get('upgrade2')) {
      prefs.setInt('upgrade2', dataInput['upgrade2']);
    }
    if (dataInput['upgrade3'] > prefs.get('upgrade3')) {
      prefs.setInt('upgrade3', dataInput['upgrade3']);
    }
    if (dataInput['upgrade4'] > prefs.get('upgrade4')) {
      prefs.setInt('upgrade4', dataInput['upgrade4']);
    }
    if (dataInput['totalScore'] > prefs.get('counterTotal')) {
      prefs.setInt('counterTotal', dataInput['totalScore']);
    }
    if (dataInput['recordScore'] > prefs.get('counterMax')) {
      prefs.setInt('counterMax', dataInput['recordScore']);
    }
    if (dataInput['clicks'] > prefs.get('clickCurrent')) {
      prefs.setInt('clickCurrent', dataInput['clicks']);
    }
    if (dataInput['totalClicks'] > prefs.get('clickTotal')) {
      prefs.setInt('clickTotal', dataInput['totalClicks']);
    }
    if (dataInput['maxUpgrade1'] > prefs.get('upgrade1Max')) {
      prefs.setInt('upgrade1Max', dataInput['maxUpgrade1']);
    }
    if (dataInput['maxUpgrade2'] > prefs.get('upgrade2Max')) {
      prefs.setInt('upgrade2Max', dataInput['maxUpgrade2']);
    }
    if (dataInput['maxUpgrade3'] > prefs.get('upgrade3Max')) {
      prefs.setInt('upgrade3Max', dataInput['maxUpgrade3']);
    }
    if (dataInput['maxUpgrade3'] > prefs.get('upgrade4Max')) {
      prefs.setInt('upgrade4Max', dataInput['maxUpgrade4']);
    }
    if (dataInput['loops'] > prefs.get('loops')) {
      prefs.setInt('loops', dataInput['loops']);
    }
  }
}
