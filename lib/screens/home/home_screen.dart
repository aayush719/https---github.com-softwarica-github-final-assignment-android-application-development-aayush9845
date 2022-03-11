import 'dart:async';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic x;
  dynamic token;
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    getCard();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          _accelerometerValues = <double>[event.x, event.y, event.z];
          x = _accelerometerValues?.first;
          if (x < -8) {
            clearCard();
          } else if (x > 8) {
            clearCard();
          }
        },
      ),
    );
  }

  void clearCard() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Message'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();

                    Navigator.pushNamed(context, SignInScreen.routeName);

                    MotionToast.success(
                            description: const Text("Logout Successfull"))
                        .show(context);
                  },
                ),
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                // Center(
                //     child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ElevatedButton(
                //       child: const Text('Yes'),
                //       onPressed: () async {
                //         SharedPreferences prefs =
                //             await SharedPreferences.getInstance();
                //         setState(() {
                //           prefs.clear();
                //         });
                //         Navigator.pushNamed(context, '/');
                //         toastDuration:
                //         const Duration(seconds: 2);
                //         MotionToast.warning(
                //                 description: const Text("Logout Successfull"))
                //             .show(context);
                //       },
                //     ),
                //     ElevatedButton(
                //       child: const Text('No'),
                //       onPressed: () {
                //         Navigator.pushNamed(context, '/');
                //       },
                //     ),
                //   ],
                // ))
              ],
            ));
  }

  void getCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
