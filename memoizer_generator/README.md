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

##### 3. call it and the results will be cached
```
var getUserId = GetUserId();
var result1 = getUserId("Adrian");
var result2 = getUserId("John");
var result3 = getUserId("Adrian"); //this will save a call to the server as the results would have already been cached
```

##### 4. install the dependencies if you have not done so
```

```

##### 5. run build runner
```
pub run build_runner build
```

See github for more examples