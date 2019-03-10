
import 'package:bloc_built/src/bloc_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder blocBuilt(BuilderOptions options) {
  return SharedPartBuilder(
      [BlocBuiltGenerator(options)], 'bloc_built');
}