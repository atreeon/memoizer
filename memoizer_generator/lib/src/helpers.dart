import 'package:dartx_nullsafety/dartx.dart';
import 'package:memoizer_generator/src/types.dart';
import 'package:meta/meta.dart';

String classDefinition({
  @required String classNameMemoed,
  @required String returnType,
  @required List<NameType> paramsAll,
}) {
  var typeParams = [
    returnType,
    ...paramsAll.map((e) => e.type),
  ].join(", ");
  return "class ${classNameMemoed} extends Memo${paramsAll.length}<$typeParams> {";
}

String classNameMemoed({@required String className}) => //
    "Memo_${className}";

List<NameType> getAllParams({
  @required List<NameType> paramsPositional,
  @required List<NameType> paramsNamed,
}) =>
    [
      ...paramsPositional,
      ...paramsNamed,
    ];

String superMemoizedFunction({
  @required String className,
  @required List<NameType> paramsPositional,
  @required List<NameType> paramsNamed,
}) {
  var allParamsList = getAllParams(paramsPositional: paramsPositional, paramsNamed: paramsNamed);
  var paramList = allParamsList.map((e) => "${e.type} ${e.name}").join(", ");
  var callList = [
    ...paramsPositional.map((e) => "${e.name}"),
    ...paramsNamed.map((e) => "${e.name}: ${e.name}"),
  ].join(", ");

  return "memoizedFunction: (${paramList}) => ${className}().call(${callList}),";
}

String superMemoizeOnPX({
  @required List<NameType> paramsAll,
}) => //
    paramsAll //
        .mapIndexed((index, e) => "memoizeOnP${index + 1}: ${e.memoizeOn.toString()}")
        .join(",\n");

String fnConstructor({
  @required String returnType,
  @required List<NameType> paramsPositional,
  @required List<NameType> paramsNamed,
}) {
  var positional = paramsPositional.map((e) => //
      "${e.type} ${e.name}").join(", ");

  if (positional.length > 0) //
    positional = "${positional}, ";

  var named = paramsNamed.map((e) => //
      "${e.type.contains("?") ? "" : "required "}${e.type} ${e.name}").join(", ");

  if (named.length > 0) //
    named = "{${named}, }";

  return "${returnType} call(${positional}${named}) {";
}

String callBody({
  @required List<NameType> paramsAll,
}) {
  var paramNames = paramsAll.map((e) => e.name).join(", ");
  return "return super.callInternal(${paramNames});";
}

String invalidateCacheByParamConstructor({
  @required List<NameType> paramsAll,
}) {
  var paramList = //
      paramsAll
          .map((e) => //
              "${e.type}${!e.type.contains("?") ? "?" : ""} ${e.name}") //
          .join(", ");

  if (paramList.length > 0) //
    paramList = "{${paramList}}";

  return "void invalidateCache(${paramList}) {";
}

String invalidateCacheByParamCall({
  @required List<NameType> paramsAll,
}) {
  var params = paramsAll //
      .mapIndexed((index, e) => "p${index + 1}: ${e.name}")
      .join(", ");

  return "super.invalidateCacheInternal(${params});";
}
