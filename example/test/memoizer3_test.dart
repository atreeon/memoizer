import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

import 'memoizer3_test.memo.dart';

//NULLABLE PARAMETERS

var count = 0;

@memoizer
class Fn3 {
  int? call(List<int>? firstParam) {
    count++;

    if (firstParam == null) //
      return null;

    return firstParam.length;
  }
}

class MemoSing {
  var $fn1 = Memo_Fn3();

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

      var result1 = sut([1, 2, 3]);
      expect(count, 1);
      expect(result1, 3);

      var result2 = sut([1, 2, 3]);
      expect(count, 1);
      expect(result2, 3);

      var result3 = sut(null);
      expect(count, 2);
      expect(result3, null);

      var result4 = sut(null);
      expect(count, 2);
      expect(result4, null);
    });
  });
}
