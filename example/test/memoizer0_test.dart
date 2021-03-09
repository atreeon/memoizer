import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:test/test.dart';

part 'memoizer0_test.memoizer.dart';

//BASIC EXAMPLE THAT COUNT ONLY GETS INCREMENTED ON DIFFERENT CALLS OR AFTER
// INVALIDATECACHE HAS BEEN CALLED

var count = 0;

@memoizer
class PlusParams0 {
  int call() {
    count++;
    return 1;
  }
}

@memoizer
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
  setUp(() {
    count = 0;
    MemoSing().$plusParams0.invalidateCacheAllInternal();
  });

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
