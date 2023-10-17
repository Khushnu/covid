
import 'package:covid/Services/states_status.dart';
import 'package:covid/Views/countries_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';


class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
 

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color> [
   const Color(0xff4285F4),
   const Color(0xff1aa260),
   const Color(0xffde5246),
  ];


  @override
  Widget build(BuildContext context) {
    StatesServices getData = StatesServices();
    return  Scaffold(
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(8.0), child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .00,),
          FutureBuilder(
            future: getData.getData(),
            builder: (context , snapshot){
            if(!snapshot.hasData){
              return Expanded(
                flex: 1,
                child: SpinKitFadingCircle(color: Colors.white, size: 50.0, controller: _controller,));
            } else {
              return Column(
                children: [
                  PieChart(dataMap:  {
            'Total' : double.parse(snapshot.data!.cases!.toString()),
            'Recovered' : double.parse(snapshot.data!.recovered.toString()),
            'Deaths' : double.parse(snapshot.data!.deaths.toString())
          },     
          chartType: ChartType.ring,
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: true
          ),
          colorList: colorList,
          chartRadius: MediaQuery.of(context).size.width / 4.2,
          legendOptions: const LegendOptions(
            legendPosition: LegendPosition.left
          ),),
           Padding(
             padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .08),
             child: Card
             (child: Column(
               children: [
                 ReuseableWidget(title: 'Total Cases' , value: snapshot.data!.cases!.toString(),),
                 ReuseableWidget(title: 'Death', value: snapshot.data!.deaths.toString()),
                 ReuseableWidget(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                 ReuseableWidget(title: 'Critical', value: snapshot.data!.critical.toString()),
                 ReuseableWidget(title: 'Afected Countries', value: snapshot.data!.affectedCountries.toString()),
               ],
             )),
           ),
           const SizedBox(height: 10,),
           GestureDetector(
            onTap:  () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountriesList())),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                height: 50,
                width: double.maxFinite,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green
                ),
                child: const Center(child:Text('Track Countries', style: TextStyle(fontSize: 20),)),
               ),
             ),
           )
                ],
              );
            }
          }),   
        ],
      ),),
    ));
  }
}

// ignore: must_be_immutable
class ReuseableWidget extends StatelessWidget {
  String title, value;
  ReuseableWidget({required this.title, required this.value,  super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        child: Column(
          children:  [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
            ),
            const SizedBox(height: 10,),
            const Divider()
          ],
        ),
      ),
    );
  }
}