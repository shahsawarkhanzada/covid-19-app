// ignore_for_file: camel_case_types, must_be_immutable

import 'package:covid_19_app/compunents/compunents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class countryDetailScreen extends StatefulWidget {
  String name, image, continent;
  int? cases,
      recovered,
      deaths,
      critical,
      todayrecovered,
      todaydeaths,
      todaycases,
      activecases,
      totaltests,
      countrypopulation;

  countryDetailScreen({
    super.key,
    required this.continent,
    required this.name,
    required this.image,
    this.cases,
    this.recovered,
    this.deaths,
    this.critical,
    this.todayrecovered,
    this.todaydeaths,
    this.todaycases,
    this.activecases,
    this.totaltests,
    this.countrypopulation,
  });

  @override
  State<countryDetailScreen> createState() => _countryDetailScreenState();
}

class _countryDetailScreenState extends State<countryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        centerTitle: true,
        title: Text(widget.name.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08),
                child: Card(
                  color: Colors.blue[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ReusableRow(
                          title: 'Continent',
                          value: widget.continent.toString()),
                      ReusableRow(
                          title: 'Population',
                          value: widget.countrypopulation.toString()),
                      ReusableRow(
                          title: 'Total Cases', value: widget.cases.toString()),
                      ReusableRow(
                          title: 'Total tests',
                          value: widget.totaltests.toString()),
                      ReusableRow(
                          title: 'Active Cases',
                          value: widget.activecases.toString()),
                      ReusableRow(
                          title: 'Total Recovered',
                          value: widget.recovered.toString()),
                      ReusableRow(
                          title: 'Total Deaths',
                          value: widget.deaths.toString()),
                      ReusableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(
                          title: 'Today Cases',
                          value: widget.todaycases.toString()),
                      ReusableRow(
                          title: 'Today Recovered',
                          value: widget.todayrecovered.toString()),
                      ReusableRow(
                          title: 'Today Deaths',
                          value: widget.todaydeaths.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.image.toString()),
              )
            ],
          )
        ],
      ),
    );
  }
}
