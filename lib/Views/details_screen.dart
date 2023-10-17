import 'package:flutter/material.dart';

class DetailsScren extends StatefulWidget {
  String image;
  String name;
  int totalcases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
  DetailsScren({super.key, required this.image, 
  required this.name,  required this.totalcases,
  required this.totalDeaths, required this.totalRecovered,
  required this.active, required this.critical,  
  required this.test, required this.todayRecovered});
  @override
  State<DetailsScren> createState() => _DetailsScrenState();
}
class _DetailsScrenState extends State<DetailsScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067,),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .06,),
                ReuseableWidget(title: 'Cases', value: widget.totalcases.toString()),
                ReuseableWidget(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                ReuseableWidget(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                ReuseableWidget(title: 'Critical', value: widget.critical.toString()),
                ReuseableWidget(title: 'Today Deaths', value: widget.totalDeaths.toString()),
                ReuseableWidget(title: 'Active', value: widget.active.toString()),
              ],
            ),),
            Positioned(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            )
          ],
         )
        ],
      ),
    );
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
            const SizedBox(height: 2,),
            const Divider()
          ],
        ),
      ),
    );
  }
}