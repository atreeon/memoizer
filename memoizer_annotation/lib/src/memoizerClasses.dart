import 'package:memoizer_annotation/src/listEquals.dart';

///The container to hold the result of the function
/// Future: add a timestamp here
class MemoizedResult<TOut> {
  final TOut memoizedResult;

  MemoizedResult({required this.memoizedResult});
}

enum MemoizeOn { varyByParam, storeOnly }

bool doValuesMatch<T1, T2>(T1 value1, T2 value2) {
  if (value2 is List) //
    return listEquals(value1 as List, value2);

  return value1 == value2;
}
