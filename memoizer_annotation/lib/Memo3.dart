import 'package:dartz/dartz.dart';
import 'package:memoizer_annotation/memoizerClasses.dart';

///Provides an extendable class that implements memoizable results
abstract class Memo3<TOut, TIn1, TIn2, TIn3> {
  final TOut Function(TIn1, TIn2, TIn3) memoizedFunction;
  final MemoizeOn memoizeOnP1;
  final MemoizeOn memoizeOnP2;
  final MemoizeOn memoizeOnP3;

  Memo3({
    required this.memoizedFunction,
    this.memoizeOnP1 = MemoizeOn.varyByParam,
    this.memoizeOnP2 = MemoizeOn.varyByParam,
    this.memoizeOnP3 = MemoizeOn.varyByParam,
  });

  List<Tuple4<TOut, TIn1, TIn2, TIn3>?> previousResults = [];

  TOut callInternal(TIn1 p1, TIn2 p2, TIn3 p3) {
    var previousResult = previousResults //
        .firstWhere(
            (x) =>
                (memoizeOnP1 == MemoizeOn.storeOnly || doValuesMatch(x?.value2, p1)) && //
                (memoizeOnP2 == MemoizeOn.storeOnly || doValuesMatch(x?.value3, p2)) &&
                (memoizeOnP3 == MemoizeOn.storeOnly || doValuesMatch(x?.value4, p3)),
            orElse: () => null);
    if (previousResult != null) {
      return previousResult.value1;
    }

    var result = memoizedFunction(p1, p2, p3);
    previousResults.add(Tuple4(result, p1, p2, p3));

    return result;
  }

  void invalidateCacheInternal({TIn1? p1, TIn2? p2, TIn3? p3}) {
    if (p1 == null && p2 == null && p3 == null) //
      invalidateCacheAllInternal();

    previousResults //
        .removeWhere((x) =>
            (p1 == null || doValuesMatch(x?.value2, p1)) && //
            (p2 == null || doValuesMatch(x?.value3, p2)) &&
            (p3 == null || doValuesMatch(x?.value4, p3)));
  }

  ///removes all the previous saved results
  void invalidateCacheAllInternal() {
    previousResults = [];
  }
}
