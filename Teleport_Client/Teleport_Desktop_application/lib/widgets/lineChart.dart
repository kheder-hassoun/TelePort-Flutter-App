// ignore_for_file: prefer_const_constructors

import 'package:amazing_001/setting/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:provider/provider.dart';

class ChartData {
  final DateTime time;
  final int numberOfEndUsers;

  ChartData({required this.time, required this.numberOfEndUsers});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      time: DateTime.parse(json['time']),
      numberOfEndUsers: json['numberOfEndUsers'],
    );
  }
}

class LineChartExample extends StatelessWidget {
  final List<dynamic> details;

  LineChartExample({required this.details});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    List<ChartData> data =
        details.map((item) => ChartData.fromJson(item)).toList();

    List<FlSpot> spots = data
        .asMap()
        .entries
        .map((e) =>
            FlSpot((e.key + 1).toDouble(), e.value.numberOfEndUsers.toDouble()))
        .toList();

    return Scaffold(
      // appBar: AppBar(title: Text('FL Chart Example')),
      body: Container(
        color: colorProvider.backgroundlevel2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Users change over time",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorProvider.themelevel1,
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: screenHight * 0.4, // Specify the height you need
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          colors: [Colors.blue],
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            colors: [
                              Color.fromARGB(255, 41, 217, 248).withOpacity(0.3)
                            ],
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (context, value) => TextStyle(
                            color: colorProvider.textcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          margin: 8,
                        ),
                        rightTitles: SideTitles(showTitles: false),
                        topTitles: SideTitles(showTitles: false),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (context, value) => TextStyle(
                            color: colorProvider.textcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          margin: 8,
                        ),
                      ),
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: colorProvider.textcolor.withOpacity(0.5),
                          )),
                      gridData: FlGridData(
                        show: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: colorProvider.themelevel1,
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.white.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "X-Axis Label",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Y-Axis Label",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
