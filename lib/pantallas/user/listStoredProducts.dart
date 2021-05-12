import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List stored products',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My store products'),
          //At the beginning, we will add the salary button $ on the AppBar
          //possibly max. 3 or 4 icon buttons
          //also we find leading button to go back
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.euro_symbol),
              onPressed: _goMySalary,
              )
          ],
        ),
        //ok, when we arrive to the body we create 2 divs or containers
        //one for the list sort or grid sort ---> we'll see...
        body: SizedBox(
          width: double.infinity,
          child: Column(

            //some styles to render
            //spaces on the conatiners or vertical alignment on them
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //horizontal alignment 
            crossAxisAlignment: CrossAxisAlignment.stretch,

            //children = array de widgets
            children: <Widget>[
              Container(
                color: Colors.grey,
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goMySalary() {
  }
}