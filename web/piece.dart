import 'dart:html';

import 'const.dart';

class Piece {
  final ImageElement image = ImageElement();

  double _velocity;

  double _x;
  double _y = 0;

  int _life;
  double _opacity = 1;
  double _lifeOffset;

  final int _size = randomMinMax(40, 130);
  final String _src = getRandomImage();

  bool _display = true;

  Piece(this._velocity) {
    _x = randomMinMax(0, canvasWidth - _size) / 1;
    _y = -_size / 1;
    _life = (_size + _size) ~/ 40;
    image.src = _src;
    _lifeOffset = 1 / _life;
  }

  void update(final double elapsed) {
    _y += _velocity * elapsed;

    if (_y > canvasHeight + _size) _destroy();
  }

  void _destroy() => _display = false;

  double get x => _x;
  double get y => _y;
  int get height => _size;
  int get width => _size;
  String get color => _src;
  int get life => _life;
  bool get display => _display;

  void hit() {
    _opacity -= _lifeOffset;
    _life--;

    if (_life <= 0) _destroy();
  }

  void render(ctx) {
    ctx..globalAlpha = _opacity
      ..drawImageScaled(image, _x, _y, _size, _size);
  }
}
