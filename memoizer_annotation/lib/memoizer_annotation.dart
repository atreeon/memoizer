/// Creates a new function with memoize functionality
///
/// 1. If a parameter should be ignored when comparing the results
/// use: [noVaryBy] on the parameter
///
/// 2. Maximum of 3 parameters (so far)
///
/// 3. Doesn't work with default values
///
/// 4. if a parameter is nullable it is not required, if a parameter is nonnullable then it is required
///
/// 5. only works on callable classes
class Memoizer {
  const Memoizer();
}

const memoizer = Memoizer();

///Ignores the paramter when it comes to saving previous results
///
/// Useful for long lists where we don't want to compare the results
/// before saving
///
/// getUserId(@noVaryBy first, last)
/// previousResult = []
///
/// in(first: Adrian, last: Hill), out(5)
/// changed previousResult = {result: 5, p1: null, p2: hill}
///
/// in(first: Adrian, last: Hill), out(5)
/// changed previousResult = {result: 5, p1: null, p2: hill}
///
/// in(first: Jimmy, last: Hill), out(5)
/// changed previousResult = {result: 5, p1: null, p2: hill}
class NoVaryBy {
  const NoVaryBy();
}

const noVaryBy = NoVaryBy();
