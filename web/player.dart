import 'const.dart';

import 'piece.dart';

class Player {
  double _velocity;

  double _x = canvasWidth / 2;
  double _y = canvasHeight - playerSize;
  double _size = playerSize;

  Player(this._velocity);

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
      ..rect(_x, _y, _size, _size)
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

      _scaleSize(p.getColor());
    }

    return result;
  }

  void _scaleSize(color) {
    if (color == 'black') playerSize += 0.1;
    else playerSize -= 0.1;
  }

  void shrink(remove) => _size -= remove / 3;

  void grow(remove) {
    if (_size < playerSize) _size += 1;
  }

}
