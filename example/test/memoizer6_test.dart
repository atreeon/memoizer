import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

part 'memoizer6_test.g.dart';

var count = 0;

@memoizer
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
    MemoSing().$fn1.invalidateCacheAllInternal();
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
