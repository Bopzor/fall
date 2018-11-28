import 'dart:html';

import 'piece.dart';

class Bullet {
  double _x;
  double _y;
  double _playerSize;

  double _width = 15;
  double _height = 35;
  double _velocity = 200.0;

  ImageElement _image = ImageElement(src: './assets/bullet.png');

  bool display = true;

  Bullet(this._x, this._y, this._playerSize) {
    _x += _playerSize / 2 - _width / 2;
    _y -=  _playerSize / 2;
  }

  void render(ctx) {
    ctx.drawImageScaled(_image, _x, _y, _width, _height);
  }

  void update(double elapsed) {
    _y -= _velocity * elapsed;

    if (_y < 0) display = true;
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

      display = false;
    }


    return result;
  }
}
