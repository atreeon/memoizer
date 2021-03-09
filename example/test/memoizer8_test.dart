import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

part 'memoizer8_test.memoizer.dart';
//INVALIDATE CACHE BY PARAM

var count = 0;

@memoizer
class Fn {
  int? call(
    @noVaryBy int age, {
    required String name,
    double? cash,
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

      var result1 = sut(2, name: "bob");
      expect(result1, 5);

      var result2 = sut(10, name: "bob");
      expect(result2, 5);

      //The result should have been 3 but we cached it because
      //  the first parameter was ignored
      var result3 = Fn().call(10, name: "bob");
      expect(result3, 13);
    });
  });
}
