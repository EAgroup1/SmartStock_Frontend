import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../my_navigator.dart';
//graph imports
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
 
class SalaryProductsGraph extends StatefulWidget {
  SalaryProductsGraph({Key? key}) : super(key: key);

  @override
  _SalaryProductsGraphState createState() => _SalaryProductsGraphState();
}

class _SalaryProductsGraphState extends State<SalaryProductsGraph> {
  
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
                Tab(icon: Icon(FontAwesomeIcons.chartPie), text:"Tus empresas"),
                //price/unit of all lots that i do or request
                Tab(icon: Icon(FontAwesomeIcons.solidChartBar), text: "Pedidos/Mes"),
                //in march or july i save x sum(qty) of lots
                Tab(icon: Icon(FontAwesomeIcons.chartLine), text: "Futuros pedidos"),
              ],
            ),
            title: Text('Tus diagramas'),
          ),
          body: TabBarView(
            children: [
              //my three views
              ChartPiePage(),
              SolidChartBarPage(),
              ChartLinePage(),
            ],
          ),
        ),
      ),
    );
  }
}

//first view = cheese view
class ChartPiePage extends StatefulWidget {
  ChartPiePage({Key? key}) : super(key: key);

  @override
  _ChartPiePageState createState() => _ChartPiePageState();
}

class _ChartPiePageState extends State<ChartPiePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       //to do something
       height: 550,
       child: SfCircularChart(
         tooltipBehavior: TooltipBehavior(
           enable: true
         ),
         title: ChartTitle(
           text: "Porcentaje de tus tiendas almacenadas"
         ),
         legend: Legend(
           isVisible: true
         ),
         series: <PieSeries>[
           PieSeries<CompanySales, String>(
             dataSource: getStringData(),
             xValueMapper: (CompanySales sales,_)=>sales.x,
             yValueMapper: (CompanySales sales,_)=>sales.y,
             dataLabelSettings: DataLabelSettings(
               isVisible: true
             )
           )
         ],
       )
    );
  }
}

//second diagram = solid diagram - check
class SolidChartBarPage extends StatefulWidget {
  SolidChartBarPage({Key? key}) : super(key: key);

  @override
  _SolidChartBarPageState createState() => _SolidChartBarPageState();
}

class _SolidChartBarPageState extends State<SolidChartBarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       //to do something
       height: 550,
       child: SfCartesianChart(
         title: ChartTitle(
           text: "Lotes Acumulados Por Mes"
         ),
         primaryXAxis: NumericAxis(
           title: AxisTitle(
             text: "Mes"
           )
         ),
         primaryYAxis: NumericAxis(
           title: AxisTitle(
             text: "Lotes"
           )
         ),
         legend: Legend(
           isVisible: true
         ),
         tooltipBehavior: TooltipBehavior(
           enable: true
         ),
         series: <ChartSeries>[
           ColumnSeries<LotsMonth, double>(
             dataSource: getColumnData(),
             xValueMapper: (LotsMonth lots,_)=>lots.x,
             yValueMapper: (LotsMonth lots,_)=>lots.y,
             name: "Lotes ABC",
             legendIconType: LegendIconType.diamond,
             //we put the marks for each layer
             dataLabelSettings: DataLabelSettings(
               isVisible: true
             )
           )
         ],
       ),
    );
  }
}

//third diagram = line diagram - check
class ChartLinePage extends StatefulWidget {
  ChartLinePage({Key? key}) : super(key: key);

  @override
  _ChartLinePageState createState() => _ChartLinePageState();
}

class _ChartLinePageState extends State<ChartLinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       //to do something
       height: 550,
       child: SfCartesianChart(
        //we can see a total follow-up
        //  crosshairBehavior: CrosshairBehavior(
        //    enable: true,
        //    activationMode: ActivationMode.longPress
        //  ),
        //we can see all axis X points
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap
        ),
         title: ChartTitle(
           text: "Lotes Acumulados Por Mes"
         ),
         primaryXAxis: NumericAxis(
           title: AxisTitle(
             text: "Mes"
           )
         ),
         primaryYAxis: NumericAxis(
           title: AxisTitle(
             text: "Lotes"
           )
         ),
         legend: Legend(
           isVisible: true
         ),
         tooltipBehavior: TooltipBehavior(
           enable: true
         ),
         series: <ChartSeries>[
           LineSeries<LotsMonth, double>(
             dataSource: getHugeData(),
             xValueMapper: (LotsMonth lots,_)=>lots.x,
             yValueMapper: (LotsMonth lots,_)=>lots.y,
             name: "Lotes ABC",
             legendIconType: LegendIconType.diamond,
             //we put the marks for each layer
            //  dataLabelSettings: DataLabelSettings(
            //    isVisible: true
            //  )
           )
         ],
       ),
    );
  }
}


//fakes methods for the graph

//Chart Class definition
class Lot{
  String peoplePerc;
  double peoplePercValue;
  Color colorval;

  //Class constructor initialization
  Lot(this.peoplePerc, this.peoplePercValue, this.colorval);
}

//axis variables Class constructor
class LotsMonth{
  double x, y;
  LotsMonth(this.x, this.y);
}

//function that it's return solid diagram
dynamic getColumnData(){
  List<LotsMonth> columnData = <LotsMonth>[
    //first 5 months
    LotsMonth(1, 10),
    LotsMonth(2, 22),
    LotsMonth(3, 13),
    LotsMonth(4, 23),
    LotsMonth(5, 25)
  ];
  return columnData;
}

//function that it's return line diagram
dynamic getHugeData(){
  List<LotsMonth> hugeData =<LotsMonth>[];
  double value=100;
  Random rand = new Random();

  for(int i=0; i<1000; i++){
    if(rand.nextDouble()>0.5)
    value+=rand.nextDouble();
    else value-=rand.nextDouble();

    hugeData.add(LotsMonth(i.toDouble(), value));
  }
  return hugeData;
}

//ok, now we put percentages
class CompanySales{
  String x;
  double y;

  CompanySales(this.x, this.y);
}

//& the method
dynamic getStringData(){
  List<CompanySales> stringData=<CompanySales>[
    CompanySales("Nike", 25),
    CompanySales("Adidas", 25),
    CompanySales("Lacoste", 12.5),
    CompanySales("Puma", 12.5),
    CompanySales("Apple", 12.5),
    CompanySales("Microsoft", 12.5)
  ];
  return stringData;
}