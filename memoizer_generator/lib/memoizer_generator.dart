import 'package:build/build.dart';
import 'package:memoizer_generator/src/MemoizerGeneratorBuilder.dart';
import 'package:source_gen/source_gen.dart';

Builder memoizerBuilder(BuilderOptions options) => //
    SharedPartBuilder([MemoizerGenerator()], 'memoizer');
