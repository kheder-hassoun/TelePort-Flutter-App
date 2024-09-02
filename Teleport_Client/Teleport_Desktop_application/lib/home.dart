// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:system_info2/system_info2.dart';
import 'package:http/http.dart' as http;
import 'components/about.dart';
import 'components/drawer_containt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/history.dart';
import 'setting/setting.dart';
import 'widgets/CategoryIcon .dart';
import 'setting/globalvariable.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String hometitle = "Home";
  double heartwidth = 0;
  double myturns = 0;
  double heartheigth = 0;
  double capacity = 0.0; // Initial CPU usage
  String userName = "user";
  String subscriptionType = "free";
  @override
  void initState() {
    super.initState();
    myinit();
    Timer.periodic(Duration(seconds: 4), (Timer t) => _getRamUsage());
    // Send user details
  }

  Future<void> myinit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? subscriptionTypeT = prefs.getString("subscriptionType");
    String? userNameT = prefs.getString("userName");
    String? token = prefs.getString("token");
    String? role = prefs.getString("role");
    subscriptionTypeT ??= "free";
    userNameT ??= "user";
    token ??= "***";
    role ??= "USER";
    subscriptionType = subscriptionTypeT;
    userName = userNameT;
    await sendUserDetails(token, userName);
  }
//********************************** */

  // Function to calculate app RAM utilization
  Future<String> getAppRAMUtilization() async {
    int initialMemory = SysInfo.getTotalPhysicalMemory();

    await Future.delayed(Duration(minutes: 1));

    int finalMemory = SysInfo.getTotalPhysicalMemory();

    int memoryUsed = initialMemory - finalMemory;
    int memoryUsedWithMargin =
        (memoryUsed ~/ (1024 * 1024)) + 42; // Convert bytes to MB and add 30 MB

    return memoryUsedWithMargin.toString();
  }

  // Function to send user details
  Future<void> sendUserDetails(String token, String username) async {
    String loginTime = DateTime.now().toIso8601String();

    String kernelArchitecture =
        SysInfo.rawKernelArchitecture; //SysInfo.kernelArchitecture as String;

    int kernelBitness = SysInfo.kernelBitness;

    String kernelName = SysInfo.kernelName;
    String kernelVersion = SysInfo.kernelVersion;
    String operatingSystemName = SysInfo.operatingSystemName;
    String operatingSystemVersion = SysInfo.operatingSystemVersion;
    String appRAMUtilization = await getAppRAMUtilization();
    int userSpaceBitness = SysInfo.userSpaceBitness;
    print(kernelName);
    var userDetails = {
      'userName': username,
      'loginTime': loginTime,
      'kernelArchitecture': kernelArchitecture,
      'kernelBitness': kernelBitness.toString(),
      'kernelName': kernelName,
      'kernelVersion': kernelVersion,
      'operatingSystemName': operatingSystemName,
      'operatingSystemVersion': operatingSystemVersion,
      'appRAMUtilization': appRAMUtilization,
      'userSpaceBitness': userSpaceBitness.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse('http://localhost:9090/api/user-details/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the token
        },
        body: jsonEncode(userDetails),
      );

      if (response.statusCode == 200) {
        print('User details sent successfully');
      } else {
        print('Failed to send user details: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred while sending user details: $error');
    }
  }

