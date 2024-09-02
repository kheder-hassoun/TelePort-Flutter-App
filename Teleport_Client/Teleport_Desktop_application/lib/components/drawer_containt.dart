import 'dart:isolate';

import 'package:amazing_001/register/startup.dart';
import 'package:amazing_001/setting/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerContaint extends StatefulWidget {
  const DrawerContaint({super.key});

  @override
  State<DrawerContaint> createState() => _DrawerContaintState();
}

class _DrawerContaintState extends State<DrawerContaint> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      width: screenWidth * 0.7,
      color: colorProvider.backgroundlevel1,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: screenHight * 0.35,
          width: screenWidth * 0.8,
          color: colorProvider.themelevel1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHight * 0.05,
              ),
              Text(
                " Telport.me  👋 \n"
                '',
                style: TextStyle(
                    color: colorProvider.backgroundlevel1,
                    fontFamily: 'englishrotated',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const StartUp(),
                      transitionsBuilder: (_, animation, __, child) {
                        const begin = Offset(1.0, 0.0); // Slide from right
                        const end = Offset.zero;
                        final tween = Tween(begin: begin, end: end);
                        final offsetAnimation = animation.drive(tween);
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
                        color: Color.fromARGB(188, 199, 199, 199),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                color: colorProvider.themelevel1, width: 0.01)),
                        child: const Center(
                          child: Text(
                            "Log out",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'englishrotated'),
                          ),
                        ))),
              ),
            ],
          ),
        ),
        Stack(alignment: Alignment.topCenter, children: [
          Container(
            color: Color.fromARGB(199, 0, 0, 0),
            height: screenHight * 0.65,
            width: screenHight * 0.8,
            child: Image.asset(
              "assets/images/background.gif",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHight * 0.15,
              ),
            ],
          )
        ]),
      ]),
    );
  }
}
