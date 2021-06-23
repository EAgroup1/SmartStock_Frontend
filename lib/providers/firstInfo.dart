import 'package:flutter/material.dart';

class FirstInfo with ChangeNotifier{
  //manage the string sort or option of listStoredProd
  List<String> _options = ['Ordenar por Nombre','Ordenar por precio', 'Ordenar por cantidad'];

  late String _selectedOption = 'Ordenar por Nombre';

  //getters
  List<String> get options => _options;
  String get selected => _selectedOption;

  //setters and notify all widgets
  void setSelectedOption(String s){
    _selectedOption = s;
    notifyListeners();
  }

}