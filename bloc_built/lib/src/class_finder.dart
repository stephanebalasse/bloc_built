// Copyright 2019 Callum Iddon
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:analyzer/dart/element/element.dart';

import 'package:meta/meta.dart';

class ClassFinder extends ElementVisitor<void> {
  void Function(Element) field;
  void Function(Element) method;

  ClassFinder({@required this.field, @required this.method})
      : assert(field != null),
        assert(method != null);

  @override
  void visitFieldElement(FieldElement element) => field(element);
  @override
  void visitMethodElement(MethodElement element) => method(element);

  @override
  void visitClassElement(ClassElement element) {}
  @override
  void visitCompilationUnitElement(CompilationUnitElement element) {}
  @override
  void visitConstructorElement(ConstructorElement element) {}
  @override
  void visitExportElement(ExportElement element) {}
  @override
  void visitFieldFormalParameterElement(FieldFormalParameterElement element) {}
  @override
  void visitFunctionElement(FunctionElement element) {}
  @override
  void visitFunctionTypeAliasElement(FunctionTypeAliasElement element) {}
  @override
  void visitGenericFunctionTypeElement(GenericFunctionTypeElement element) {}
  @override
  void visitImportElement(ImportElement element) {}
  @override
  void visitLabelElement(LabelElement element) {}
  @override
  void visitLibraryElement(LibraryElement element) {}
  @override
  void visitLocalVariableElement(LocalVariableElement element) {}
  @override
  void visitMultiplyDefinedElement(MultiplyDefinedElement element) {}
  @override
  void visitParameterElement(ParameterElement element) {}
  @override
  void visitPrefixElement(PrefixElement element) {}
  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {}
  @override
  void visitTopLevelVariableElement(TopLevelVariableElement element) {}
  @override
  void visitTypeParameterElement(TypeParameterElement element) {}
}
