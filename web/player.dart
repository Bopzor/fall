import 'dart:html';

import 'const.dart';

import 'piece.dart';

class Player {
  double _velocity;

  double _x = canvasWidth / 2;
  double _y;

  double _width = playerWidth;
  double _height;

  final ImageElement image = ImageElement(src: './assets/player.png');

  Player(this._velocity) {
    _height = _width / 0.55;
    _y = canvasHeight - _height;
  }

  double get x => _x;
  double get y => _y;
  double get width => _width;
  double get height => _height;

  void updateX(double elapsed) {
    _x += _velocity * elapsed;

    if (_x < 0) _x = 0;
    if (_x > canvasWidth - _width) _x = canvasWidth - _width;
  }

  void updateY(double elapsed) {
    _y += _velocity * elapsed;

    if (_y < 0) _y = 0;
    if (_y > canvasHeight - _height) _y = canvasHeight - _height;

  }

  void render(ctx) {
    ctx.drawImageScaled(image, _x, _y, _width, _height);
  }

  bool isHit(Piece p) {
    double px = p.x;
    double py = p.y;
    int height = p.height;
    int width = p.width;

    bool result = false;

    if (
      _x < px + width &&
      _x + _width  > px &&
      _y < py + height &&
      _y + _height > py
    ) {

      result = true;

      _scaleSize(p.color);
    }

    return result;
  }

  void _scaleSize(color) {
    if (color == 'black') playerWidth += 0.1;
    else playerWidth -= 0.1;

    playerHeight = playerWidth / 0.55;
  }

  void shrink(remove) {
    _width -= remove / 3;
    _height = _width / 0.55;
  }

  void grow(remove) {
    if (_width < playerWidth) {
      _width += 1;
      _height = _width / 0.55;
    }
  }

}
