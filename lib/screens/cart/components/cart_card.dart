// import 'package:flutter/material.dart';
// import 'package:shop_app/models/Cart.dart';

// import '../../../constants.dart';
// import '../../../size_config.dart';

// class CartCard extends StatelessWidget {
//   const CartCard({
//     Key? key,
//     required this.cart,
//   }) : super(key: key);

//   final Cart cart;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 88,
//           child: AspectRatio(
//             aspectRatio: 0.88,
//             child: Container(
//               padding: EdgeInsets.all(getProportionateScreenWidth(10)),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF5F6F9),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Image.asset(cart.product.images[0]),
//             ),
//           ),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               cart.product.title,
//               style: TextStyle(color: Colors.black, fontSize: 16),
//               maxLines: 2,
//             ),
//             SizedBox(height: 10),
//             Text.rich(
//               TextSpan(
//                 text: "${cart.product.price}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600, color: kPrimaryColor),
//                 children: [
//                   TextSpan(
//                       text: " x${cart.numOfItem}",
//                       style: Theme.of(context).textTheme.bodyText1),
//                   TextSpan(
//                       text: " =${cart.numOfItem * cart.product.price}",
//                       style: Theme.of(context).textTheme.bodyText1),
//                 ],
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shop_app/http/httpproduct.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/item.dart';
import 'package:shop_app/models/responseorder.dart';

import '../../../constants.dart';
import '../../../http/httpOrder.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final ResponseOrder cart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder<Item>(
            future: HttpConnectProduct.getProduct(cart.item),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var image = snapshot.data!.image;
                final UriData? data = Uri.parse(image).data;
                Uint8List? myImage = data!.contentAsBytes();

                return Row(children: [
                  SizedBox(
                    width: 88,
                    child: AspectRatio(
                      aspectRatio: 0.88,
                      child: Container(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(10)),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.memory(myImage),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.name,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      SizedBox(height: 15),
                      Text.rich(
                        TextSpan(
                          text: "${snapshot.data!.price}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                          children: [
                            TextSpan(
                                text: " x${cart.quantity}",
                                style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(
                              text: "=${cart.totalPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
