
import 'package:covid/Services/states_status.dart';
import 'package:covid/Views/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final TextEditingController searchEditing = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices contry = StatesServices();
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    
                  });
                },
                controller: searchEditing,
                decoration:  InputDecoration(
                  suffixIcon:const Icon(Icons.search),
                  contentPadding: const EdgeInsets.all(12.4),
                  hintText: 'Search With Coutries names',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70)
                  )
                ),
              ),
            ),
            FutureBuilder(
              future: contry.getCountryData(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Shimmer.fromColors( 
                    baseColor: Colors.grey.shade700, 
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                          children: [
                            ListTile(
                              title: Container(height: 10, width: 89, color: Colors.white,),
                              subtitle: Container(height: 10, width: 89, color: Colors.white,),
                              leading: Container(height: 10, width: 50, color: Colors.white,),)
                          ],
                        ) ,);
                }else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        String name = snapshot.data![index]['country'].toString();
                        if(searchEditing.text.isEmpty){
                           return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScren(image: snapshot.data![index]['countryInfo']['flag'],
                               name: snapshot.data![index]['country'].toString(), 
                               totalcases: snapshot.data![index]['cases'], 
                               totalDeaths: snapshot.data![index]['deaths'], 
                               totalRecovered: snapshot.data![index]['recovered'], 
                               active: snapshot.data![index]['active'], 
                               critical: snapshot.data![index]['critical'], 
                               test: snapshot.data![index]['tests'], 
                               todayRecovered: snapshot.data![index]['todayRecovered'])));
                            },
                             child: Column(
                              children: [
                              ListTile(
                                title: Text(snapshot.data![index]['country'].toString()),
                                subtitle: Text("Total Cases : ${snapshot.data![index]['cases'].toString()}"),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),),
                                                     ],
                                                   ),
                           );
                        } else if(name.toLowerCase().contains(searchEditing.text.toLowerCase())){
                           return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScren(image: snapshot.data![index]['countryInfo']['flag'],
                               name: snapshot.data![index]['country'].toString(), 
                               totalcases: snapshot.data![index]['cases'], 
                               totalDeaths: snapshot.data![index]['deaths'], 
                               totalRecovered: snapshot.data![index]['recovered'], 
                               active: snapshot.data![index]['active'], 
                               critical: snapshot.data![index]['critical'], 
                               test: snapshot.data![index]['tests'], 
                               todayRecovered: snapshot.data![index]['todayRecovered'])));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country'].toString()),
                                subtitle: Text("Total Cases : ${snapshot.data![index]['cases'].toString()}"),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),),
                            ),
                          ],
                        );
                        }else {
                          return Container();
                        }

                        // return Column(
                        //   children: [
                        //     ListTile(
                        //       title: Text(snapshot.data![index]['country'].toString()),
                        //       subtitle: Text("Total Cases : ${snapshot.data![index]['cases'].toString()}"),
                        //       leading: Image(
                        //         height: 50,
                        //         width: 50,
                        //         image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),),
                        //   ],
                        // );
                    }),
                  );
                }
            })
          ],
        ),
      ),
    );
  }
}