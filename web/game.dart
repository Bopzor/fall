import 'dart:html';

import 'const.dart';

import 'keyboard.dart';
import 'planet.dart';
import 'player.dart';
import 'level.dart';
import 'bullet.dart';

class Game {
  final CanvasElement _canvas;
  final Keyboard _keyboard = Keyboard();

  final ImageElement _image = ImageElement(src: './assets/background.png');

  Level _level = Level();

  num _score = 0;

  Player _player;
  List<Planet> planet = [];
  List<Bullet> _bullets =[];

  int _lastTimestamp = 0;
  int _lastPieceCreationTime = 0;
  int _lastFireBullet = DateTime.now().millisecondsSinceEpoch;
  bool _dead = false;

  Game(this._canvas) {
    _player = Player(_level.playerVelocity);
  }

  run() {
    window.requestAnimationFrame(_gameLoop);

    _addPiece();
    _level.updateLevel();
  }

  void _addPiece() {
    planet.add(Planet(_level.planetVelocity));
    _lastPieceCreationTime = DateTime.now().millisecondsSinceEpoch;

    _level.updateSpawn();
    _level.updateLevel();
  }

  void _gameLoop(final double) {
    if (_dead == true) return;

    _score = _score + _level.difficulty * 10;

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
    if (_player.width <= 0) _dead = true;
  }

  void _update(final double elapsed) {
    if (_keyboard.isPressed(KeyCode.LEFT)) _player.updateX(-elapsed);

    if (_keyboard.isPressed(KeyCode.RIGHT)) _player.updateX(elapsed);

    if (_keyboard.isPressed(KeyCode.UP)) _player.updateY(-elapsed);

    if (_keyboard.isPressed(KeyCode.DOWN)) _player.updateY(elapsed);

    if (_keyboard.isPressed(KeyCode.SPACE)) _fire();

    if ((DateTime.now().millisecondsSinceEpoch - _lastPieceCreationTime) > randomMinMax(_level.minSpawn, _level.maxSpawn)) {
      _addPiece();
      _player.grow(_level.difficulty);
    }

    planet.forEach((p) {
      _bullets.forEach((b) {
        b.update(elapsed);

         if (b.isHit(p)) {
           p.hit();
          _score = _score - (2 * _level.difficulty) * 10;
          }
      });

      if (_player.isHit(p)) {
        _player.shrink(_level.difficulty);

        _score = _score - (2 * _level.difficulty) * 10;

        if (_score < 0) _score = 0;
      }

      p.update(elapsed);

    });

    planet.removeWhere((p) => !p.display);
    _bullets.removeWhere((b) => !b.display);
  }

  void _fire() {
    final int time = DateTime.now().millisecondsSinceEpoch;
    double elapsed = (time - _lastFireBullet) / 100;

    if (elapsed > 2) {
      _bullets.add(Bullet(_player.x, _player.y, _player.width));

      _lastFireBullet = time;
    }
  }

  void _render() {
    final CanvasRenderingContext2D ctx = _canvas.context2D;

    ctx..globalAlpha = 1
      ..drawImage(_image, 0, 0)
      ..font = '20px Monospace'
      ..fillStyle = 'white'
      ..fillText(_score.toString(), canvasWidth - 40, 15);

    if (!_dead) {
      _player.render(ctx);
      _bullets.forEach((b) => b.render(ctx));
      planet.forEach((p) => p.render(ctx));

    } else {
      _renderEnd(ctx);
    }

  }

  void _renderEnd(ctx) {
    ctx..font = '30px Monospace'
      ..fillStyle = 'red'
      ..textAlign = 'center'
      ..fillText('You lose.', canvasWidth / 2, canvasHeight / 2);
  }
}
