import 'package:flutter/cupertino.dart';

extension KeyboardExtension on BuildContext{
  void hideKeyboard(){
      FocusManager.instance.primaryFocus?.unfocus();
  }
}
