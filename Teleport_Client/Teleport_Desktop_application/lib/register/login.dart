// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../components/admin.dart';
import '../home.dart';
import '../setting/globalvariable.dart';
// Import the UserStatisticsPage
import 'package:system_info2/system_info2.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> openUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String userName = _usernameController.text;
      String password = _passwordController.text;

      try {
        // Simulating an API request
        var response = await http.post(
          Uri.parse('http://localhost:9090/api/v1/auth/signin'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'userName': userName,
            'password': password,
          }),
        );
        print(response);
        if (response.statusCode == 200) {
          print("okay");
          var data = jsonDecode(response.body);
          print(data);
          String token = data['token'];
          String userName = data['userName'];
          String role = data['role']; // Get the role from the response
          String subscriptionType = data['subscriptionType'];
          print(token);
          print(userName);

          // Store username and token in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userName', userName);
          await prefs.setString('token', token);
          await prefs.setString('password', password);
          await prefs.setString('subscriptionType', subscriptionType);
          await prefs.setString('role', role);

          // Navigate based on the role
          if (role == 'USER') {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const Home(),
                transitionsBuilder: (_, animation, __, child) {
                  const begin = Offset(0.0, 1.0); //
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end);
                  final offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
                transitionDuration:
                    const Duration(seconds: 1), // Set the duration to 1 second
              ),
            );
          } else if (role == 'ADMIN') {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    UserStatisticsPage(), // Navigate to UserStatisticsPage
                transitionsBuilder: (_, animation, __, child) {
                  const begin = Offset(0.0, 1.0); //
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end);
                  final offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
                transitionDuration:
                    const Duration(seconds: 1), // Set the duration to 1 second
              ),
            );
          }
        } else {
          _showError('Login failed. Please check your credentials.');
        }
      } catch (error) {
        _showError('An error occurred. Please try again.');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color.fromARGB(139, 11, 239, 255),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);
    //colorProvider.userName =
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: screenHight * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      openUrl("http://:3000");
                    },
                    child: SizedBox(
                      height: screenHight * 0.2,
                      width: screenWidth * 0.4,
                      child: Image.asset(
                        "assets/images/signup.gif",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text("you don't have account ?",
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'englishrotated',
                          color: Color.fromARGB(255, 0, 0, 0))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  height: screenHight * 0.3,
                  width: screenWidth * 0.4,
                  child: Image.asset(
                    "assets/images/securty.gif",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHight * 0.1,
          ),
          SizedBox(
            width: screenWidth * 0.7,
            child: Card(
              color: colorProvider.backgroundlevel1,
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  side:
                      BorderSide(color: colorProvider.themelevel1, width: 0.2)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 38,
                          fontFamily: 'englishrotated',
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: screenHight * 0.051),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: ElevatedButton(
                                onPressed: _login,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'englishrotated',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 33, 194, 243),
                                  onPrimary: Color.fromARGB(255, 39, 15, 253),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 20),
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:convert';
// import '../home.dart';
// import '../setting/globalvariable.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   bool _isLoading = false;

//   Future<void> openUrl(String url) async {
//     Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   Future<void> _login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       String userName = _usernameController.text;
//       String password = _passwordController.text;

//       try {
//         // Simulating an API request
//         var response = await http.post(
//           Uri.parse('http://localhost:9090/api/v1/auth/signin'),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode({
//             'userName': userName,
//             'password': password,
//           }),
//         );
//         print(response);
//         if (response.statusCode == 200) {
//           print("okay");
//           var data = jsonDecode(response.body);
//           print(data);
//           String token = data['token'];
//           String userName = data['userName'];
//           String subscriptionType = data['subscriptionType'];
//           print(token);
//           print(userName);

//           // Store username and token in shared preferences
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setString('userName', userName);
//           await prefs.setString('token', token);
//           await prefs.setString('password', password);
//           await prefs.setString('subscriptionType', subscriptionType);

//           // Navigate to home page
//           Navigator.of(context).pushReplacement(
//             PageRouteBuilder(
//               pageBuilder: (_, __, ___) => const Home(),
//               transitionsBuilder: (_, animation, __, child) {
//                 const begin = Offset(0.0, 1.0); //
//                 const end = Offset.zero;
//                 final tween = Tween(begin: begin, end: end);
//                 final offsetAnimation = animation.drive(tween);
//                 return SlideTransition(position: offsetAnimation, child: child);
//               },
//               transitionDuration:
//                   const Duration(seconds: 1), // Set the duration to 2 seconds
//             ),
//           );
//         } else {
//           _showError('Login failed. Please check your credentials.');
//         }
//       } catch (error) {
//         _showError('An error occurred. Please try again.');
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Color.fromARGB(139, 11, 239, 255),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHight = MediaQuery.of(context).size.height;
//     ColorProvider colorProvider = Provider.of<ColorProvider>(context);
//     //colorProvider.userName =
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     height: screenHight * 0.05,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       openUrl("http://:3000");
//                     },
//                     child: SizedBox(
//                       height: screenHight * 0.2,
//                       width: screenWidth * 0.4,
//                       child: Image.asset(
//                         "assets/images/signup.gif",
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   Text("you don't have account ?",
//                       style: TextStyle(
//                           fontSize: 23,
//                           fontFamily: 'englishrotated',
//                           color: Color.fromARGB(255, 0, 0, 0))),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: SizedBox(
//                   height: screenHight * 0.3,
//                   width: screenWidth * 0.4,
//                   child: Image.asset(
//                     "assets/images/securty.gif",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: screenHight * 0.1,
//           ),
//           SizedBox(
//             width: screenWidth * 0.7,
//             child: Card(
//               color: colorProvider.backgroundlevel1,
//               shape: RoundedRectangleBorder(
//                   borderRadius: const BorderRadius.all(Radius.circular(15)),
//                   side:
//                       BorderSide(color: colorProvider.themelevel1, width: 0.2)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Login',
//                         style: TextStyle(
//                           fontSize: 38,
//                           fontFamily: 'englishrotated',
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                       SizedBox(height: screenHight * 0.051),
//                       TextFormField(
//                         controller: _usernameController,
//                         decoration: InputDecoration(
//                           labelText: 'Username',
//                           border: OutlineInputBorder(),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your username';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         controller: _passwordController,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           border: OutlineInputBorder(),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue),
//                           ),
//                         ),
//                         obscureText: true,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 40),
//                       _isLoading
//                           ? CircularProgressIndicator()
//                           : ClipRRect(
//                               borderRadius: BorderRadius.circular(25),
//                               child: ElevatedButton(
//                                 onPressed: _login,
//                                 child: Text(
//                                   'Login',
//                                   style: TextStyle(
//                                     fontSize: 30,
//                                     fontFamily: 'englishrotated',
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   primary:
//                                       const Color.fromARGB(255, 33, 194, 243),
//                                   onPrimary: Color.fromARGB(255, 39, 15, 253),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 100, vertical: 20),
//                                   textStyle: TextStyle(
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: Text(
//           'Welcome to the Home Page!',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
