import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

//NULLABLE PARAMETERS

var count = 0;

class Memo_Fn extends Memo1<int?, List<int>?> {
  Memo_Fn()
      : super(
          memoizedFunction: (List<int>? a) => Fn().call(a),
          memoizeOnP1: MemoizeOn.varyByParam,
        );

  int? call(List<int>? firstParam) {
    return super.callInternal(firstParam);
  }

  void invalidateCache({required List<int>? firstParam}) {
    super.invalidateCacheInternal(p1: firstParam);
  }
}

class Fn {
  int? call(List<int>? firstParam) {
    count++;

    if (firstParam == null) //
      return null;

    return firstParam.length;
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
