import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import 'generators/bloc.dart' as gen;


import 'package:bloc_annotation/bloc_annotation.dart';

enum ServiceMetadataType { input, output, bloc, trigger, mapper }

class ServiceMetadata {
  final ServiceMetadataType type;
  final List<ElementAnnotation> metadata;

  ServiceMetadata(this.type, this.metadata)
      : assert(type != null),
        assert(metadata != null);
}

class BlocBuiltGenerator extends GeneratorForAnnotation<BLoC> {
  BuilderOptions options;

  BlocBuiltGenerator(this.options);

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep)  {
    if (element is ClassElement) {
      final name = element.name;

      if (!element.allSupertypes.any((s) => s.name == "Bloc")) {
        throw InvalidGenerationSourceError(
            'Generator can only target classes that inherit from Bloc class.',
            todo: 'Add the Bloc as a supertype of `$name`.',
            element: element);
      }

      final generator = gen.BlocGenerator(element);
      final mixinClass = generator.buildMixin();

      var library = Library((b) => b..body.addAll([mixinClass])..directives.addAll([]));

      var emitter = DartEmitter();
      var source = '${library.accept(emitter)}';
//      print(generator);
      return [source];
    }
  }
}