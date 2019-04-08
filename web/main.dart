import 'dart:html';
import 'dart:async';

import 'game.dart';

void main() {
  final CanvasElement canvas = querySelector('#canvas');

  canvas.focus();
  scheduleMicrotask(Game(canvas).run);
}
