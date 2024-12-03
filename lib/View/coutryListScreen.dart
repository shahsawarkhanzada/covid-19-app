import 'package:covid_19_app/View/countryDetailScreen.dart';
import 'package:covid_19_app/services/states_services.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(children: [
              TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search by country',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Expanded(
                  child: FutureBuilder(
                      future: statesServices.newcountriesList(),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade200,
                                  highlightColor: Colors.grey.shade300,
                                  child: Column(
                                    children: [
                                      Card(
                                        child: ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                          ),
                                          title: Container(
                                            height: 50,
                                            width: 100,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No countries available'));
                        } else if (snapshot.hasError) {
                          return Text('Error');
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                String name = snapshot.data![index]['country'];
                                if (searchController.text.isEmpty) {
                                  Column(
                                    children: [
                                      Card(
                                        color: Colors.blue[100],
                                        child: ListTile(
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(
                                                  snapshot.data![index]
                                                      ['countryInfo']['flag'])),
                                          title: Text(
                                              snapshot.data![index]['country']),
                                        ),
                                      )
                                    ],
                                  );
                                } else if (name.toLowerCase().contains(
                                    searchController.text.toLowerCase())) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      countryDetailScreen(
                                                        continent: snapshot
                                                                .data![index]
                                                            ['continent'],
                                                        name: snapshot
                                                                .data![index]
                                                            ['country'],
                                                        image: snapshot.data![
                                                                    index]
                                                                ['countryInfo']
                                                            ['flag'],
                                                        cases: snapshot
                                                                .data![index]
                                                            ['cases'],
                                                        recovered: snapshot
                                                                .data![index]
                                                            ['recovered'],
                                                        deaths: snapshot
                                                                .data![index]
                                                            ['deaths'],
                                                        critical: snapshot
                                                                .data![index]
                                                            ['critical'],
                                                        todayrecovered: snapshot
                                                                .data![index]
                                                            ['todayRecovered'],
                                                        todaycases: snapshot
                                                                .data![index]
                                                            ['todayCases'],
                                                        todaydeaths: snapshot
                                                                .data![index]
                                                            ['todayDeaths'],
                                                        totaltests: snapshot
                                                                .data![index]
                                                            ['tests'],
                                                        countrypopulation:
                                                            snapshot.data![
                                                                    index]
                                                                ['population'],
                                                        activecases: snapshot
                                                                .data![index]
                                                            ['active'],
                                                      )));
                                        },
                                        child: Card(
                                          color: Colors.blue[100],
                                          child: ListTile(
                                            leading: Image(
                                                height: 50,
                                                width: 50,
                                                image: NetworkImage(snapshot
                                                        .data![index]
                                                    ['countryInfo']['flag'])),
                                            title: Text(snapshot.data![index]
                                                ['country']),
                                            subtitle: Text(snapshot.data![index]
                                                ['continent']),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    countryDetailScreen(
                                                      continent:
                                                          snapshot.data![index]
                                                              ['continent'],
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      cases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      recovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      deaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                      todayrecovered: snapshot
                                                              .data![index]
                                                          ['todayRecovered'],
                                                      todaycases:
                                                          snapshot.data![index]
                                                              ['todayCases'],
                                                      todaydeaths:
                                                          snapshot.data![index]
                                                              ['todayDeaths'],
                                                      totaltests:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                      countrypopulation:
                                                          snapshot.data![index]
                                                              ['population'],
                                                      activecases:
                                                          snapshot.data![index]
                                                              ['active'],
                                                    )));
                                      },
                                      child: Card(
                                        color: Colors.blue[100],
                                        child: ListTile(
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(
                                                  snapshot.data![index]
                                                      ['countryInfo']['flag'])),
                                          title: Text(
                                              snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]
                                              ['continent']),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        }
                      }))
            ])));

    //     Scaffold(
    //   appBar: AppBar(),
    //   body: Padding(
    //     padding: const EdgeInsets.only(left: 15, right: 15),
    //     child: Column(
    //       children: [
    //         TextField(
    //           controller: searchController,
    //           decoration: const InputDecoration(
    //               prefixIcon: Icon(Icons.search),
    //               hintText: 'Search by country',
    //               // enabledBorder: OutlineInputBorder(),
    //               border: OutlineInputBorder()),
    //         ),
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height * .03,
    //         ),
    //         FutureBuilder(
    //             future: statesServices.countriesList(),
    //             builder: (context,
    //                 AsyncSnapshot<List<countries_data_model>> snapshot) {
    //               if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return Expanded(
    //                   child: SpinKitFadingCircle(
    //                     controller: animationController,
    //                     color: Colors.black,
    //                     size: 100,
    //                   ),
    //                 );
    //               } else if (snapshot.hasError) {
    //                 return Center(
    //                   child: Text(
    //                     "Error loading data: ${snapshot.error}",
    //                     style: const TextStyle(color: Colors.red),
    //                   ),
    //                 );
    //               } else {
    //                 return ListView.builder(
    //                   itemBuilder: (context, index) {
    //                     return ListTile(
    //                       leading: Image(
    //                           image: NetworkImage(snapshot
    //                               .data![index].countryInfo!.flag!
    //                               .toString())),
    //                     );
    //                   },
    //                 );
    //               }
    //             })
    //       ],
    //     ),
    //   ),
    // );
  }
}
