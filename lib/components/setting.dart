import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../register/startup.dart';
import '../setting/globalvariable.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String appcounter = "0";
  String hadeelcounter = "0";
  String birthdaycounter = "0";
  Future<void> help() async {
    final currentCountApp = await AppCounter.getAppOpenCount();
    final currentCountHadeel = await AppCounter.getHadeelCount();
    final currentCountBirthday = await AppCounter.getBirthdayCount();

    setState(() {
      appcounter = currentCountApp.toString();
      hadeelcounter = currentCountHadeel.toString();
      birthdaycounter = currentCountBirthday.toString();
    });
  }

  @override
  void initState() {
    super.initState();
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
        title: const Text('Setting '),
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
            Card(
              color: colorProvider.backgroundlevel2,
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                      color: colorProvider.themelevel1, width: 0.01)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                      child: Text(
                    "Theme Setting",
                    style: TextStyle(
                        fontFamily: 'englishrotated',
                        fontSize: 16,
                        color: colorProvider.themelevel1,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: screenHight * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<ColorProvider>(context, listen: false)
                          .changetheme();
                    },
                    child: SizedBox(
                      height: screenHight * 0.08,
                      width: screenWidth * 0.8,
                      child: Card(
                        color: colorProvider.backgroundlevel1,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                color: colorProvider.themelevel1, width: 0.01)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              colorProvider.nextthemestate,
                              style: TextStyle(
                                  fontFamily: 'englishrotated',
                                  color: colorProvider.textcolor,
                                  fontSize: 18),
                            ),
                            Icon(
                              colorProvider.nextthemeicon,
                              color: colorProvider.nextthemeiconcolor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //theme color
                  SizedBox(
                    height: screenHight * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<ColorProvider>(context, listen: false)
                          .setThemeLevel1Color(
                              const Color.fromARGB(218, 209, 8, 8));
                    },
                    child: SizedBox(
                      height: screenHight * 0.08,
                      width: screenWidth * 0.8,
                      child: Card(
                        color: colorProvider.backgroundlevel1,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                color: colorProvider.themelevel1, width: 0.01)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "change them to Red",
                              style: TextStyle(
                                  fontFamily: 'englishrotated',
                                  color: colorProvider.textcolor,
                                  fontSize: 18),
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Color.fromARGB(218, 209, 8, 8),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //theme green
                  SizedBox(
                    height: screenHight * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<ColorProvider>(context, listen: false)
                          .setThemeLevel1Color(
                              const Color.fromARGB(221, 16, 172, 21));
                    },
                    child: SizedBox(
                      height: screenHight * 0.08,
                      width: screenWidth * 0.8,
                      child: Card(
                        color: colorProvider.backgroundlevel1,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                color: colorProvider.themelevel1, width: 0.01)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "change them to Green",
                              style: TextStyle(
                                  fontFamily: 'englishrotated',
                                  color: colorProvider.textcolor,
                                  fontSize: 18),
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Color.fromARGB(221, 16, 172, 21),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //theme pink
                  SizedBox(
                    height: screenHight * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<ColorProvider>(context, listen: false)
                          .setThemeLevel1Color(
                        Color.fromARGB(244, 111, 0, 126),
                      );
                    },
                    child: SizedBox(
                      height: screenHight * 0.08,
                      width: screenWidth * 0.8,
                      child: Card(
                        color: colorProvider.backgroundlevel1,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                color: colorProvider.themelevel1, width: 0.01)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "change them to Pink",
                              style: TextStyle(
                                  fontFamily: 'englishrotated',
                                  color: colorProvider.textcolor,
                                  fontSize: 18),
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Color.fromARGB(235, 78, 0, 88),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //theme Blue
                  SizedBox(
                    height: screenHight * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<ColorProvider>(context, listen: false)
                          .setThemeLevel1Color(Color.fromARGB(238, 1, 70, 134));
                    },
                    child: SizedBox(
                      height: screenHight * 0.08,
                      width: screenWidth * 0.8,
                      child: Card(
                        color: colorProvider.backgroundlevel1,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                color: colorProvider.themelevel1, width: 0.01)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "change them to Blue",
                              style: TextStyle(
                                  fontFamily: 'englishrotated',
                                  color: colorProvider.textcolor,
                                  fontSize: 18),
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Color.fromARGB(224, 26, 134, 236),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //end them color
                  SizedBox(
                    height: screenHight * 0.03,
                  ),
                ],
              ),
            ),
            //!end of theme setting card
            //
            SizedBox(
              height: screenHight * 0.05,
            ),
            Card(
              color: colorProvider.backgroundlevel2,
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                      color: colorProvider.themelevel1, width: 0.01)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                      child: Text(
                    "Security Setting",
                    style: TextStyle(
                        fontFamily: 'englishrotated',
                        fontSize: 16,
                        color: colorProvider.themelevel1,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: screenHight * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (_) {
                        return const StartUp();
                      }));
                    },
                    child: SizedBox(
                      height: screenHight * 0.08,
                      width: screenWidth * 0.8,
                      child: Card(
                        color: colorProvider.backgroundlevel1,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                color: colorProvider.themelevel1, width: 0.01)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Restart ",
                              style: TextStyle(
                                  fontFamily: 'englishrotated',
                                  color: colorProvider.textcolor,
                                  fontSize: 20),
                            ),
                            const Icon(Icons.person_2_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHight * 0.03,
                  ),
                  Center(
                      child: Text(
                    "Information for developer",
                    style: TextStyle(
                        fontFamily: 'englishrotated',
                        fontSize: 16,
                        color: colorProvider.themelevel1,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: screenHight * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " app T.O.C  : ",
                        style: TextStyle(
                            fontFamily: 'englishrotated',
                            fontSize: 16,
                            color: colorProvider.themelevel1,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(appcounter,
                          style: TextStyle(color: colorProvider.textcolor))
                    ],
                  ),
                  SizedBox(
                    height: screenHight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " app H.O.C  : ",
                        style: TextStyle(
                            fontFamily: 'englishrotated',
                            fontSize: 16,
                            color: colorProvider.themelevel1,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(hadeelcounter,
                          style: TextStyle(color: colorProvider.textcolor))
                    ],
                  ),
                  SizedBox(
                    height: screenHight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " app B.O.C  : ",
                        style: TextStyle(
                            fontFamily: 'englishrotated',
                            fontSize: 16,
                            color: colorProvider.themelevel1,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(birthdaycounter,
                          style: TextStyle(color: colorProvider.textcolor))
                    ],
                  ),
                  SizedBox(
                    height: screenHight * 0.05,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHight * 0.08,
            ),
          ]),
        ),
      ),
    );
  }
}
