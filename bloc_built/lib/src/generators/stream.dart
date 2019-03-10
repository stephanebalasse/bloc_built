import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_built/src/helpers.dart';
import 'package:code_builder/code_builder.dart';

import 'package:meta/meta.dart';

class StreamGenerator {
  final FieldElement field;
  final BlocStream annotation;
  final String argumentType;
  final String name;
  final String validator;

  StreamGenerator({@required this.field, @required this.annotation})
      : argumentType = annotation.type ?? extractBoundTypeName(field),
        this.validator = annotation.validator ?? null,
        this.name = annotation.name ?? streamName(field.name);

  void buildGetter(ClassBuilder builder) {
    builder.fields.add(Field((b) =>
    b
      ..name = this.name
      ..type = refer("Stream<${this.argumentType}>")
    ));
  }

  void buildConstructor(BlockBuilder builder) {
    builder.statements.add(Code("$name = _parent.${field.name}.stream${ this.validator != null ? '.transform(${this.validator})' : ''};"));
  }

  void buildDispose(BlockBuilder builder) {
    builder.statements.add(Code("_parent.${field.name}.close();"));
  }

}