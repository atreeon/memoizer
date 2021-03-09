import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:mock_creator_annotation/mock_creator_annotation.dart';
import 'package:test/test.dart';

part 'memoizer10_test.mock.dart';
part 'memoizer10_test.memoizer.dart';
//ADDITIONAL BUILDER

var count = 0;

@memoizer
@MockCreator()
class Fn10 {
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
  var $fn1 = Memo_Fn10();

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
    });
  });
}
