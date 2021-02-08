import 'package:build/build.dart';
import 'package:memoizer_generator/src/MemoizerLibraryGenerator.dart';
import 'package:source_gen/source_gen.dart';

Builder memoizerBuilder(BuilderOptions options) {
  return LibraryBuilder(MemoizerLibraryGenerator(),
      generatedExtension: '.memo.dart',
      header: """// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies
import 'package:memoizer_annotation/memoizer_annotation.dart';
""");
}
