import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

//POSITIONAL AND NAMED PARAMETERS

var count = 0;

class Memo_Fn extends Memo2<int?, List<int>, String> {
  Memo_Fn()
      : super(
          memoizedFunction: (List<int> ages, String name) => Fn().call(ages, name: name),
          memoizeOnP1: MemoizeOn.varyByParam,
        );

  int? call(
    List<int> ages, {
    required String name,
  }) {
    return super.callInternal(ages, name);
  }

  void invalidateCache({required List<int>? firstParam}) {
    super.invalidateCacheInternal(p1: firstParam);
  }
}

class Fn {
  int? call(
    List<int> ages, {
    required String name,
  }) {
    count++;

    return ages.length + name.length;
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

      var result1 = sut([1, 2, 3], name: "bob");
      expect(count, 1);
      expect(result1, 6);

      var result2 = sut([1, 2, 3], name: "bob");
      expect(count, 1);
      expect(result2, 6);

      var result3 = sut([1], name: "bob");
      expect(count, 2);
      expect(result3, 4);
    });
  });
}
