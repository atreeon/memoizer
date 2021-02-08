import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

var count = 0;

class Memo_PlusParams1 extends Memo1<int, List<int>> {
  Memo_PlusParams1()
      : super(
          memoizedFunction: (List<int> a) => PlusParams1().call(a),
          memoizeOnP1: MemoizeOn.storeOnly,
        );

  int call(List<int> firstParam) {
    return super.callInternal(firstParam);
  }

  void invalidateCache({required List<int> firstParam}) {
    super.invalidateCacheInternal(p1: firstParam);
  }
}

class PlusParams1 {
  int call(List<int> firstParam) {
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
