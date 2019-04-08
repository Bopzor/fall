import 'const.dart';

class Level {
  int startTime = DateTime.now().millisecondsSinceEpoch;

  int _minSpawn = 400;
  int _maxSpawn = 800;

  double _playerVelocity = 200.0;
  double _planetVelocity = 300.0;

  double _difficulty = 0;
  double _level = 0;

  int get minSpawn => _minSpawn;
  int get maxSpawn => _maxSpawn;

  double get playerVelocity => _playerVelocity;
  double get planetVelocity => _planetVelocity;

  double get difficulty => _difficulty;

  void updateSpawn() {
    if (_minSpawn > 100) _minSpawn -= _difficulty ~/ 1;
    if (_maxSpawn > _difficulty + _minSpawn)_maxSpawn -= _difficulty ~/ 1;
  }

  void updatePlanetVelociy() {
    if (_planetVelocity < 1000) _planetVelocity += _difficulty ;
  }

  void updateLevel(double score) => _level = score / 1000;

  void updateDifficulty() {
    if (_level < lb) {
      // Intro Phase
      _difficulty = da + (db - da) * (_level - la);

    } else if(_level < lc) {
      // Learning Phase
      _difficulty = db + (dc - db) * (_level - lb);

    } else if(_level < ld) {
      // Progress Phase
      _difficulty = dc + (dd - dc) * (_level - lc);

    } else {
      // Kill-off phase
      _difficulty = dd + gk * (_level - ld );
}
  }
}
