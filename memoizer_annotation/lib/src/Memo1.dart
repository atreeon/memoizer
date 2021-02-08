import 'package:dartz/dartz.dart';
import 'package:memoizer_annotation/src/memoizerClasses.dart';

///Provides an extendable class that implements memoizable results
abstract class Memo1<TOut, TIn1> {
  final TOut Function(TIn1) memoizedFunction;
  final MemoizeOn memoizeOnP1;

  Memo1({
    required this.memoizedFunction,
    this.memoizeOnP1 = MemoizeOn.varyByParam,
  });

  List<Tuple2<TOut, TIn1>?> previousResults = []; //

  TOut callInternal(TIn1 p1) {
    var previousResult = previousResults //
        .firstWhere(
            (x) => //
                (memoizeOnP1 == MemoizeOn.storeOnly || doValuesMatch(x?.value2, p1)),
            orElse: () => null);

    if (previousResult != null) //
      return previousResult.value1;

    var result = memoizedFunction(p1);
    previousResults.add(Tuple2(result, p1));

    return result;
  }

  ///removes all the previous saved results based on the parameter
  ///
  /// If a parameter is supplied then it will delete all the results where
  ///   that parameter has been used to retrieve a result
  void invalidateCacheInternal({TIn1? p1}) {
    if (p1 == null) //
      invalidateCacheAllInternal();

    previousResults //
        .removeWhere((x) => (p1 == null || doValuesMatch(x?.value2, p1)));
  }

  ///removes all the previous saved results
  void invalidateCacheAllInternal() {
    previousResults = [];
  }
}
