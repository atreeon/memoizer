import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

import 'memoizer4_test.memo.dart';

//MEMO WITH TWO PARAMETERS

var count = 0;

@memoizer
class Fn4 {
  int? call(List<int> ages, String name) {
    count++;

    return ages.length + name.length;
  }
}

class MemoSing {
  var $fn1 = Memo_Fn4();

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
      var sut = MemoSing().$fn1;

      var result1 = sut([1, 2, 3], "bob");
      expect(count, 1);
      expect(result1, 6);

      var result2 = sut([1, 2, 3], "bob");
      expect(count, 1);
      expect(result2, 6);

      var result3 = sut([1], "bob");
      expect(count, 2);
      expect(result3, 4);
    });
  });
}
