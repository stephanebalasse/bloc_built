import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_built/src/annotations.dart';
import 'package:bloc_built/src/generators/updade.dart';
import 'package:bloc_built/src/helpers.dart';
import 'package:code_builder/code_builder.dart';
import 'stream.dart';


class BlocGenerator {
  final ClassElement element;
  final List<StreamGenerator> streams;
  final List<UpdateGenerator> update;


  BlocGenerator(this.element) : this.streams = _scanForStreams(element), this.update = _scanForUpdate(element);

  String get name => privateName(this.element.name, "Bloc");

  Class buildMixin() {
    final builder = ClassBuilder()
      ..name = this.name
      ..implements.add(refer("GeneratedBloc<${element.name}>"));

    builder.fields.add(Field((b) => b
      ..name = "_parent"
      ..type = refer(element.name)));


    this.streams.forEach((s) => s.buildGetter(builder));
    this.update.forEach((u) => u.buildGetter(builder));

    this.buildConstructor(builder);

    this.buildDispose(builder);

    this.buildSubscription(builder);

    return builder.build();
  }

  void buildSubscription(ClassBuilder builder) {
    final block = BlockBuilder();
    block.statements.add(Code("this._parent = value;"));
    //    this.streams.forEach((s) => s.buildSubscription(block));
    //    this.sinks.forEach((s) => s.buildSubscription(block));
    //    this.listens.forEach((s) => s.buildSubscription(block));

    builder.methods.add(Method((b) =>
    b
      ..name = "subscribeParent"
      ..annotations.add(CodeExpression(Code("override")))
      ..returns = refer("void")
      ..body = block.build()
      ..requiredParameters.add(Parameter((b) =>
      b
        ..name = "value"
        ..type = refer(this.element.name))
      )
    ));
  }

  static List<StreamGenerator> _scanForStreams(ClassElement element) {
    return element.fields
        .map((field) =>
        ifAnnotated<BlocStream, StreamGenerator>(
            field,
                (e, a) =>
                StreamGenerator(
                    field: e as FieldElement, annotation: streamFromAnnotation(a))))
        .where((x) => x != null)
        .toList();
  }

  static List<UpdateGenerator> _scanForUpdate(ClassElement element) {
    return element.fields
        .map((field) =>
        ifAnnotated<BlocUpdate, UpdateGenerator>(
            field,
                (e, a) =>
                    UpdateGenerator(
                    field: e as FieldElement, annotation:updateFromAnnotation(a))))
        .where((x) => x != null)
        .toList();
  }

  void buildConstructor(ClassBuilder builder) {
    final block = BlockBuilder();
    this.streams.forEach((s) => s.buildConstructor(block));
    builder.methods.add(Method((b) =>   b
      ..name = "_\$constructorBloc"
      ..body = block.build()
    ));
  }

  void buildDispose(ClassBuilder builder) {
    final block = BlockBuilder();
    this.streams.forEach((s) => s.buildDispose(block));
    builder.methods.add(Method((b) =>  b
      ..name = "_\$dispose"
      ..body = block.build()
    ));
  }

//  static List<SinkGenerator> _scanForSinks(ClassElement element) {
//    return element.fields
//        .map((field) => ifAnnotated<BlocSink, SinkGenerator>(
//            field,
//            (e, a) {
//              final public = publicName(e.name,"");
//              final streamGenerator = ifAnnotated<BlocStream, StreamGenerator>(e, (ee,a) => StreamGenerator(
//                field: ee as FieldElement, annotation: streamFromAnnotation(a)));
//
//              final capitalizedPublic = public[0].toUpperCase() + public.substring(1);
//              final defaultName = streamGenerator?.name == public ? "update$capitalizedPublic" : null;
//
//              return SinkGenerator(
//                field: e as FieldElement, annotation: sinkFromAnnotation(a), defaultName: defaultName);
//            }))
//        .where((x) => x != null)
//        .toList();
//  }
//
//  static List<BindGenerator> _scanForBinds(ClassElement element) {
//    return element.fields
//        .map((method) => ifAnnotated<Bind, BindGenerator>(
//            method,
//            (e, a) => BindGenerator(
//                blocClass: element,
//                field: e as FieldElement,
//                annotation: bindFromAnnotation(a))))
//        .where((x) => x != null)
//        .toList();
//  }
}
