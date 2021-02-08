import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:memoizer_generator/src/createMemoizer.dart';
import 'package:memoizer_generator/src/types.dart';
import 'package:source_gen/source_gen.dart';

import 'GeneratorForAnnotationX.dart';

class MemoizerGenerator extends GeneratorForAnnotationX<Memoizer> {
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
    List<ClassElement> allClasses,
  ) {
    var sb = StringBuffer();

    if (element is ClassElement) {
      var className = element.name;
      var callMethod = element.getMethod("call");
      var returnType = callMethod.type.returnType.toString();

      var paramsPositional2 = callMethod.type.parameters.where((x) => x.isPositional);
      var paramsNamed2 = callMethod.type.parameters.where((x) => x.isNamed);

      var paramsPositional = paramsPositional2
          .map((x) => NameType(
                x.name.toString(),
                x.type.toString(),
                memoizeOn: x.metadata.any((e) => e.element.name == "noVaryBy") ? MemoizeOn.storeOnly : MemoizeOn.varyByParam,
              ))
          .toList();
      var paramsNamed = paramsNamed2
          .map((x) => NameType(
                x.name.toString(),
                x.type.toString(),
                memoizeOn: x.metadata.any((e) => e.element.name == "noVaryBy") ? MemoizeOn.storeOnly : MemoizeOn.varyByParam,
              ))
          .toList();

      sb.writeln(createMemoizer(
        className: className,
        returnType: returnType,
        paramsPositional: paramsPositional,
        paramsNamed: paramsNamed,
      ));
    }

    return sb.toString().replaceAll("*", "");
  }
}
