import 'package:memoizer_annotation/memoizerClasses.dart';
import 'package:memoizer_generator/src/helpers.dart';
import 'package:memoizer_generator/src/types.dart';
import 'package:test/test.dart';

void main() {
  group("classDefinition", () {
    test("1 a", () {
      var result = classDefinition(
        classNameMemoed: "Memo_PlusParams0",
        returnType: "int",
        paramsAll: [],
      );

      expect(result, "class Memo_PlusParams0 extends Memo0<int> {");
    });

    test("2 a", () {
      var result = classDefinition(
        classNameMemoed: "Memo_Another",
        returnType: "String",
        paramsAll: [
          NameType("age", "int"),
          NameType("name", "String"),
          NameType("value", "double"),
        ],
      );

      expect(result, "class Memo_Another extends Memo3<String, int, String, double> {");
    });
  });

  group("superMemoizedFunction", () {
    test("1 b", () {
      var result = superMemoizedFunction(
        className: "getAgeFn",
        paramsPositional: [
          NameType("age", "int"),
        ],
        paramsNamed: [
          NameType("money", "double"),
        ],
      );

      expect(result, "memoizedFunction: (int age, double money) => getAgeFn().call(age, money: money),");
    });

    test("2 b", () {
      var result = superMemoizedFunction(
        className: "getAgeFn",
        paramsPositional: [
          NameType("age", "int"),
          NameType("cash", "double"),
        ],
        paramsNamed: [],
      );

      expect(result, "memoizedFunction: (int age, double cash) => getAgeFn().call(age, cash),");
    });

    test("3 b", () {
      var result = superMemoizedFunction(
        className: "getAgeFn",
        paramsPositional: [
          NameType("ids", "List<int>?"),
        ],
        paramsNamed: [],
      );

      expect(result, "memoizedFunction: (List<int>? ids) => getAgeFn().call(ids),");
    });

    test("4 b", () {
      var result = superMemoizedFunction(
        className: "getAgeFn",
        paramsPositional: [],
        paramsNamed: [],
      );

      expect(result, "memoizedFunction: () => getAgeFn().call(),");
    });
  });

  group("superMemoizeOnPX", () {
    test("1 c", () {
      var result = superMemoizeOnPX(
        paramsAll: [
          NameType("age", "int"),
        ],
      );

      expect(result, "memoizeOnP1: MemoizeOn.varyByParam");
    });

    test("2 c", () {
      var result = superMemoizeOnPX(
        paramsAll: [
          NameType("age", "int"),
          NameType("ids", "List<String?>?", memoizeOn: MemoizeOn.storeOnly),
        ],
      );

      expect(result, """memoizeOnP1: MemoizeOn.varyByParam,
memoizeOnP2: MemoizeOn.storeOnly""");
    });
  });

  group("functionConstructor", () {
    test("1 d", () {
      var result = fnConstructor(
        returnType: "int?",
        paramsPositional: [
          NameType("ages", "List<int>"),
        ],
        paramsNamed: [
          NameType("name", "String"),
        ],
      );

      expect(result, "int? call(List<int> ages, {required String name, }) {");
    });

    test("2 d", () {
      var result = fnConstructor(
        returnType: "int?",
        paramsPositional: [
          NameType("age", "int"),
        ],
        paramsNamed: [
          NameType("name", "String?"),
        ],
      );

      expect(result, "int? call(int age, {String? name, }) {");
    });

    test("3 d no named params", () {
      var result = fnConstructor(
        returnType: "int",
        paramsPositional: [
          NameType("age", "int"),
        ],
        paramsNamed: [],
      );

      expect(result, "int call(int age, ) {");
    });

    test("4 d no positional params", () {
      var result = fnConstructor(
        returnType: "int",
        paramsPositional: [],
        paramsNamed: [
          NameType("age", "int"),
        ],
      );

      expect(result, "int call({required int age, }) {");
    });
  });

  group("callBody", () {
    test("1 e", () {
      var result = callBody(
        paramsAll: [],
      );

      expect(result, "return super.callInternal();");
    });

    test("2 e", () {
      var result = callBody(
        paramsAll: [
          NameType("age", "int"),
          NameType("name", "String"),
          NameType("value", "double"),
        ],
      );

      expect(result, "return super.callInternal(age, name, value);");
    });
  });

  group("invalidateCacheByParamConstructor", () {
    test("1 f", () {
      var result = invalidateCacheByParamConstructor(
        paramsAll: [],
      );

      expect(result, "void invalidateCache() {");
    });

    test("2 f", () {
      var result = invalidateCacheByParamConstructor(
        paramsAll: [
          NameType("age", "int"),
          NameType("name", "String?"),
          NameType("value", "double"),
        ],
      );

      expect(result, "void invalidateCache({int? age, String? name, double? value}) {");
    });
  });

  group("invalidateCacheByParamCall", () {
    test("1 g", () {
      var result = invalidateCacheByParamCall(
        paramsAll: [],
      );

      expect(result, "super.invalidateCacheInternal();");
    });

    test("1 g", () {
      var result = invalidateCacheByParamCall(
        paramsAll: [
          NameType("age", "int"),
          NameType("name", "String?"),
          NameType("value", "double"),
        ],
      );

      expect(result, "super.invalidateCacheInternal(p1: age, p2: name, p3: value);");
    });
  });
}
