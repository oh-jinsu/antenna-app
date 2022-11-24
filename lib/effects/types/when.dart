import 'package:antenna_app/effects/types/effect.dart';

Effect when<T>(void Function(T event) effect) {
  return (event) {
    if (event is T) {
      effect(event);
    }
  };
}
