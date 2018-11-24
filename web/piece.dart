import 'dart:math';

import 'const.dart';

class Piece {
  static double _velocity = 350.0;

  final double _x = Random().nextDouble() * canvasWidth;
  double _y = 0;

  final int _width = Random().nextInt(50) + 20;
  final int _height = Random().nextInt(80) + 20;

  bool display = true;

  void update(final double elapsed) {
    _y += _velocity * elapsed;

    if (_y > canvasHeight + _height) {
      display = false;
    }
  }

  double getX() => _x;
  double getY() => _y;
  int getHeight() => _height;
  int getWidth() => _width;

  void render(ctx) {
    ctx..beginPath()
      ..fillStyle = 'cyan'
      ..rect(_x, (_y - _height), _width, _height)
      ..fill();
  }

}
