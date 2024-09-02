// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../setting/globalvariable.dart';
import 'drawer_containt.dart';

class UserStatisticsPage extends StatefulWidget {
  @override
  _UserStatisticsPageState createState() => _UserStatisticsPageState();
}

class _UserStatisticsPageState extends State<UserStatisticsPage> {
  List<dynamic> details = [];
  int selectedTableIndex = 0;
  String userName = "user";

  @override
  void initState() {
    super.initState();
    myinit();
    fetchDetails();
  }

  Future<void> myinit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userNameT = prefs.getString("userName");

    userNameT ??= "user";

    userName = userNameT;
  }

  Future<void> fetchDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://localhost:9090/api/user-details/getall'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          details = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to fetch details'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      drawer: DrawerContaint(),
      appBar: AppBar(
        toolbarHeight: 54, //? defult is 56
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(3),
        //   ),
        // ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ColorProvider>(context, listen: false)
                    .changetheme();
              },
              icon: Icon(colorProvider.nextthemeicon,
                  color: colorProvider.nextthemeiconcolor)),
          SizedBox(
            width: screenWidth * 0.051,
          ),
          Icon(Icons.person),
          SizedBox(
            width: screenWidth * 0.021,
          ),
          Center(
            child: Text(
              userName,
              style: TextStyle(color: colorProvider.textcolor, fontSize: 25),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.051,
          ),
        ],
        backgroundColor: colorProvider.themelevel1,
        foregroundColor: Colors.black,
        elevation: 8,
        shadowColor: colorProvider.backgroundlevel3,
        title: Text(
          "Teleport.me",
        ),
      ),
      body: details.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  _buildSummaryTable(screenWidth, screenHeight, colorProvider),
                  SizedBox(height: screenHeight * 0.04),
                  Container(
                    width: screenWidth * 0.99,
                    height: screenHeight * 0.08,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 233, 233, 233),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // Button color
                          ),
                          onPressed: () {
                            setState(() {
                              selectedTableIndex = 0;
                            });
                          },
                          child: Text('Statics 1'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Button color
                          ),
                          onPressed: () {
                            setState(() {
                              selectedTableIndex = 1;
                            });
                          },
                          child: Text('Statics 2'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // Button color
                          ),
                          onPressed: () {
                            setState(() {
                              selectedTableIndex = 2;
                            });
                          },
                          child: Text('Statics 3'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Expanded(
                    child: selectedTableIndex == 0
                        ? _buildTable1(screenWidth, screenHeight)
                        : selectedTableIndex == 1
                            ? _buildTable2(screenWidth, screenHeight)
                            : _buildTable3(screenWidth, screenHeight),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryTable(
      double screenWidth, double screenHeight, ColorProvider colorProvider) {
    int totalUsers = details.length;
    int windowsUsers =
        details.where((detail) => detail['kernelName'] == 'Windows').length;
    int linuxUsers =
        details.where((detail) => detail['kernelName'] == 'Linux').length;
    int macUsers =
        details.where((detail) => detail['kernelName'] == 'Mac').length;

    double maxRamUtilization = details.map((detail) {
      return double.parse(detail['appRAMUtilization']);
    }).reduce((a, b) => a > b ? a : b);

    return Container(
      width: screenWidth * 0.99,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 233, 233),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: screenHeight * 0.05,
                child: Text(
                  'Welcome ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: colorProvider.textcolor,
                      // fontFamily: 'englishrotated',
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
                child: Text(
                  ' TelePort.me ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: colorProvider.themelevel1,
                      fontFamily: 'englishrotated',
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
                child: Text(
                  'Admin ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromARGB(255, 252, 3, 177),
                      //fontFamily: 'englishrotated',
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
                child: Text(
                  ' developer app',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: colorProvider.textcolor,
                      // fontFamily: 'englishrotated',
                      fontSize: 25),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Users: $totalUsers"),
              Text("Windows Users: $windowsUsers"),
              Text("Linux Users: $linuxUsers"),
              Text("Mac Users: $macUsers"),
              Text(
                  "Max RAM Utilization: ${maxRamUtilization.toStringAsFixed(2)}%"),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }

  Widget _buildTable1(double screenWidth, double screenHeight) {
    return _buildDataTable(
      screenWidth,
      screenHeight,
      ['User Name', 'Login Time', 'Kernel Architecture'],
      details.map((detail) {
        return DataRow(
          cells: [
            DataCell(Text(detail['userName'])),
            DataCell(Text(detail['loginTime'])),
            DataCell(Text(detail['kernelArchitecture'])),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTable2(double screenWidth, double screenHeight) {
    return _buildDataTable(
      screenWidth,
      screenHeight,
      ['User Name', 'Kernel Bitness', 'Kernel Name', 'Kernel Version'],
      details.map((detail) {
        return DataRow(
          cells: [
            DataCell(Text(detail['userName'])),
            DataCell(Text(detail['kernelBitness'])),
            DataCell(Text(detail['kernelName'])),
            DataCell(Text(detail['kernelVersion'])),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTable3(double screenWidth, double screenHeight) {
    return _buildDataTable(
      screenWidth,
      screenHeight,
      [
        'User Name',
        'OS Name',
        'OS Version',
        'RAM Utilization',
        'User Space Bitness'
      ],
      details.map((detail) {
        return DataRow(
          cells: [
            DataCell(Text(detail['userName'])),
            DataCell(Text(detail['operatingSystemName'])),
            DataCell(Text(detail['operatingSystemVersion'])),
            DataCell(Text(detail['appRAMUtilization'])),
            DataCell(Text(detail['userSpaceBitness'])),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildDataTable(
    double screenWidth,
    double screenHeight,
    List<String> columnTitles,
    List<DataRow> rows,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: screenWidth * 0.9,
        child: DataTable(
          columns: columnTitles
              .map((title) => DataColumn(label: Text(title)))
              .toList(),
          rows: rows,
          dataRowColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.blue.withOpacity(0.2); // Row color on selection
            }
            return null; // Use default row color
          }),
          headingRowColor:
              MaterialStateProperty.all(Colors.blue[100]), // Heading row color
          columnSpacing: 12.0, // Spacing between columns
          horizontalMargin: 10.0, // Margin on both sides of the table
          showCheckboxColumn: false, // Remove the checkbox column
        ),
      ),
    );
  }
}
