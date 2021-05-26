//mateapp to design a standard project ---> tree of widgets
//now for this view we need different dependencies: fonts & charts
import 'package:flutter/material.dart';
import '../../my_navigator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import '../../my_navigator.dart';

//this is the data graph
 
class SalaryProductsGraph extends StatefulWidget {
  SalaryProductsGraph({Key? key}) : super(key: key);

  @override
  _SalaryProductsGraphState createState() => _SalaryProductsGraphState();
}

class _SalaryProductsGraphState extends State<SalaryProductsGraph> {

//for the moment generate my data, after use the API

//we create the list for our pieData and initialize on initState
//List<charts.Series<Lot, String>> _seriesPieData;

_generateData(){
  var pieData=[
    new Lot('Microsoft', 12.5, Color(0xff00bcd4)),
    new Lot('Apple', 12.5, Color(0xffeceff1)),
    new Lot('Puma', 12.5, Color(0xffff5252)),
    new Lot('Lacoste', 12.5, Color(0xff00c853)),
    new Lot('Adidas', 25.0, Color(0xdd000000)),
    new Lot('Nike', 25.0, Color(0xffff3d00)),
  ];

  //_seriesPieData.add()
}

//first we declare the initState
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_seriesPieData = List<charts.Series<Lot, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                //all these graphs are all about me
                //percentage of stores that i use
                Tab(icon: Icon(FontAwesomeIcons.chartPie), text:"Products"),
                //price/unit of all lots that i do or request
                Tab(icon: Icon(FontAwesomeIcons.solidChartBar), text: "Price/unit"),
                //in march or july i save x sum(qty) of lots
                Tab(icon: Icon(FontAwesomeIcons.chartLine), text: "Total amount"),
              ],
            ),
            title: Text('Flutter Charts'),
          ),
          body: TabBarView(
          children: [],
          ),
        ),
      ),
    );
  }
}

//class lot with its params
class Lot{
  String peoplePerc;
  double peoplePercValue;
  Color colorval;

  //constructor
  Lot(this.peoplePerc, this.peoplePercValue, this.colorval);
}
