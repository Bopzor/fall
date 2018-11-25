import 'dart:math';

import 'const.dart';

class Piece {
  double _velocity;

  final double _x = Random().nextDouble() * canvasWidth;
  double _y = 0;

  final int _width = Random().nextInt(50) + 20;
  final int _height = Random().nextInt(80) + 20;
  final String _color = getRandomColor();

  bool display = true;

  Piece(this._velocity);

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
  String getColor() => _color;

  void render(ctx) {
    ctx..beginPath()
      ..fillStyle = _color
      ..rect(_x, (_y - _height), _width, _height)
      ..fill();
  }

}
