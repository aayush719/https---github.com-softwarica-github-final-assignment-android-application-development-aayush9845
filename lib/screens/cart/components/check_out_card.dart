import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/http/httpOrder.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: DefaultButton(
            text: "Go to Homepage",
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            }));
  }
}
