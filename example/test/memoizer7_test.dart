import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

part 'memoizer7_test.memoizer.dart';
//THREE PARAM FUNCTION

var count = 0;

@memoizer
class Fn {
  int? call(
    int age, {
    required String name,
    double? cash,
  }) {
    count++;

    if (cash == null) //
      return null;

    return age + name.length + cash.toInt();
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
    MemoSing().$fn1.invalidateCacheAllInternal();
  });

  group("memo1", () {
    test("1a ", () {
      var sing = MemoSing();
      var sut = sing.$fn1;

      sut(2, name: "bob");
      sut(3, name: "bob");
      sut(3, name: "john", cash: 4.7);

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

    test("4a ", () {
      var sut = MemoSing().$fn1;

      var result1 = sut(1, name: "bob");
      expect(count, 1);
      expect(result1, null);

      var result2 = sut(1, name: "bob", cash: 4.0);
      expect(count, 2);
      expect(result2, 8);

      var result3 = sut(2, name: "bob");
      expect(count, 3);
      expect(result3, null);

      var result4 = sut(2, name: "bob");
      expect(count, 3);
      expect(result4, null);
    });
  });
}
