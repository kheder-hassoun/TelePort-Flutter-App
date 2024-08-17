import 'package:amazing_001/register/startup.dart';
import 'package:amazing_001/setting/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'data/data.dart';
// short cuts
// ctr + shift + r  all option when select something
//commands
//flutter create projectname
//flutter run
//flutter doctor
//--------------------------------------- build apk
//flutter build apk --release // apk size arround 17 MB
//flutter build apk --release --split-debug-info=./debug_apks  // apk size arround 16 MB

void main() async {
//windowwwwws

  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  // Use WindowOptions to set the initial size and constraints
  WindowOptions windowOptions = WindowOptions(
    size: Size(850, 750), // Startup width and height
    minimumSize: Size(600, 400), // Minimum window size
    maximumSize: Size(1600, 1200), // Maximum window size
    center: true, // Centers the window on the screen
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

// end of windooowwwwwsss

  WidgetsFlutterBinding.ensureInitialized();
  await AppCounter.incrementAppOpenCount(); // Increment app open count
  ColorProvider colorProvider = ColorProvider();
  await colorProvider.init();
  runApp(
    ChangeNotifierProvider.value(
      value: colorProvider,
      child: const App(),
    ),
  );
}

// class App extends StatelessWidget {
//   const App({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Test(),
//     );
//   }
// }

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartUp(),
    );
  }
}
