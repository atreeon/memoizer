import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

//INVALIDATE CACHE BY PARAM

var count = 0;

class Memo_Fn extends Memo2<int?, int, String> {
  Memo_Fn()
      : super(
          memoizedFunction: (int age, String name) => Fn().call(age, name: name),
          memoizeOnP1: MemoizeOn.varyByParam,
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
}

class Fn {
  int? call(
    int age, {
    required String name,
  }) {
    count++;

    return age + name.length;
  }
}

class MemoSing {
  var $fn1 = Memo_Fn();

  //boilerplate
  static final MemoSing _singleton = MemoSing._internal();
  factory MemoSing() {
    return _singleton;
  }
  MemoSing._internal();
}

void main() {
  setUp(() {
    count = 0;
  });

  group("memo1", () {
    test("1a ", () {
      var sing = MemoSing();
      var sut = sing.$fn1;

      sut(2, name: "bob");
      sut(3, name: "bob");
      sut(3, name: "john");

      expect(sing.$fn1.previousResults.length, 3);
      sing.$fn1.invalidateCache(name: "bob");
      expect(sing.$fn1.previousResults.length, 1);
    });

    test("2a ", () {
      var sing = MemoSing();
      var sut = sing.$fn1;

      sut(2, name: "bob");
      sut(3, name: "bob");
      sut(3, name: "john");

      expect(sing.$fn1.previousResults.length, 3);
      sing.$fn1.invalidateCache(age: 2, name: "bob");
      expect(sing.$fn1.previousResults.length, 2);
    });

    test("3a ", () {
      var sing = MemoSing();
      var sut = sing.$fn1;

      sut(2, name: "bob");
      sut(3, name: "bob");
      sut(3, name: "john");

      expect(sing.$fn1.previousResults.length, 3);
      sing.$fn1.invalidateCache();
      expect(sing.$fn1.previousResults.length, 0);
    });
  });
}
