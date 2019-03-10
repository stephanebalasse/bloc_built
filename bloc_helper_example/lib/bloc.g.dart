// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// BlocBuiltGenerator
// **************************************************************************

class _DocumentBloc implements GeneratedBloc<DocumentBloc> {
  DocumentBloc _parent;

  Stream<String> referenceStream;

  Stream<String> surname;

  Function(String) get updateReference => _parent._referenceController.sink.add;
  Function(String) get updateName => _parent._nameController.sink.add;
  _$constructorBloc() {
    referenceStream = _parent._referenceController.stream;
    surname = _parent._nameController.stream;
  }

  _$dispose() {
    _parent._referenceController.close();
    _parent._nameController.close();
  }

  @override
  void subscribeParent(DocumentBloc value) {
    this._parent = value;
  }
}
