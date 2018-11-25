import 'const.dart';

class Level {
  int startTime = DateTime.now().millisecondsSinceEpoch;

  int _minSpawn = 400;
  int _maxSpawn = 800;

  double _playerVelocity = 200.0;
  double _pieceVelocity = 350.0;

  double _difficulty = da;
  double _level = lc;

  int getMinSpawn() => _minSpawn;
  int getMaxSpawn() => _maxSpawn;

  double getPlayerVelocity() => _playerVelocity;
  double getPieceVelocity() => _pieceVelocity;

  double getDifficulty() => _difficulty;

  void updateSpawn() {
    if (_minSpawn > 100) _minSpawn -= _difficulty ~/ 1;
    if (_maxSpawn > _difficulty + _minSpawn)_maxSpawn -= _difficulty ~/ 1;
  }

  void updatePieceVelociy() {
    if (_pieceVelocity < 1000) _pieceVelocity += _difficulty ;
  }

  void updateLevel() => _level += 0.1;

  void updateDifficulty() {
    if (_level < lb) {
      // Intro Phase
      _difficulty = da + (db - da) * (_level - la);
    }
    else if(_level < lc) {
      // Learning Phase
      _difficulty = db + (dc - db) * (_level - lb);
    } else if(_level < ld) {
      // Progress Phase
      _difficulty = dc + (dd - dc) * (_level - lc);
    }
  }
}
