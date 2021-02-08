import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

//VARY BY PARAMS

var count = 0;

class Memo_VaryByParams extends Memo1<int, List<int>> {
  Memo_VaryByParams()
      : super(
          memoizedFunction: (List<int> a) => PlusParams1().call(a),
          memoizeOnP1: MemoizeOn.varyByParam,
        );

  int call(List<int> firstParam) {
    return super.callInternal(firstParam);
  }

  void invalidateCache({required List<int> firstParam}) {
    super.invalidateCacheInternal(p1: firstParam);
  }
}

class Memo_VaryByParams2 extends Memo1<int, String> {
  Memo_VaryByParams2()
      : super(
          memoizedFunction: (String a) => Fn2().call(a),
          memoizeOnP1: MemoizeOn.varyByParam,
        );

  int call(String firstParam) {
    return super.callInternal(firstParam);
  }

  void invalidateCache({required String firstParam}) {
    super.invalidateCacheInternal(p1: firstParam);
  }
}

class PlusParams1 {
  int call(List<int> firstParam) {
    count++;
    return firstParam.length;
  }
}

class Fn2 {
  int call(String firstParam) {
    count++;
    return firstParam.length;
  }
}

class MemoSing {
  var $fn1 = Memo_VaryByParams();
  var $fn2 = Memo_VaryByParams2();

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
      var sut = MemoSing().$fn2;

      var result1 = sut("hi");
      expect(count, 1);
      expect(result1, 2);

      var result2 = sut("hi");
      expect(count, 1);
      expect(result2, 2);

      var result3 = sut("diff");
      expect(count, 2);
      expect(result3, 4);
    });

    test("2a list equality", () {
      var sut = MemoSing().$fn1;

      var result1 = sut([1, 2, 3]);
      expect(count, 1);
      expect(result1, 3);

      //MemoizeOn.storeOnly set, so different param inputs make no difference
      var result2 = sut([1]);
      expect(count, 2);
      expect(result2, 1);

      var result3 = sut([1]);
      expect(count, 2);
      expect(result3, 1);
    });
  });
}
