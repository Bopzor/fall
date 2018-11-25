import 'dart:math';

const int canvasWidth = 500;
const int canvasHeight = 800;
double playerSize = 40;

const double da = 0.3;
const double db = 0.3;
const double dc = 0.9;
const double dd = 1.1;

const double la = 2.0;
const double lb = 6.0;
const double lc = 12.0;
const double ld = 30.0;

String getRandomColor() {
  List<String> color = [
    'red',
    'cyan',
    'orange',
    'magenta',
    'green',
    'yellow',
    'whitesmoke',
    'red',
    'cyan',
    'orange',
    'magenta',
    'green',
    'yellow',
    'whitesmoke',
    'red',
    'cyan',
    'orange',
    'magenta',
    'green',
    'yellow',
    'whitesmoke',
    'red',
    'cyan',
    'orange',
    'magenta',
    'green',
    'yellow',
    'whitesmoke',
    'black',
  ];

  int idx = Random().nextInt(color.length);

  return color[idx];
}

int randomMinMax(int min, int max) => min + Random().nextInt(max - min);
