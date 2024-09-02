import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../setting/globalvariable.dart';
import '../widgets/lineChart.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String appcounter = "0";
  String hadeelcounter = "0";
  String birthdaycounter = "0";
  Future<void> help() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
    help();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorProvider.themelevel1,
        foregroundColor: Colors.black,
        elevation: 8,
        shadowColor: colorProvider.backgroundlevel3,
        title: const Text('My URLs History '),
      ),
      body: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        padding: EdgeInsets.only(
            left: screenWidth * 0.02, right: screenWidth * 0.02),
        height: screenHight,
        width: screenWidth,
        color: colorProvider.backgroundlevel1,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: screenHight * 0.02,
            ),
            SizedBox(
              height: screenHight * 0.1,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                  width: screenWidth * 0.98,
                  height: screenHight * 0.53,
                  child: LineChartExample(details: details)),
            ),
            SizedBox(
              height: screenHight * 0.1,
            ),
            SizedBox(
                width: screenWidth * 0.98,
                child: Card(
                  color: colorProvider.backgroundlevel2,
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(
                          color: colorProvider.themelevel1, width: 0.2)),
                  child: details.isEmpty
                      ? Center(
                          child: Text(
                            'No URLs yet ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: colorProvider.textcolor,
                                fontFamily: 'englishrotated',
                                fontSize: 25),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('URL')),
                              DataColumn(label: Text('Time')),
                              DataColumn(label: Text('Number of End Users')),
                            ],
                            rows: details.map((detail) {
                              return DataRow(cells: [
                                DataCell(Text(detail['url'])),
                                DataCell(Text(detail['time'])),
                                DataCell(Text(
                                    detail['numberOfEndUsers'].toString())),
                              ]);
                            }).toList(),
                          ),
                        ),
                )),
            SizedBox(
              height: screenHight * 0.3,
            ),
          ]),
        ),
      ),
    );
  }

  List<dynamic> details = [];
  Future<void> fetchDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://localhost:9090/api/details/details'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          details = json.decode(response.body);
        });
      } else {
        // Handle errors here
      }
    }
  }
}
