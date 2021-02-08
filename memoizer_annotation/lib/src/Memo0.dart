import 'package:memoizer_annotation/src/memoizerClasses.dart';

///Provides an extendable class that implements memoizable results
abstract class Memo0<TOut> {
  final TOut Function() memoizedFunction;

  Memo0({
    required this.memoizedFunction,
  });

  MemoizedResult<TOut>? memoizedResult;

  TOut callInternal() {
    if (memoizedResult == null) {
      var result = memoizedFunction();
      memoizedResult = MemoizedResult<TOut>(memoizedResult: result);
    }

    return memoizedResult!.memoizedResult;
  }

  ///removes all the previous saved results
  void invalidateCacheInternal() {
    invalidateCacheAllInternal();
  }

  ///removes all the previous saved results
  void invalidateCacheAllInternal() {
    memoizedResult = null;
  }
}
