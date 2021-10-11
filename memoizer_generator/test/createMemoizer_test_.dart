import 'package:generator_common/NameType.dart';
import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:memoizer_generator/src/createMemoizer.dart';
import 'package:test/test.dart';

void main() {
  group("createMemoizer", () {
    test("1", () {
      var className = "Fn";
      var returnType = "int?";
      var paramsPositional = [
        NameTypeClassCommentData<MemoizeOn>("age", "int", null),
      ];
      var paramsNamed = [
        NameTypeClassCommentData<MemoizeOn>("name", "String", null),
      ];

      var output = createMemoizer(
        className: className,
        returnType: returnType,
        paramsPositional: paramsPositional,
        paramsNamed: paramsNamed,
      );

      var expected = """class Memo_Fn extends Memo2<int?, int, String> {
Memo_Fn()
: super(
memoizedFunction: (int age, String name) => Fn().call(age, name: name),
memoizeOnP1: MemoizeOn.varyByParam,
memoizeOnP2: MemoizeOn.varyByParam
);

int? call(
int age, {
required String name,
}) {
return super.callInternal(age, name);
}

void invalidateCache({int? age, String? name}) {
super.invalidateCacheInternal(p1: age, p2: name);
}
}""";

      expect(fmt(output), fmt(expected));
    });
  });
}

String fmt(String str) {
  return str //
          .trim()
          .replaceAll("\n", " ")
          .replaceAll("  ", " ")
          .replaceAll("  ", " ")
          .replaceAll("( ", "(")
          .replaceAll("{ ", "{") //
      ;
}
