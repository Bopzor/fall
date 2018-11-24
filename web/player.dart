import 'dart:math';

import 'const.dart';

import 'piece.dart';

class Player {
  double _x = canvasWidth / 2;
  double _y = canvasHeight - 40.0;
  double _size = 20;
  double _velocity = 200.0;

  double getX() => _x;
  double getY() => _y;
  double getSize() => _size;

  void updateX(double elapsed) {
    _x += _velocity * elapsed;

    if (_x < 0) _x = 0;
    if (_x > canvasWidth - _size) _x = canvasWidth - _size;
  }

  void updateY(double elapsed) {
    _y += _velocity * elapsed;

    if (_y < 0) _y = 0;
    if (_y > canvasHeight - _size) _y = canvasHeight - _size;

  }

  void render(ctx) {
    ctx..beginPath()
      ..fillStyle = 'black'
      ..arc(_x, _y, _size, 0, pi * 2)
      ..fill();
  }

  bool isHit(Piece p) {
    double px = p.getX();
    double py = p.getY();
    int height = p.getHeight();
    int width = p.getWidth();

    bool result = false;

    if (
      _x < px + width
      && _x + _size  > px
      && _y < py + height
      && _y + _size > py) {

        result = true;

    }

    return result;
  }

  void shrink() => _size -= 1;

  void grow() {
    if (_size < playerSize) _size += 1;
  }

}
