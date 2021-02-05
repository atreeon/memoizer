import 'package:memoizer_annotation/memoizerClasses.dart';

class NameType {
  final String type;
  final String name;
  final MemoizeOn memoizeOn;

  NameType(
    this.name,
    this.type, {
    this.memoizeOn = MemoizeOn.varyByParam,
  });

  toString() => "name:${this.name}|type:${this.type}|memoizeOn:${this.memoizeOn}";
}
