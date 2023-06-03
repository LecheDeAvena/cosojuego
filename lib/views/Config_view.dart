import 'dart:math';

import 'package:flutter/material.dart';

import '../tools/counter_bloc.dart';
import '../tools/stats_bloc.dart';

final _bloc = CounterBloc();
final _statsBloc = StatsBloc();

class Config_view extends StatelessWidget {
  const Config_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _statsBloc.load();
    var _stats = _statsBloc.getStats();
    bool _canLoop =
        ((_stats['score']! >= (pow((1 * _stats['loops']!) + 1, 3)) * 1000000) &&
                (_stats['score']! > 0))
            ? true
            : false;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      appBar: AppBar(
        title: const Text('Opciones'),
        backgroundColor: Color.fromARGB(255, 31, 15, 62),
        leading: TextButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, "Game"); //la vista del perfil de instagram
            },
            child: const Text(
              "Juego",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 102, 63, 206),
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              color: Color.fromARGB(200, 63, 31, 158),
              width: 500,
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Peces actuales: " + _stats['score'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Peces totales: " + _stats['totalScore'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Peces maximo: " + _stats['maxScore'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Total de mejoras: " + _stats['totalUpgrades'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Maximo de redes: " + _stats['maxUpgrade1'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Maximo de pescadores: " + _stats['maxUpgrade2'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Maximo de barcos: " + _stats['maxUpgrade3'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Maximo de Piscifactorias: " +
                        _stats['maxUpgrade4'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Clicks actuales: " + _stats['clicks'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Clicks totales: " + _stats['totalClicks'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Reinicios: " + _stats['loops'].toString(),
                    style: new TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 234, 170, 47)),
                  ),
                  onPressed: () => _bloc.saveData(),
                  child: Text(
                    'Guardar',
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Text('\t(Guardar los datos en firebase.)')
              ],
            )),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 234, 170, 47)),
                            ),
                            onPressed: _canLoop
                                ? () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialog(context, 1),
                                    )
                                : null,
                            child: Text(
                              'Reencarnar',
                              style: new TextStyle(
                                  color: _canLoop ? Colors.black : Colors.grey
                                  //color: Colors.black,
                                  ),
                            ),
                          ),
                          Text('\t(Reinicio con beneficio.)')
                        ],
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 234, 170, 47)),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialogWrite(context),
                              );
                            },
                            child: Text(
                              'Cambiar nombre',
                              style: new TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text('\t(Cambiar el nombre de usuario.)')
                        ],
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 234, 170, 47)),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context, 0),
                              );
                            },
                            child: Text(
                              'Borrar todo',
                              style: new TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text('\t(Eliminar todo el progreso.)')
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, int option) {
  var textOption = [
    'Al borrar todo eliminaras todo el progreso actual y el de todas tus vidas. Una vez hecho esto no podrás recuperar los datos.',
    'Si reinicias perderas todos tus peces actuales. Pero a cambio, conseguiras un aumento en la produccion de tu siguiente vida.'
  ];
  return new AlertDialog(
    title: const Text('¿Estas seguro?'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(textOption[option]),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          if (option == 0) {
            _bloc.trueDeleteAll();
          } else if (option == 1) {
            _bloc.deleteAll();
          }
          Navigator.of(context).pop();
        },
        child: const Text('Aceptar'),
      ),
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cerrar'),
      ),
    ],
  );
}

Widget _buildPopupDialogWrite(BuildContext context) {
  var name;
  return new AlertDialog(
    title: const Text('Inserte nuevo nombre'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          onChanged: (text) {
            if (name == null || text.length > 0) {
              name = text;
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe aquí',
          ),
        ),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          if (name == null || name == '' || name.length < 0) {
          } else {
            _bloc.updateUsername(name);
            Navigator.of(context).pop();
          }
        },
        child: const Text('Aceptar'),
      ),
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cerrar'),
      ),
    ],
  );
}
