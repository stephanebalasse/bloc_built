import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:bloc_built/src/class_finder.dart';
import 'package:bloc_built/src/metadata.dart';
import 'package:bloc_built/src/utils.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';


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
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async* {
    final String className = element.name;
    final String name = element.name[0] == '_' ? element.name.substring(1) : element.name;
    final String bloc = '${name}BLoC';

    final List<ServiceMetadata> allServices = <ServiceMetadata>[];
    if(findMetadata(element,'@BLoCFunctionInit')){
     for(final ElementAnnotation metadata in getMetadata(element, '@BLoCFunctionInit')){
       print(findInputs(metadata).toList());
     };
    }

    final StringBuffer controllers = StringBuffer('');
    final StringBuffer streams = StringBuffer('');
    final StringBuffer update = StringBuffer('');
    final StringBuffer dispose = StringBuffer('');
    final StringBuffer controllersInit = StringBuffer('');
    final StringBuffer paramaters = StringBuffer('');
    final StringBuffer paramatersList = StringBuffer('');
    final StringBuffer paramatersInit = StringBuffer('');
    final List<String> paramatersAssert = <String>[];


    final Map<String, String> currentValues = <String, String>{};


    element.visitChildren(ClassFinder(field: (Element element) {
      final String inputType = findType(element);
      final String inputName = findName(element);

      final bool isBehavior = findMetadata(element, '@BehaviorStream');
      final bool isInput = findMetadata(element, '@BLoCInput');
      final bool isParamater = findMetadata(element, '@BLoCParamater');

      String templateType;
      if (isInput) {
        templateType = findTemplateType(element);
      }
      final String name = inputName[0] == '_' ? inputName.substring(1) : inputName;
      final String nameUpperCase = capitalize(name);

      if (isBehavior) {
        controllers.writeln('final _${name}Controller = BehaviorSubject<$inputType>();');

        streams.writeln('Stream<$inputType> ${name}Stream;');

        update.writeln('Function($inputType) get update$nameUpperCase => _${name}Controller.sink.add;');

        dispose.writeln('_${name}Controller.close();');

        controllersInit.writeln('${name}Stream = _${name}Controller.stream;');
      } else if (isParamater) {
        paramaters.writeln('$inputType $name;');
        for (final ElementAnnotation metadata in getMetadata(element, '@BLoCParamater')) {
          final String required = findInputs(metadata)[0];
          final bool isRequired = required == 'true' ? true : false;
          paramatersList.writeln(' ${isRequired ? '@required' : ''} this.$name, ');

        }
      }
    },method: (Element element) {
      print(element);
    }));

    yield ''' 
      class $bloc extends Validator implements BlocBase {
      
       ${element.name} template = ${element.name}();
      
      //Variable
      $paramaters
      
      // Controller
      $controllers
      
      // Streams
      $streams
      
      // Update
      $update
      
      $bloc${paramatersList.toString() == '' ? '()' : '''
        ({
          $paramatersList
        }) 
        '''} {
          $paramatersInit

          $controllersInit

          template.init();
        }
      
      // Dispose
      @override
      void dispose(){
        $dispose
      }
      
     }
     ''';
  }

}