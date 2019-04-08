import 'dart:math';

const int canvasWidth = 500;
const int canvasHeight = 800;
double playerHeight = 120;
double playerWidth = 70;

const double da = 0.3;
const double db = 0.3;
const double dc = 0.9;
const double dd = 1.1;

const double la = 2.0;
const double lb = 8.0;
const double lc = 15.0;
const double ld = 40.0;
const double gk = (dc - db) / (lc - lb);

String getRandomImage() {
  List<String> src = [
    './assets/red.png',
    './assets/blue.png',
    './assets/green.png',
    './assets/yellow.png',
    './assets/purple.png',
    './assets/magenta.png',
    './assets/orange.png',
    './assets/red.png',
    './assets/blue.png',
    './assets/green.png',
    './assets/yellow.png',
    './assets/purple.png',
    './assets/magenta.png',
    './assets/orange.png',
    './assets/red.png',
    './assets/blue.png',
    './assets/green.png',
    './assets/yellow.png',
    './assets/purple.png',
    './assets/magenta.png',
    './assets/orange.png',
    './assets/red.png',
    './assets/blue.png',
    './assets/green.png',
    './assets/yellow.png',
    './assets/purple.png',
    './assets/magenta.png',
    './assets/orange.png',
    './assets/hole.png',
  ];

  int idx = Random().nextInt(src.length);

  return src[idx];
}

int randomMinMax(int min, int max) => min + Random().nextInt(max - min);
