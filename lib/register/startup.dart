import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/about.dart';
import '../home.dart';
import '../setting/globalvariable.dart';

class StartUp extends StatefulWidget {
  const StartUp({super.key});

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AlertDialog(
                backgroundColor: colorProvider.backgroundlevel3,
                title: Text(
                  "Close the App ",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'englishrotated',
                      color: colorProvider.textcolor),
                ),
                content: Text("Are you sure ?",
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'englishrotated',
                        color: colorProvider.themelevel1)),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'englishrotated',
                            color: Color.fromARGB(255, 3, 138, 25))),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text("Yes",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'englishrotated',
                            color: Color.fromARGB(255, 214, 21, 7))),
                  ),
                ],
              ),
            );
          },
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Stack(
              children: [
                Container(
                  color: Color.fromARGB(141, 26, 26, 26),
                  height: screenHight,
                  width: screenWidth,
                  child: Image.asset(
                    "assets/images/background.gif",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: screenHight,
                width: screenWidth,
                color: Color.fromARGB(144, 51, 51, 51),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHight * 0.75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const Home(),
                                transitionsBuilder: (_, animation, __, child) {
                                  const begin =
                                      Offset(1.0, 0.0); // Slide from right
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end);
                                  final offsetAnimation =
                                      animation.drive(tween);
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                                transitionDuration: const Duration(
                                    seconds:
                                        1), // Set the duration to 2 seconds
                              ),
                            );
                          },
                          child: SizedBox(
                              height: screenHight * 0.08,
                              width: screenWidth * 0.25,
                              child: const Card(
                                  color: Color.fromARGB(255, 184, 0, 174),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side: BorderSide(
                                          color: Colors.black, width: 0.09)),
                                  child: Center(
                                    child: Text(
                                      "Start",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'englishrotated'),
                                    ),
                                  ))),
                        ),
                        //! end of first button
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const About(),
                                transitionsBuilder: (_, animation, __, child) {
                                  const begin =
                                      Offset(1.0, 0.0); // Slide from right
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end);
                                  final offsetAnimation =
                                      animation.drive(tween);
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          },
                          child: SizedBox(
                              height: screenHight * 0.08,
                              width: screenWidth * 0.25,
                              child: Card(
                                  color:
                                      const Color.fromARGB(82, 241, 241, 241),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      side: BorderSide(
                                          color: colorProvider.themelevel1,
                                          width: 0.01)),
                                  child: const Center(
                                    child: Text(
                                      "About",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'englishrotated'),
                                    ),
                                  ))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
