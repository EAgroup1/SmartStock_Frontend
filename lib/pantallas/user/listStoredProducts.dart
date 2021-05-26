import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../my_navigator.dart';
 
//listView items/lots of user logged
 
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'List stored products',
//       home: ListProdPage(),
//     );
//   }

//   //void _goMySalary() {}
// }

//we define the list
List <String> lots = ["zapatillas", "gorra", "camisa", "polo"];

//Scaffold Class
class ListProdPage extends StatelessWidget {
  //we'll see required or nullable
  ListProdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My store products'),
          //At the beginning, we will add the salary button $ on the AppBar
          //possibly max. 3 or 4 icon buttons
          //also we find leading button to go back
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.euro_symbol),
              onPressed: (){},
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

              // Container(
              //   color: Colors.grey,
              //   height: 100,
              //   width: 100,
              // ),

              //listView at the beginning
              //if i have a list we can use builder
              ListView.builder(
                itemCount: lots.length,
                itemBuilder: (BuildContext context, int index){
                  //return something, in our case we return the info from each lot of the user
                  final lot = lots[index];
                  return ListTile(
                    title: Text(lot), 
                    leading: Icon(Icons.storage),
                    onTap: (){
                      //do something when we click a lot
                      print(lot);
                    },
                  );
                },
              ),

            ],
          ),
        ),
      );
  }
}