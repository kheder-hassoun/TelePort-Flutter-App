import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../setting/globalvariable.dart';

class About extends StatelessWidget {
  const About({super.key});

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
        title: const Text('About '),
      ),
      body: Container(
        color: colorProvider.backgroundlevel1,
        padding: EdgeInsets.only(
            left: screenWidth * 0.02, right: screenWidth * 0.02),
        height: screenHight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHight * 0.05,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorProvider.themelevel1,
                      colorProvider.backgroundlevel1
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHight * 0.05,
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        ' language   : Dart \n'
                        'frame work  : Flutter \n '
                        'version     : 1.0.0   \n'
                        'start date  : 26/6/2024 \n'
                        'end date    : **/**/2024 ❤ \n '
                        '\nproject app 🥰\n'
                        '\nkheder ...',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: colorProvider.textcolor,
                            fontFamily: 'englishrotated',
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: screenHight * 0.1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHight * 0.05,
            ),
            Text(
              "Flutter for ever ",
              style: TextStyle(
                  fontFamily: 'englishrotated',
                  color: colorProvider.themelevel1,
                  fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
