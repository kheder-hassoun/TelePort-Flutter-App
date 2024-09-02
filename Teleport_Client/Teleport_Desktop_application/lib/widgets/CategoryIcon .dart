import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../setting/globalvariable.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const CategoryIcon(
      {required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(icon, color: color, size: 30),
        ),
        SizedBox(height: screenHight * 0.005),
        Text(
          label,
          style: TextStyle(
              color: colorProvider.textcolor,
              fontFamily: 'englishrotated',
              fontSize: 18),
        ),
      ],
    );
  }
}
