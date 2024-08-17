import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../setting/globalvariable.dart';

class MyCard extends StatefulWidget {
  const MyCard({
    super.key,
    required this.containt,
    required this.height,
    required this.width,
  });
  final Widget containt;
  final double height;
  final double width;

  @override
  // ignore: no_logic_in_create_state
  State<MyCard> createState() =>
      _MyCardState(containt: containt, height: height, width: width);
}

class _MyCardState extends State<MyCard> {
  _MyCardState({
    required this.containt,
    required this.height,
    required this.width,
  }) : super();
  final double height;
  final double width;

  late final Widget containt;
  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
      child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          color: Color.fromARGB(113, 99, 98, 98),
          //  decoration: BoxDecoration(

          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     colorProvider.themelevel1,
          //     colorProvider.backgroundlevel1
          //   ],
          // ),
          //     ),
          width: screenWidth * width,
          height: screenHight * height,
          padding: const EdgeInsets.all(3),
          child: containt),
    );
  }
}

class SmallCard extends StatelessWidget {
  const SmallCard(
      {super.key,
      required this.path,
      required this.text,
      required this.leftwidget});
  final String path;
  final String text;
  final Widget leftwidget;
  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: SizedBox(
            width: screenWidth * 0.25,
            height: screenHight * 0.15,
            child: Image.asset(
              path,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'englishrotated',
              color: colorProvider.textcolor),
        ),
        leftwidget
      ],
    );
  }
}
