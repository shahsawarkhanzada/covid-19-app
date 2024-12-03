// ignore_for_file: file_names

import 'package:covid_19_app/View/coutryListScreen.dart';
import 'package:covid_19_app/compunents/compunents.dart';
import 'package:covid_19_app/models/world_state_model.dart';
import 'package:covid_19_app/services/states_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            FutureBuilder(
                future: statesServices.fetchWorldStates(),
                builder: (context, AsyncSnapshot<worldStateModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        controller: animationController,
                        color: Colors.black,
                        size: 100,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error loading data: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          animationDuration: const Duration(milliseconds: 1500),
                          chartType: ChartType.ring,
                          chartRadius: 130,
                          colorList: <Color>[
                            Color.fromARGB(255, 66, 113, 244),
                            Color.fromARGB(255, 222, 70, 70)
                          ],
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Card(
                            color: Colors.blue[100],
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: 'Cases',
                                    value: snapshot.data!.cases.toString()),
                                ReusableRow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                ReusableRow(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString()),
                                ReusableRow(
                                    title: 'Recoverd',
                                    value: snapshot.data!.recovered.toString()),
                                ReusableRow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                ReusableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                ReusableRow(
                                    title: 'Today Reported',
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                ReusableRow(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountryListScreen()));
                          },
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple[900],
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                                child: Text(
                              'Track Countries',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}
