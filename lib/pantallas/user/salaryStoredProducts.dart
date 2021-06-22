import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rlbasic/services/lotServices.dart';
// import '../../my_navigator.dart';
//graph imports
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

//other imports
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/models/lot.dart';
import 'dart:core';
import 'package:rlbasic/services/userServices.dart';

GlobalData globalData = GlobalData.getInstance()!;

 
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
                Tab(icon: Icon(FontAwesomeIcons.chartPie), text:"Mis lotes"),
                Tab(icon: Icon(FontAwesomeIcons.solidChartBar), text: "Mis pedidos"),
                Tab(icon: Icon(FontAwesomeIcons.chartLine), text: "Otros"),
              ],
            ),
            title: Text('Mis estadísticas'),
          ),
          body: TabBarView(
            children: [
              //my three views
              ChartPiePage(),
              SolidChartBarPage(),
              OtherStats(),
            ],
          ),
        ),
      ),
    );
  }
}

class OtherStats extends StatefulWidget {
  OtherStats({Key? key}) : super(key: key);

  @override
  _OtherStatsState createState() => _OtherStatsState();
}

class _OtherStatsState extends State<OtherStats> {
  late var lots = [];
  // late List lots;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> lots;
    final lotServices = new LotServices();
    return FutureBuilder(
      future: lotServices.getLotsByChart(globalData.getId()),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          lots = snapshot.data;
          if(lots.isNotEmpty){
            return Container(
              child: ListView.builder(
                itemCount: lots.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Text('${lots[index].name} : ${lots[index].money}');
                }
              )
            );
          } else{return Center(child: Text('No hay lote alguno'));}
        }
        else if (snapshot.hasError){
          return ListTile(title: Text('Ha habido un error'));
        }
        else {
          return Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
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
    final lotService = new LotServices();
    return Container(
       //to do something
       height: 550,
       child: SfCircularChart(
         tooltipBehavior: TooltipBehavior(
           enable: true
         ),
         title: ChartTitle(
          //  text: "Porcentaje de tus tiendas almacenadas"
          text: "Cantidad de lotes almacenados"
         ),
         legend: Legend(
           isVisible: true
         ),
         series: <PieSeries>[
           PieSeries<RoleQty, String>(
             dataSource: getStringData(),
             xValueMapper: (RoleQty qty,_)=>qty.x,
             yValueMapper: (RoleQty qty,_)=>qty.y,
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
           text: "Pedidos Acumulados Por Mes"
         ),
         primaryXAxis: NumericAxis(
           title: AxisTitle(
             text: "Mes"
           )
         ),
         primaryYAxis: NumericAxis(
           title: AxisTitle(
             text: "Pedidos"
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
             name: "Pedidos ABC",
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
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap
        ),
         title: ChartTitle(
           text: "Pedidos Acumulados Por Mes"
         ),
         primaryXAxis: NumericAxis(
           title: AxisTitle(
             text: "Mes"
           )
         ),
         primaryYAxis: NumericAxis(
           title: AxisTitle(
             text: "Pedidos"
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
             name: "Pedidos ABC",
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
class RoleQty{
  String x;
  int y;

  RoleQty(this.x, this.y);
}

final userService = new UserServices();
// future: lotService.getLotListByUser(globalData.getId())

//& the method
dynamic getStringData(){
  List<RoleQty> stringData=<RoleQty>[
    //here we return the qty trough role by user
    RoleQty("User", 24),
    RoleQty("Deliverer", 10),
    RoleQty("Company", 13)
  ];
  return stringData;
}