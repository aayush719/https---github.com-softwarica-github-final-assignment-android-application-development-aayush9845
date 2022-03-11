// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shop_app/models/Cart.dart';

// import '../../../size_config.dart';
// import 'cart_card.dart';

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: ListView.builder(
//         itemCount: demoCarts.length,
//         itemBuilder: (context, index) => Padding(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: Dismissible(
//             key: Key(demoCarts[index].product.id.toString()),
//             direction: DismissDirection.endToStart,
//             onDismissed: (direction) {
//               setState(() {
//                 demoCarts.removeAt(index);
//               });
//             },
//             background: Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Color(0xFFFFE6E6),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Row(
//                 children: [
//                   Spacer(),
//                   SvgPicture.asset("assets/icons/Trash.svg"),
//                 ],
//               ),
//             ),
//             child: CartCard(cart: demoCarts[index]),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/http/httpOrder.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/responseorder.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import '../cart_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<String> totalPrice = HttpConnectOrder.getPrice();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder<List<ResponseOrder>>(
            future: HttpConnectOrder.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  SizedBox(
                      child: Text(
                    "${snapshot.data!.length} items",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                        fontSize: 18),
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: Key(snapshot.data![index].item.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            var del = await HttpConnectOrder.deleteOrder(
                                snapshot.data![index].id.toString());
                            if (del == "deleted") {
                              MotionToast.success(
                                      description:
                                          Text('Order deleted successfully'))
                                  .show(context);
                              setState(() {
                                snapshot.data!.removeAt(index);
                                totalPrice = HttpConnectOrder.getPrice();
                              });
                            } else {
                              MotionToast.error(
                                      description:
                                          Text('Failed to delete order'))
                                  .show(context);
                            }
                            // Navigator.pushNamed(context, CartScreen.routeName);
                          },
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE6E6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                SvgPicture.asset("assets/icons/Trash.svg"),
                              ],
                            ),
                          ),
                          child: CartCard(cart: snapshot.data![index]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      child: FutureBuilder<String>(
                          future: totalPrice,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenWidth(15),
                                  horizontal: getProportionateScreenWidth(30),
                                ),
                                // height: 174,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, -15),
                                      blurRadius: 20,
                                      color:
                                          Color(0xFFDADADA).withOpacity(0.15),
                                    )
                                  ],
                                ),
                                child: SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            height:
                                                getProportionateScreenWidth(40),
                                            width:
                                                getProportionateScreenWidth(40),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF5F6F9),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SvgPicture.asset(
                                                "assets/icons/receipt.svg"),
                                          ),
                                          Spacer(),
                                          Text("Add voucher code"),
                                          const SizedBox(width: 10),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12,
                                            color: kTextColor,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(20)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text: "Total:\n",
                                              children: [
                                                TextSpan(
                                                  text: "Nrs ${snapshot.data!}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: kPrimaryColor,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: getProportionateScreenWidth(
                                                190),
                                            child: DefaultButton(
                                              text: "Check Out",
                                              press: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return const CircularProgressIndicator();
                          }))
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
