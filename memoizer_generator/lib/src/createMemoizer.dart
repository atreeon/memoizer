import 'package:generator_common/NameType.dart';
import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:memoizer_generator/src/helpers.dart';

String createMemoizer({
  required String className,
  required String returnType,
  required List<NameTypeClassCommentData<MemoizeOn>> paramsPositional,
  required List<NameTypeClassCommentData<MemoizeOn>> paramsNamed,
}) {
  var sb = StringBuffer();

  var classMemoed = classNameMemoed(className: className);
  var paramsAll = getAllParams(
    paramsPositional: paramsPositional,
    paramsNamed: paramsNamed,
  );

  sb.writeln(classDefinition(
    classNameMemoed: classMemoed,
    returnType: returnType,
    paramsAll: paramsAll,
  ));
  sb.writeln("${classMemoed}()");
  sb.writeln(": super(");
  sb.writeln(superMemoizedFunction(
    className: className,
    paramsPositional: paramsPositional,
    paramsNamed: paramsNamed,
  ));
  sb.writeln(superMemoizeOnPX(paramsAll: paramsAll));
  sb.writeln(");");
  sb.writeln(fnConstructor(
    returnType: returnType,
    paramsPositional: paramsPositional,
    paramsNamed: paramsNamed,
  ));
  sb.writeln(callBody(paramsAll: paramsAll));
  sb.writeln("}\n");
  sb.writeln(invalidateCacheByParamConstructor(paramsAll: paramsAll));
  sb.writeln(invalidateCacheByParamCall(paramsAll: paramsAll));
  sb.writeln("}\n}");

  return sb.toString();
}
