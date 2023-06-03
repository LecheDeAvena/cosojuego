import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:incremental_game/views/Config_view.dart';
import 'package:incremental_game/views/Login_view.dart';
import 'package:incremental_game/views/game_view.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "Login", //Vista en la que inicia el programa
        routes: {
          //Rutas para navegar entre vistas
          "Login": (BuildContext context) => Login_view(),
          "Game": (BuildContext context) => GameIni(),
          "Config": (BuildContext context) => Config_view(),
        });
  }
}
