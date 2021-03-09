// ignore: import_of_legacy_library_into_null_safe
import 'package:build/build.dart';
import 'package:memoizer_generator/src/MemoizerGeneratorBuilder.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:source_gen/source_gen.dart';

Builder memoizerBuilder(BuilderOptions options) => //
    PartBuilder([MemoizerGenerator()], '.memoizer.dart',
        header: '''
    ''');

//Builder memoizerBuilder(BuilderOptions options) => //
//    SharedPartBuilder(
//      [MemoizerGenerator()],
//      'memoizer',
//      additionalOutputExtensions: ["x"],
//    );
