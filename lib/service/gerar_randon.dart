import 'dart:math';

class GerarRandon {
  static int generateRandomNumber(int max) {
    Random numeroGerado = Random();
    return numeroGerado.nextInt(1000);
  }
}