//***************************************** */
  void _getRamUsage() {
    double usage = _fetchRamUsage();
    setState(() {
      capacity = usage;
    });
  }

  double _fetchRamUsage() {
    int totalMemory = SysInfo.getTotalPhysicalMemory(); // In bytes
    int freeMemory = SysInfo.getFreePhysicalMemory(); // In bytes

    int usedMemory = totalMemory - freeMemory;
    double usagePercentage = (usedMemory / totalMemory) * 100;

    return usagePercentage;
  }

  void refresh() {
    setState(() {
      Random random = Random();
      // Generate a random number between 0.0 and 1.0
      double randomNumber = random.nextDouble();
      String roundedString = randomNumber.toStringAsFixed(2);
      double rounded = double.parse(roundedString);
      capacity = rounded;
    });
  }

  void popit() {
    setState(() {
      heartheigth = 300;
      heartwidth = 300;
      myturns = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AlertDialog(
                  backgroundColor: Color.fromARGB(164, 216, 215, 215),
                  title: Text(
                    "Close the App ??",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'englishrotated',
                        color: const Color.fromARGB(255, 185, 14, 1)),
                  ),
                  content: Text("See You Later ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'englishrotated',
                          color: Colors.black)),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'englishrotated',
                              color: Color.fromARGB(255, 2, 95, 18))),
                    ),
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text("Yes",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'englishrotated',
                              color: Color.fromARGB(255, 153, 12, 2))),
                    ),
                  ],
                ),
              );
            },
          );
          return false;
        },
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
              backgroundColor: colorProvider.backgroundlevel1,
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
                      style: TextStyle(
                          color: colorProvider.textcolor, fontSize: 25),
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
                  hometitle,
                ),
              ),
              // bottomNavigationBar: CurvedNavigationBar(
              //     color: colorProvider.themelevel1trans,
              //     buttonBackgroundColor: colorProvider.themelevel1trans,
              //     backgroundColor: colorProvider.backgroundlevel1,
              //     height: 65,
              //     onTap: (index) {
              //       setState(() {
              //         if (index == 0) {
              //           hometitle = "Home";
              //           refresh();
              //         } else if (index == 1) {
              //           hometitle = "Tab 2";
              //           refresh();
              //         } else if (index == 2) {
              //           hometitle = "Tab 3";
              //           refresh();
              //         }
              //       });
              //     },
              //     items: const [
              //       CurvedNavigationBarItem(
              //           child: Icon(Icons.home_outlined),
              //           label: 'Home',
              //           labelStyle: TextStyle(
              //             fontSize: 14,
              //             fontFamily: 'englishrotated',
              //           )),
              //       CurvedNavigationBarItem(
              //           child: Icon(Icons.favorite),
              //           label: 'Tab 2',
              //           labelStyle: TextStyle(
              //             fontSize: 14,
              //             fontFamily: 'englishrotated',
              //           )),
              //       CurvedNavigationBarItem(
              //           child: Icon(Icons.person_2_outlined),
              //           label: 'About',
              //           labelStyle: TextStyle(
              //             fontSize: 14,
              //             fontFamily: 'englishrotated',
              //           )),
              //     ]),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    height: screenHight,
                    width: screenWidth,
                    color: colorProvider.backgroundlevel1,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //! here is the body
                          SizedBox(
                            height: screenHight * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.9,
                                height: screenHight * 0.1,
                                child: Card(
                                    color: colorProvider.backgroundlevel2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        side: BorderSide(
                                            color:
                                                colorProvider.backgroundlevel2,
                                            width: 0.2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: screenHight * 0.05,
                                            child: Text(
                                              ' Welcome to ',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color:
                                                      colorProvider.textcolor,
                                                  // fontFamily: 'englishrotated',
                                                  fontSize: 25),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHight * 0.05,
                                            child: Text(
                                              ' TelePort.me ',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color:
                                                      colorProvider.themelevel1,
                                                  fontFamily: 'englishrotated',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 28),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHight * 0.05,
                                            child: Text(
                                              ' developer app',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color:
                                                      colorProvider.textcolor,
                                                  // fontFamily: 'englishrotated',
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHight * 0.005,
                          ),
                          SizedBox(
                            width: screenWidth * 0.9,
                            child: Card(
                                color: colorProvider.backgroundlevel2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    side: BorderSide(
                                        color: colorProvider.themelevel1,
                                        width: 0.2)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, top: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.05,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: screenHight * 0.2,
                                                width: screenWidth * 0.15,
                                                child: Image.asset(
                                                  "assets/images/plan.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Text(
                                                'your plane :',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color:
                                                        colorProvider.textcolor,
                                                    fontFamily:
                                                        'englishrotated',
                                                    fontSize: 25),
                                              ),
                                              Text(
                                                '$subscriptionType',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: colorProvider
                                                        .themelevel1,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: screenHight * 0.28,
                                            width: screenWidth * 0.45,
                                            child: Column(
                                              children: [
                                                CircularPercentIndicator(
                                                  radius: 56.0,
                                                  lineWidth: 15.0,
                                                  animation: true,
                                                  animationDuration: 1500,
                                                  percent: capacity /
                                                      100, // Normalize to 0-1 range
                                                  center: Text(
                                                    '   ${capacity.toStringAsFixed(1)} % ',
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: colorProvider
                                                            .themelevel1),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor:
                                                      colorProvider.themelevel1,
                                                ),
                                                SizedBox(
                                                  height: screenHight * 0.05,
                                                ),
                                                Text(
                                                  'teleport app RAM usage',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: colorProvider
                                                          .textcolor,
                                                      fontFamily:
                                                          'englishrotated',
                                                      fontSize: 25),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: screenHight * 0.2,
                                                width: screenWidth * 0.15,
                                                child: Image.asset(
                                                  "assets/images/laptop.gif",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Text(
                                                'always ready',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color:
                                                        colorProvider.textcolor,
                                                    fontFamily:
                                                        'englishrotated',
                                                    fontSize: 25),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: screenHight * 0.02,
                                      ),
                                      //? row of CategoryIcon
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      Setting(),
                                                  transitionsBuilder: (_,
                                                      animation, __, child) {
                                                    const begin = Offset(0.0,
                                                        1.0); // Slide from Bottom
                                                    const end = Offset.zero;
                                                    final tween = Tween(
                                                        begin: begin, end: end);
                                                    final offsetAnimation =
                                                        animation.drive(tween);
                                                    return SlideTransition(
                                                        position:
                                                            offsetAnimation,
                                                        child: child);
                                                  },
                                                  transitionDuration: Duration(
                                                      seconds:
                                                          1), // Set the duration to 2 seconds
                                                ),
                                              );
                                            },
                                            child: CategoryIcon(
                                              icon: Icons.settings,
                                              color: Colors.green,
                                              label: 'Setting',
                                            ),
                                          ),
                                          CategoryIcon(
                                            icon: Icons.help,
                                            color: Colors.blue,
                                            label: 'Help',
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      History(),
                                                  transitionsBuilder: (_,
                                                      animation, __, child) {
                                                    const begin = Offset(0.0,
                                                        1.0); // Slide from Bottom
                                                    const end = Offset.zero;
                                                    final tween = Tween(
                                                        begin: begin, end: end);
                                                    final offsetAnimation =
                                                        animation.drive(tween);
                                                    return SlideTransition(
                                                        position:
                                                            offsetAnimation,
                                                        child: child);
                                                  },
                                                  transitionDuration: Duration(
                                                      seconds:
                                                          1), // Set the duration to 2 seconds
                                                ),
                                              );
                                            },
                                            child: CategoryIcon(
                                              icon: Icons.history,
                                              color: Colors.pink,
                                              label: 'History',
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      About(),
                                                  transitionsBuilder: (_,
                                                      animation, __, child) {
                                                    const begin = Offset(0.0,
                                                        1.0); // Slide from Bottom
                                                    const end = Offset.zero;
                                                    final tween = Tween(
                                                        begin: begin, end: end);
                                                    final offsetAnimation =
                                                        animation.drive(tween);
                                                    return SlideTransition(
                                                        position:
                                                            offsetAnimation,
                                                        child: child);
                                                  },
                                                  transitionDuration: Duration(
                                                      seconds:
                                                          1), // Set the duration to 2 seconds
                                                ),
                                              );
                                            },
                                            child: CategoryIcon(
                                              icon: Icons.person,
                                              color: Colors.orange,
                                              label: 'About',
                                            ),
                                          ),
                                        ],
                                      ), //?end of CategoryIcon  row
                                      SizedBox(
                                        height: screenHight * 0.04,
                                      )
                                    ],
                                  ),
                                )),
                          ),

                          SizedBox(
                            height: screenHight * 0.02,
                          ),
                          SizedBox(
                            width: screenWidth * 0.9,
                            child: Card(
                              color: colorProvider.backgroundlevel2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  side: BorderSide(
                                      color: colorProvider.themelevel1,
                                      width: 0.2)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: screenHight * 0.06,
                                          width: screenWidth * 0.05,
                                          child: Image.asset(
                                            "assets/images/web.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Text(
                                          "Your Website ( port ",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 247, 2, 2),
                                              fontFamily: 'englishrotated',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26),
                                        ),
                                        Text(
                                          "$_port",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 9, 241, 1),
                                              //fontFamily: 'englishrotated',
                                              fontSize: 20),
                                        ),
                                        Text(
                                          " ) :",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 247, 2, 2),
                                              fontFamily: 'englishrotated',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26),
                                        ),
                                        SizedBox(
                                          width: screenHight * 0.12,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _showPortDialog();
                                          },
                                          child: SizedBox(
                                            height: screenHight * 0.08,
                                            width: screenWidth * 0.2,
                                            child: Card(
                                              color: colorProvider
                                                  .backgroundlevel1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  side: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 139, 224, 245),
                                                      width: 0.6)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "shared port",
                                                    style: TextStyle(
                                                        // fontFamily:
                                                        color: colorProvider
                                                            .textcolor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: screenHight * 0.06,
                                                    width: screenWidth * 0.05,
                                                    child: Image.asset(
                                                      "assets/images/port.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        InkWell(
                                          onTap: () {
                                            popit();
                                            runGoApp();
                                          },
                                          child: SizedBox(
                                            height: screenHight * 0.08,
                                            width: screenWidth * 0.2,
                                            child: Card(
                                              color: colorProvider
                                                  .backgroundlevel1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  side: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 139, 224, 245),
                                                      width: 0.6)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Generat url",
                                                    style: TextStyle(
                                                        // fontFamily:
                                                        //     'englishrotated',
                                                        color: colorProvider
                                                            .textcolor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: screenHight * 0.06,
                                                    width: screenWidth * 0.05,
                                                    child: Image.asset(
                                                      "assets/images/web2.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHight * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            splashRadius: 18,
                                            splashColor: Color.fromARGB(
                                                255, 11, 239, 255),
                                            hoverColor: Color.fromARGB(
                                                75, 11, 239, 255),
                                            color: Color.fromARGB(
                                                255, 28, 31, 212),
                                            onPressed: () =>
                                                copyToClipboard(output),
                                            icon: Icon(Icons.copy)),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: SelectableText(
                                              output,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: outputcolor,
                                                // fontFamily: 'englishrotated',
                                                fontSize: 19,
                                              ),
                                              // softWrap is true by default
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHight * 0.02,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHight * 0.1,
                          ),

                          SizedBox(
                            height: screenHight * 0.3,
                          ),
                          //!end of body stack level one
                        ],
                      ),
                    ),
                  ),
                  //! stack level Two
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 1),
                    turns: myturns,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: heartwidth,
                      height: heartheigth,
                      child: Image.asset("assets/images/loading.gif"),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: screenHight * 0.2,
                      ),
                    ],
                  )
                ],
              )),
        ));
  }

