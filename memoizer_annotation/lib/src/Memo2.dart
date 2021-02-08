import 'package:dartz/dartz.dart';
import 'package:memoizer_annotation/memoizer_annotation.dart';

///Provides an extendable class that implements memoizable results
abstract class Memo2<TOut, TIn1, TIn2> {
  final TOut Function(TIn1, TIn2) memoizedFunction;
  final MemoizeOn memoizeOnP1;
  final MemoizeOn memoizeOnP2;

  Memo2({
    required this.memoizedFunction,
    this.memoizeOnP1 = MemoizeOn.varyByParam,
    this.memoizeOnP2 = MemoizeOn.varyByParam,
  });

  List<Tuple3<TOut, TIn1, TIn2>?> previousResults = [];

  ///Calls the function and saves the result
  TOut callInternal(TIn1 p1, TIn2 p2) {
    var previousResult = previousResults //
        .firstWhere(
            (x) =>
                (memoizeOnP1 == MemoizeOn.storeOnly || doValuesMatch(x?.value2, p1)) && //
                (memoizeOnP2 == MemoizeOn.storeOnly || doValuesMatch(x?.value3, p2)),
            orElse: () => null);
    if (previousResult != null) {
      return previousResult.value1;
    }

    var result = memoizedFunction(p1, p2);
    previousResults.add(Tuple3(result, p1, p2));

    return result;
  }

  ///If null passed to param1 and a value is passed to param2
  /// it will remove all previously saved results where param2
  /// has been used regardless of param1's value.
  ///
  ///If both params are set then only previous results matching
  /// both parameters will be removed
  ///
  ///in(p1: Adrian, p2: Hill), result -> deletes all previous results
  /// where Adrian Hill has been searched for
  ///in(p1: Adrian), result -> deletes all previous results
  /// where Adrian has been searched for (Adrian Hill, Adrian Mole)
  void invalidateCacheInternal({TIn1? p1, TIn2? p2}) {
    if (p1 == null && p2 == null) //
      invalidateCacheAllInternal();

    previousResults //
        .removeWhere((x) =>
            (p1 == null || doValuesMatch(x?.value2, p1)) && //
            (p2 == null || doValuesMatch(x?.value3, p2)));
  }

  ///removes all the previous saved results
  void invalidateCacheAllInternal() {
    previousResults = [];
  }
}
