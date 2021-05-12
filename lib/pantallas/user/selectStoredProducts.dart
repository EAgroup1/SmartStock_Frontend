//a example for this
import 'package:flutter/material.dart';

//statefulWidget contains 2 classes

//only focus on the dynamic parts!!

//class SelectedProduct
//draw on the screen
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