//

  int _port = 8000; // Default port value

  Future<void> _showPortDialog() async {
    final TextEditingController _portController = TextEditingController();
    _portController.text =
        _port.toString(); // Pre-fill the dialog with the default value

    final result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Port Number'),
          content: TextField(
            controller: _portController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Port Number',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without any action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('defult port is 8000 '),
                    backgroundColor: Color.fromARGB(137, 11, 227, 255),
                  ),
                ); //
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final enteredPort = int.tryParse(_portController.text);
                if (enteredPort != null &&
                    ((enteredPort >= 1024 && enteredPort <= 49151) ||
                        (enteredPort >= 49152 && enteredPort <= 65535))) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('port selected succesfully '),
                      backgroundColor: Color.fromARGB(197, 0, 197, 59),
                    ),
                  ); // If
                  Navigator.of(context)
                      .pop(enteredPort); // Return the entered port
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('invalied port  '),
                      backgroundColor: Color.fromARGB(138, 255, 11, 11),
                    ),
                  ); // If
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _port = result; // Update the port variable with the entered value
      });
    }
  }

//

  String output = "Url will appear here, please click Generat URL ";
  Color outputcolor = Color.fromARGB(255, 202, 0, 125);
  Future<void> runGoApp() async {
    try {
      // Define the path where the executable will be stored
      final filePath = "${Directory.systemTemp.path}/teleportclient.exe";

      // Load the executable from assets
      final byteData = await rootBundle.load('assets/teleportclient.exe');
      final buffer = byteData.buffer.asUint8List();
      final file = File(filePath);
      await file.writeAsBytes(buffer);
      String? userName = "test1";
      String? password = "123456";
      Future<void> checkCredentials() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        // Retrieve userName and password from SharedPreferences
        userName = prefs.getString('userName');
        password = prefs.getString('password');

        // Check if userName and password exist
        if (userName == null || password == null) {
          // If they don't exist, assign default values
          userName = "test1";
          password = "123456";
        }

        // Use the values
        print('Username: $userName, Password: $password');
      }

      // Start the process using Process.start()
      Process process = await Process.start(
        filePath,
        [
          '-p',
          '9999',
          '-h',
          'teleport.me',
          '-username',
          '$userName',
          '-password',
          '$password',
          '-sharedport',
          '$_port'
        ],
        runInShell: true, // Ensures the process is run in a shell environment
      );

      // Listen to stdout and update the output in real-time
      process.stdout.transform(utf8.decoder).listen((data) {
        setState(() {
          output = findPattern(data);
          outputcolor = Color.fromARGB(255, 255, 27, 225);
          heartheigth = 0;
          heartwidth = 0;
          myturns = 1;
        });
      });

      // Listen to stderr and update the output in real-time
      process.stderr.transform(utf8.decoder).listen((data) {
        setState(() {
          output = 'Error: $data';
          outputcolor = Color.fromARGB(255, 192, 0, 0);
          heartheigth = 0;
          heartwidth = 0;
          myturns = 1;
        });
      });

      // Wait for the process to finish
      await process.exitCode;
    } catch (e) {
      setState(() {
        output = 'Error: $e';
        outputcolor = Color.fromARGB(255, 226, 110, 0);
        heartheigth = 0;
        heartwidth = 0;
        myturns = 1;
      });
    }
  }

  // Function to copy text to clipboard
  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard!'),
        backgroundColor: Color.fromARGB(139, 11, 239, 255),
      ),
    );
  }

  String findPattern(String input) {
    // Define the regular expression pattern to match the full URL pattern with "http" or "https" followed by "://", domain name, and ":9999"
    RegExp regex = RegExp(r'http[s]?:\/\/[^\s]+:9999');

    // Search for the pattern in the input string
    Match? match = regex.firstMatch(input);

    // If a match is found, return the matched string, otherwise return the entire input
    if (match != null) {
      return match.group(0)!; // Return the matched string
    } else {
      return input; // Return the entire input if no match is found
    }
  }
}
