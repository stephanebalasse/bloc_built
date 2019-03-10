import 'package:bloc_annotation/bloc_annotation.dart';
import 'package:bloc_helper_example/test.dart';

import 'package:rxdart/rxdart.dart';
import 'package:bloc_helper_example/bloc_provider.dart';


part 'bloc.g.dart';

@bloc
class DocumentBloc extends Bloc with _DocumentBloc implements BlocBase{


  @BlocStream()
  @BlocUpdate()
  final _referenceController = BehaviorSubject<String>();
  @BlocStream(name:'surname',type:'String' )
  @BlocUpdate()
  final _nameController = BehaviorSubject<String>();



  DocumentBloc(){
    _$constructorBloc();
  }

  @override
  void dispose() {
   _$dispose();
  }

}
