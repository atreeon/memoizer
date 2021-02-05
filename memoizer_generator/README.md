## memoizer

Use if you want to cache the results of previous function calls for efficiency reasons.

#### Basic usage 

##### 1. Convert your function from

```
int getUserId(String name) {
  return Firebase().getUserIdByName(name);
}
```

##### 2. into a callable class, and decorate with the @memoize annotation 

```
@memoizer
class GetUserId {
  int call(String name) {
    return Firebase().getUserIdByName(name);
  }
}
```

##### 3. save an instance and call it; the results will be cached
```
var getUserId = Memo_GetUserId();
var result1 = getUserId("Adrian");
var result2 = getUserId("John");
var result3 = getUserId("Adrian"); //this will save a call to the server as the results have already been cached
```

##### 4. install the dependencies if you have not done so
```
dependencies:
  memoizer_annotation: ^1.0.0-nullsafety

dev_dependencies:
  build_runner: ^1.7.3
  memoizer_generator: ^1.0.0-nullsafety
```

##### 5. run build runner
```
pub run build_runner build
```

See github for more examples
https://github.com/atreeon/memoizer/tree/master/example/test