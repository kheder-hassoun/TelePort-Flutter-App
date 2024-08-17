// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:process_run/cmd_run.dart';
import 'components/about.dart';
import 'components/drawer_containt.dart';
import 'components/setting.dart';
import 'mywidgets/CategoryIcon .dart';
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
  double capacity = 0.68;
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

    // Timer(const Duration(seconds: 2, milliseconds: 500), () {
    //   setState(() {
    //     heartheigth = 0;
    //     heartwidth = 0;
    //     myturns = 1;
    //   });
    // });
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
                          color: colorProvider.nextthemeiconcolor))
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
                    duration: Duration(seconds: 2),
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
                          SizedBox(
                            height: screenHight * 0.1,
                            width: screenWidth * 0.9,
                            child: Text(
                              ' Welcome in Teleporting \n'
                              ' with Kheder    👋 \n',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: colorProvider.textcolor,
                                  fontFamily: 'englishrotated',
                                  fontSize: 22),
                            ),
                          ),
                          SizedBox(
                            height: screenHight * 0.005,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.1,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  InkWell(
                                    onTap: refresh,
                                    child: Icon(
                                      Icons.update,
                                      color: colorProvider.textcolor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHight * 0.015,
                                  ),
                                  Icon(
                                    Icons.settings,
                                    color: colorProvider.textcolor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHight * 0.3,
                                width: screenWidth * 0.6,
                                child: CircularPercentIndicator(
                                  radius: 80.0,
                                  lineWidth: 20.0,
                                  animation: true,
                                  animationDuration: 1500,
                                  percent: capacity,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '   $capacity % ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'englishrotated',
                                            fontSize: 12.0,
                                            color: colorProvider.themelevel1),
                                      ),
                                      Text(
                                        ' Server ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'englishrotated',
                                            fontSize: 12.0,
                                            color: colorProvider.themelevel1),
                                      ),
                                      Text(
                                        '  capacity  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'englishrotated',
                                            fontSize: 12.0,
                                            color: colorProvider.themelevel1),
                                      ),
                                    ],
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: colorProvider.themelevel1,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: screenHight * 0.1,
                                    width: screenWidth * 0.2,
                                    child: Image.asset(
                                      "assets/images/lamp.gif",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHight * 0.08,
                            width: screenWidth * 0.9,
                            child: Text(
                              ' Main : \n',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: colorProvider.textcolor,
                                  fontFamily: 'englishrotated',
                                  fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: screenHight * 0.01,
                          ),
                          //? row of CategoryIcon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => Setting(),
                                      transitionsBuilder:
                                          (_, animation, __, child) {
                                        const begin = Offset(
                                            0.0, 1.0); // Slide from Bottom
                                        const end = Offset.zero;
                                        final tween =
                                            Tween(begin: begin, end: end);
                                        final offsetAnimation =
                                            animation.drive(tween);
                                        return SlideTransition(
                                            position: offsetAnimation,
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
                              CategoryIcon(
                                icon: Icons.security,
                                color: Colors.pink,
                                label: 'Security',
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => About(),
                                      transitionsBuilder:
                                          (_, animation, __, child) {
                                        const begin = Offset(
                                            0.0, 1.0); // Slide from Bottom
                                        const end = Offset.zero;
                                        final tween =
                                            Tween(begin: begin, end: end);
                                        final offsetAnimation =
                                            animation.drive(tween);
                                        return SlideTransition(
                                            position: offsetAnimation,
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
                          ),
                          //?end of CategoryIcon  row
                          SizedBox(
                            height: screenHight * 0.05,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            child: AnimatedContainer(
                              padding: EdgeInsets.all(16),
                              duration: Duration(seconds: 1),
                              width: screenWidth * 0.9,
                              color: colorProvider.backgroundlevel2,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        color:
                                            Color.fromARGB(255, 235, 213, 16),
                                      ),
                                      Text(
                                        " Warnings :",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 247, 2, 2),
                                            fontFamily: 'englishrotated',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: screenHight * 0.4,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          popit();
                                          runGoApp();
                                        },
                                        child: SizedBox(
                                          height: screenHight * 0.08,
                                          width: screenWidth * 0.3,
                                          child: Card(
                                            color:
                                                colorProvider.backgroundlevel1,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 252, 22, 183),
                                                    width: 1.2)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Get the url now",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'englishrotated',
                                                      color: colorProvider
                                                          .textcolor,
                                                      fontSize: 18),
                                                ),
                                                const Icon(
                                                  Icons.webhook_rounded,
                                                  color: Color.fromARGB(
                                                      221, 214, 0, 168),
                                                )
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: SelectableText(
                                            output,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: colorProvider.textcolor,
                                              fontFamily: 'englishrotated',
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
                    duration: const Duration(seconds: 1),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         popit();
                      //       },
                      //       child: ClipRRect(
                      //         borderRadius:
                      //             const BorderRadius.all(Radius.circular(30)),
                      //         child: SizedBox(
                      //             height: screenHight * 0.15,
                      //             width: screenHight * 0.15,
                      //             child: Image.asset(
                      //               "assets/images/assester.png",
                      //               fit: BoxFit.cover,
                      //             )),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: screenWidth * 0.051,
                      //     ),
                      //   ],
                      // )
                    ],
                  )
                ],
              )),
        ));
  }

  String output = "Url will appear here please  click the button above ";

  Future<void> runGoApp() async {
    try {
      // If you need to extract the executable from assets (assuming it’s not directly accessible)
      final filePath = "assets/teleportclient.exe";
      final byteData = await rootBundle.load('assets/teleportclient.exe');
      final buffer = byteData.buffer.asUint8List();
      final file = File(filePath);
      await file.writeAsBytes(buffer);

      // Define the parameters for your Go application
      var result = await runExecutableArguments(
        filePath, // Use the extracted executable path
        [
          '-p',
          '9999',
          '-h',
          'teleport.me',
          '-username',
          'test1',
          '-password',
          '123456',
          '-sharedport',
          '8000'
        ],
        workingDirectory: Directory.current.path,
      );

      // Update the output and errors to be displayed in a Text widget
      setState(() {
        output = 'stdout: ${result.stdout}\nstderr: ${result.stderr}';
        heartheigth = 0;
        heartwidth = 0;
        myturns = 1;
      });
    } catch (e) {
      setState(() {
        output = 'Error: $e';
        heartheigth = 0;
        heartwidth = 0;
        myturns = 1;
      });
    }
  }

  // Future<void> runGoApp() async {
  //   try {
  //     // Define the parameters for your Go application
  //     var result = await runExecutableArguments(
  //       "assets/teleportclient.exe",
  //       [
  //         '-p',
  //         '9999',
  //         '-h',
  //         'teleport.me',
  //         '-username',
  //         'test1',
  //         '-password',
  //         '123456',
  //         '-sharedport',
  //         '8000'
  //       ],
  //       workingDirectory: Directory.current.path,
  //       // Optional: you can redirect stdout and stderr
  //     );

  //     // Print the output and errors
  //     print('stdout: ${result.stdout}');
  //     print('stderr: ${result.stderr}');
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
}
