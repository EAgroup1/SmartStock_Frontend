//a example for this
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../my_navigator.dart';

//on first, view deleted!!! --- will be a pop up

class SelProd extends StatefulWidget{

  //constructor
  const SelProd({
    required Key key,
    required this.name,
    required this.quantity,
    required this.priceUnit,
    required this.companyUser,
  }) : super(key: key);
  
  //params
  final Widget name, quantity, priceUnit, companyUser;

  //overwrite method ---> return the state
  _SelProdState createState() => _SelProdState();
}

//other class heredates State ---> state of the Stateful Widget
class _SelProdState extends State<SelProd>{

  //variables to modificate


  void grow(){
    //setState ---> draw again the text or something else
    setState(() {
      //final function!
    });
  }

  //which widgets return ---> we stablished on the build
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}