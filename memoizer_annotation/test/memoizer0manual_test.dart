import 'package:memoizer_annotation/Memo0.dart';
import 'package:test/test.dart';

var count = 0;

class Memo_PlusParams0 extends Memo0<int> {
  Memo_PlusParams0() : super(memoizedFunction: () => PlusParams0().call());

  int call() {
    return super.callInternal();
  }
}

class Memo_PlusParams0_nullable extends Memo0<double?> {
  Memo_PlusParams0_nullable() : super(memoizedFunction: () => PlusParams0_nullable().call());

  double? call() {
    return super.callInternal();
  }
}

class PlusParams0 {
  int call() {
    count++;
    return 1;
  }
}

class PlusParams0_nullable {
  double? call() {
    return null;
  }
}

class MemoSing {
  var $plusParams0 = Memo_PlusParams0();
  var $plusParams0_nullable = Memo_PlusParams0_nullable();

  //boilerplate
  static final MemoSing _singleton = MemoSing._internal();
  factory MemoSing() {
    return _singleton;
  }
  MemoSing._internal();
}

void main() {
  group('memo0', () {
    test('b0', () {
      var sut = MemoSing().$plusParams0;

      sut();
      sut();
      sut.invalidateCacheAllInternal();
      sut();
      sut();

      expect(count, 2);
    });

    test('b1 returns a nullable', () {
      var sut = MemoSing().$plusParams0_nullable;

      var result1 = sut();
      expect(result1, null);
    });
  });
}
