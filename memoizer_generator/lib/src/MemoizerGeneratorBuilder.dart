import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:build/src/builder/build_step.dart';
import 'package:generator_common/helpers.dart';
import 'package:memoizer_annotation/memoizer_annotation.dart';
import 'package:memoizer_generator/src/createMemoizer.dart';
// ignore: import_of_legacy_library_into_null_safe
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

      if (callMethod == null) //
        throw Exception("Memoizer only works on callable classes.  You must have a method named 'call'");

      var methodDetails = getMethodDetailsForFunctionType<MemoizeOn>(
        callMethod,
        (x) => x.metadata.any((e) => e.element!.name == "noVaryBy") ? MemoizeOn.storeOnly : MemoizeOn.varyByParam,
      );

      //      var returnType = callMethod!.type.returnType.toString();
//
//      var paramsPositional2 = callMethod.type.parameters.where((x) => x.isPositional);
//      var paramsNamed2 = callMethod.type.parameters.where((x) => x.isNamed);
//
//      var paramsPositional = paramsPositional2
//          .map((x) => NameType(
//                x.name.toString(),
//                x.type.toString(),
//                memoizeOn: x.metadata.any((e) => e.element!.name == "noVaryBy") ? MemoizeOn.storeOnly : MemoizeOn.varyByParam,
//              ))
//          .toList();
//      var paramsNamed = paramsNamed2
//          .map((x) => NameType(
//                x.name.toString(),
//                x.type.toString(),
//                memoizeOn: x.metadata.any((e) => e.element!.name == "noVaryBy") ? MemoizeOn.storeOnly : MemoizeOn.varyByParam,
//              ))
//          .toList();

      sb.writeln(createMemoizer(
        className: className,
        returnType: methodDetails.returnType,
        paramsPositional: methodDetails.paramsPositional,
        paramsNamed: methodDetails.paramsNamed,
      ));
    }

    return sb.toString().replaceAll("*", "");
  }
}
