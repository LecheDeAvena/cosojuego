import 'dart:async';
import 'dart:math';

class TextBloc {
  late Timer _timer;
  var textos = [
    "Prueba a pulsar el botón.",
    "Comprar mejoras te permitirá conseguir peces de forma pasiva.",
    "Échale un vistazo a las opciones.",
    "Reencarnar mejorará el numero de peces que consigues!",
    "Consigue más peces.",
    "Compra el DLC por solo 9.99€.",
    "Pescar ahora te relaja.",
    "Recuerda guardar tu progreso antes de salir.",
    "No olvides beber agua.",
    "No te gusta tu nombre? Cambialo en las opciones!",
    "Si pulsas aqui cambiaras de consejo.",
    "Dale otra vez al boton!"
  ];
  var current;
  TextBloc() {
    current = textos[random()];
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 5);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        cambiarTexto();
      },
    );
  }

  void cambiarTexto() {
    current = textos[random()];
  }

  String getTexto() {
    return current;
  }

  int random() {
    var rng = Random();
    return rng.nextInt(textos.length);
  }

  void dispose() {
    _timer.cancel();
  }
}
