import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_built/src/helpers.dart';
import 'package:code_builder/code_builder.dart';

import 'package:meta/meta.dart';

class UpdateGenerator {
  final FieldElement field;
  final BlocUpdate annotation;
  final String argumentType;
  final String name;

 UpdateGenerator({@required this.field, @required this.annotation})
      : argumentType = annotation.type ??  extractBoundTypeName(field),
        this.name = annotation.name ?? updateName(field.name);

  void buildGetter(ClassBuilder builder) {
    builder.methods.add(Method((b) => b
      ..name = this.name
      ..type = MethodType.getter
      ..returns = refer("Function(${this.argumentType})")
        ..lambda = true
        ..body = Code("_parent.${field.name}.sink.add")
    ));
  }

  void buildConstructor(BlockBuilder builder) {
    builder.statements.add(Code("$name= _parent.${field.name}.stream;"));
  }

  void buildDispose(BlockBuilder builder){
    builder.statements.add(Code("_parent.${field.name}.close();"));
  }

}