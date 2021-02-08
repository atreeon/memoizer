import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

part 'memoizer1_test.g.dart';

//NOT VARYBYPARAM

var count = 0;

@memoizer
class PlusParams1 {
  int call(
    @noVaryBy List<int> firstParam,
  ) {
    count++;
    return firstParam.length;
  }
}

class MemoSing {
  var $plusParams1 = Memo_PlusParams1();

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
    MemoSing().$plusParams1.invalidateCacheAllInternal();
  });

  group("memo1", () {
    test("1a store only (no vary by parms)", () {
      var sut = MemoSing().$plusParams1;

      var result1 = sut([1, 2, 3]);
      expect(count, 1);
      expect(result1, 3);

      var result2 = sut([1, 2, 3]);
      expect(count, 1);
      expect(result2, 3);

      sut.invalidateCacheAllInternal();
      var result3 = sut([1, 2, 3]);
      expect(count, 2);
      expect(result3, 3);

      //MemoizeOn.storeOnly set, so different param inputs make no difference
      var result4 = sut([]);
      expect(count, 2);
      expect(result4, 3);
    });
  });
}
