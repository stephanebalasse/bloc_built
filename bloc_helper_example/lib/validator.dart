import 'dart:async';


class Validator {
  final performEmailValidation = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String emailValidationRule = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(emailValidationRule);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Veuillez saisir une adresse mail valide');
    }
  });

  final performPasswordValidation = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    String passwordValidationRule = '((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#%]).{6,10})';
    RegExp regExp = new RegExp(passwordValidationRule);

    if (regExp.hasMatch(password)) {
      sink.add(password);
    } else {
      sink.addError('Password contain one digit, one lowercase, one uppercase, one special symbol "@#%" and be min. 6 to max. 10 characters long');
    }
  });

  final performLengthValidation = StreamTransformer<String, String>.fromHandlers(handleData: (input, sink) {
    String lengthValidationRule = r'^(\w|-)*$';
    RegExp regExp = new RegExp(lengthValidationRule);
    if (regExp.hasMatch(input)) {
      sink.add(input);
    } else {
      sink.addError('eee');
    }
  });

  final performIdValidation = StreamTransformer<String, String>.fromHandlers(handleData: (input, sink) {
    String idValidationRule = r'^(\w|-){6-30}$';
    RegExp regExp = new RegExp(idValidationRule);
    if (regExp.hasMatch(input)) {
      sink.add(input);
    } else {
      sink.addError('eee');
    }
  });

  final performSurnameValidation = StreamTransformer<String, String>.fromHandlers(handleData: (input, sink) {
    String lengthValidationRule = r'^(\w|-)+$';
    RegExp regExp = new RegExp(lengthValidationRule);
    if(input == ''){
      sink.addError('eee');
    }else if (regExp.hasMatch(input)) {
      sink.add(input);
    } else {
      sink.addError('eee');
    }
  });
  
  final performDateValidation = StreamTransformer<DateTime, DateTime>.fromHandlers(handleData: (input, sink) {
    if (input.isBefore(DateTime.now())) {
      sink.add(input);
    } else {
      sink.addError('ee');
    }
  });
}