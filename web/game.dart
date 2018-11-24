import 'dart:html';
import 'dart:math';

import 'const.dart';

import 'keyboard.dart';
import 'piece.dart';
import 'player.dart';

class Game {
  final CanvasElement _canvas;
  final Keyboard _keyboard = Keyboard();

  int _lastTimestamp = 0;
  Player _player = Player();
  List<Piece> _pieces = [];
  int _lastPieceCreationTime = null;
  bool _dead = false;
  int _min = 400;
  int _max = 800;

  Game(this._canvas);


  run() {
    window.requestAnimationFrame(_gameLoop);

    _addPiece();
  }

  void _addPiece() {
    _pieces.add(Piece());
    _lastPieceCreationTime = DateTime.now().millisecondsSinceEpoch;

    if (_min > 0) _min--;
    if(_max > _min + 5) _max -= 5;

  }

  void _updatePiece(Piece piece, double elapsed) {
    piece.update(elapsed);
  }

  void _gameLoop(final double) {
    _update(_getElapsed());

    _isDead();

    _render();

    window.requestAnimationFrame(_gameLoop);
  }

  double _getElapsed() {
    final int time = DateTime.now().millisecondsSinceEpoch;
    double elapsed = 0.0;

    if (_lastTimestamp != 0) elapsed = (time - _lastTimestamp) / 1000.0;

    _lastTimestamp = time;

    return elapsed;
  }

  void _isDead() {
    if (_player.getSize() <= 0) _dead = true;
  }

  int _randomSpan(int min, int max) => min + Random().nextInt(max - min);

  void _update(final double elapsed) {
    if (_keyboard.isPressed(KeyCode.LEFT)) _player.updateX(-elapsed);

    if (_keyboard.isPressed(KeyCode.RIGHT)) _player.updateX(elapsed);

    if (_keyboard.isPressed(KeyCode.UP)) _player.updateY(-elapsed);

    if (_keyboard.isPressed(KeyCode.DOWN)) _player.updateY(elapsed);

    if ((DateTime.now().millisecondsSinceEpoch - _lastPieceCreationTime) > _randomSpan(_min, _max)) {
      _addPiece();
      _player.grow();
    }

    _pieces.forEach((p) => _updatePiece(p, elapsed));
    _pieces.removeWhere((p) => !p.display);

    _pieces.forEach((p) {
      if (_player.isHit(p)) {
        _player.shrink();
      }
    });

  }

  void _render() {
    final CanvasRenderingContext2D ctx = _canvas.context2D;

    ctx..globalAlpha = 1
      ..fillStyle = 'gray'
      ..beginPath()
      ..rect(0, 0, canvasWidth, canvasHeight)
      ..fill();

    if (_dead) {
      _renderEnd(ctx);

    } else {
      _player.render(ctx);
      _pieces.forEach((p) => p.render(ctx));
    }

  }

  void _renderEnd(ctx) {
    ctx..font = '30px Monospace'
      ..fillStyle = 'red'
      ..textAlign = 'center'
      ..fillText('You lose.', canvasWidth / 2, canvasHeight / 2);
  }
}
