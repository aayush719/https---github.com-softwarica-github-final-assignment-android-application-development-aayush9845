// import 'package:flutter/material.dart';
// import 'package:shop_app/components/rounded_icon_btn.dart';
// import 'package:shop_app/models/item.dart';

// import '../../../size_config.dart';

// class ColorDots extends StatefulWidget {
//   const ColorDots({
//     Key? key,
//     required this.product,
//   }) : super(key: key);

//   final Item product;

//   @override
//   State<ColorDots> createState() => _ColorDotsState();
// }

// class _ColorDotsState extends State<ColorDots> {
//   var counter = 1;
//   void _incrementCounter() {
//     setState(() {
//       counter++;
//     });
//   }

//   void _decrementCounter() {
//     setState(() {
//       if (counter == 1) {
//         counter = counter;
//       } else {
//         counter--;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var totalPrice = int.parse(widget.product.price) * counter;
//     return Column(
//       children: [
//         Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//           child: Row(
//             children: [
//               RoundedIconBtn(
//                 icon: Icons.remove,
//                 showShadow: true,
//                 press: () {
//                   _decrementCounter();
//                 },
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 // width: getProportionateScreenWidth(20),
//                 child: Text(
//                   "${counter}",
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               RoundedIconBtn(
//                 icon: Icons.add,
//                 showShadow: true,
//                 press: () {
//                   _incrementCounter();
//                 },
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenWidth(20)),
//                 child: Text(
//                   "Amount: ${totalPrice}",
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/item.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/details/components/top_rounded_container.dart';

import '../../../components/default_button.dart';
import '../../../http/httpOrder.dart';
import '../../../http/httpuser.dart';
import '../../../models/order.dart';
import '../../../size_config.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Item product;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  Future<bool> addOrder(Order order) {
    var res = HttpConnectOrder().placeOrder(order);
    return res;
  }

  var userId = HttpConnectUser.userId;

  var counter = 1;
  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (counter == 1) {
        counter = counter;
      } else {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var totalPrice = int.parse(widget.product.price) * counter;
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            children: [
              RoundedIconBtn(
                icon: Icons.remove,
                showShadow: true,
                press: () {
                  _decrementCounter();
                },
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                // width: getProportionateScreenWidth(20),
                child: Text(
                  "${counter}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RoundedIconBtn(
                icon: Icons.add,
                showShadow: true,
                press: () {
                  _incrementCounter();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Text(
                  "Amount: ${totalPrice}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        TopRoundedContainer(
          color: Color(0xFFF6F7F9),
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.15,
              right: SizeConfig.screenWidth * 0.15,
              bottom: getProportionateScreenWidth(40),
              top: getProportionateScreenWidth(15),
            ),
            child: DefaultButton(
              text: "Place Order",
              press: () async {
                Order o = Order(
                  id: "",
                  user: userId,
                  product: widget.product.id,
                  quantity: counter.toString(),
                  totalPrice: totalPrice.toString(),
                );
                bool isCreated = await addOrder(o);
                if (isCreated) {
                  Navigator.pushNamed(context, CartScreen.routeName);
                  MotionToast.success(
                          description: Text('Order placed successfully.'))
                      .show(context);
                } else {
                  MotionToast.error(description: Text('Something failed'))
                      .show(context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
