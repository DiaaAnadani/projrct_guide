import 'dart:developer';

class ErrorHandler implements Exception {
  final String text;
  ErrorHandler(this.text) {
    log(text);
  }
}
