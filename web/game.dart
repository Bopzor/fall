import 'dart:html';

import 'const.dart';

import 'keyboard.dart';
import 'piece.dart';
import 'player.dart';
import 'level.dart';

class Game {
  final CanvasElement _canvas;
  final Keyboard _keyboard = Keyboard();

  Level _level = Level();

  Player _player;
  List<Piece> _pieces = [];

  int _lastTimestamp = 0;
  int _lastPieceCreationTime = null;
  bool _dead = false;

  Game(this._canvas) {
    _player = Player(_level.getPlayerVelocity());
  }

  run() {
    window.requestAnimationFrame(_gameLoop);

    _addPiece();
    _level.updateLevel();
  }

  void _addPiece() {
    _pieces.add(Piece(_level.getPieceVelocity()));
    _lastPieceCreationTime = DateTime.now().millisecondsSinceEpoch;

    _level.updateSpawn();
    _level.updateLevel();
  }

  void _updatePiece(Piece piece, double elapsed) {
    piece.update(elapsed);
  }

  void _gameLoop(final double) {
    if (_dead == true) return;

    _update(_getElapsed());

    _isDead();

    _render();

    _level.updateDifficulty();

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

  void _update(final double elapsed) {
    if (_keyboard.isPressed(KeyCode.LEFT)) _player.updateX(-elapsed);

    if (_keyboard.isPressed(KeyCode.RIGHT)) _player.updateX(elapsed);

    if (_keyboard.isPressed(KeyCode.UP)) _player.updateY(-elapsed);

    if (_keyboard.isPressed(KeyCode.DOWN)) _player.updateY(elapsed);

    if ((DateTime.now().millisecondsSinceEpoch - _lastPieceCreationTime) > randomMinMax(_level.getMinSpawn(), _level.getMaxSpawn())) {
      _addPiece();
      _player.grow(_level.getDifficulty());
    }

    _pieces.forEach((p) => _updatePiece(p, elapsed));
    _pieces.removeWhere((p) => !p.display);

    _pieces.forEach((p) {
      if (_player.isHit(p)) {
        _player.shrink(_level.getDifficulty());
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
