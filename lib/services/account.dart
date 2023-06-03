import 'package:flutter/cupertino.dart';

class Account {
  static String _userID = '';
  static AccountData _userData = new AccountData(
      name: 'no',
      score: -1,
      totalScore: 0,
      maxScore: 0,
      upgrade1: 0,
      upgrade2: 0,
      upgrade3: 0,
      upgrade4: 0,
      maxUpgrade1: 0,
      maxUpgrade2: 0,
      maxUpgrade3: 0,
      maxUpgrade4: 0,
      clicks: 0,
      totalClicks: 0,
      loops: 0);

  static setuserID(String str) {
    _userID = str;
  }

  static getuserID() {
    return _userID;
  }

  static setData(
      String na,
      int num,
      int numt,
      int numm,
      int up1m,
      int up2m,
      int up3m,
      int up4m,
      int up1,
      int up2,
      int up3,
      int up4,
      int cl,
      int clt,
      int lop) {
    _userData = new AccountData(
        name: na,
        score: num,
        totalScore: numt,
        maxScore: numm,
        upgrade1: up1,
        upgrade2: up2,
        upgrade3: up3,
        upgrade4: up4,
        maxUpgrade1: up1m,
        maxUpgrade2: up2m,
        maxUpgrade3: up3m,
        maxUpgrade4: up4m,
        clicks: cl,
        totalClicks: clt,
        loops: lop);
  }

  static getData() {
    return _userData;
  }

  static getName() {
    return _userData.name;
  }

  static setName(String n) {
    _userData.name = n;
  }
}

class AccountData {
  String name = '';

  int score = -1,
      totalScore = -1,
      maxScore = -1,
      upgrade1 = 0,
      upgrade2 = 0,
      upgrade3 = 0,
      upgrade4 = 0,
      maxUpgrade1 = 0,
      maxUpgrade2 = 0,
      maxUpgrade3 = 0,
      maxUpgrade4 = 0,
      clicks = -1,
      totalClicks = -1,
      loops = 0;

  AccountData({
    required this.name,
    required this.score,
    required this.totalScore,
    required this.maxScore,
    required this.maxUpgrade1,
    required this.maxUpgrade2,
    required this.maxUpgrade3,
    required this.maxUpgrade4,
    required this.clicks,
    required this.totalClicks,
    required this.loops,
    required this.upgrade1,
    required this.upgrade2,
    required this.upgrade3,
    required this.upgrade4,
  });

  getTotalUpgrades() {
    return maxUpgrade1 + maxUpgrade2 + maxUpgrade3 + maxUpgrade4;
  }
}
