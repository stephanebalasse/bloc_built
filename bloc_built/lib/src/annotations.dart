import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:source_gen/source_gen.dart';

//Bind bindFromAnnotation(ConstantReader reader) {
//  final obj = reader.objectValue;
//  final methodName = obj.getField("methodName").toStringValue();
//  final external = obj.getField("external").toBoolValue() ?? false;
//  return Bind(methodName, external: external);
//}

BlocStream streamFromAnnotation(ConstantReader reader) {
  final obj = reader.objectValue;
  final name = obj.getField("name").toStringValue();
  final type = obj.getField("type").toStringValue();
  final validator = obj.getField("validator").toStringValue();
  return BlocStream(name:name,type:type,validator: validator);
}

BlocUpdate updateFromAnnotation(ConstantReader reader) {
  final obj = reader.objectValue;
  final name = obj.getField("name").toStringValue();
  final type = obj.getField("type").toStringValue();
  return BlocUpdate(name:name,type:type);
}
//
//BlocSink sinkFromAnnotation(ConstantReader reader) {
//  final obj = reader.objectValue;
//  final name = obj.getField("name").toStringValue();
//  return BlocSink(name);
//}