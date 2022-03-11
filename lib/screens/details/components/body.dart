// import 'package:flutter/material.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:shop_app/components/default_button.dart';
// import 'package:shop_app/models/item.dart';
// import 'package:shop_app/models/order.dart';
// import 'package:shop_app/size_config.dart';

// import '../../../http/httpOrder.dart';
// import 'color_dots.dart';
// import 'product_description.dart';
// import 'top_rounded_container.dart';
// import 'product_images.dart';

// class Body extends StatelessWidget {
//   final Item product;

//   const Body({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Future<bool> addOrder(Order order) {
//       var res = HttpConnectOrder().placeOrder(order);
//       return res;
//     }

//     return ListView(
//       children: [
//         ProductImages(product: product),
//         TopRoundedContainer(
//           color: Colors.white,
//           child: Column(
//             children: [
//               ProductDescription(
//                 product: product,
//                 pressOnSeeMore: () {},
//               ),
//               TopRoundedContainer(
//                 color: Color(0xFFF6F7F9),
//                 child: Column(
//                   children: [
//                     ColorDots(product: product),
//                     TopRoundedContainer(
//                       color: Colors.white,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           left: SizeConfig.screenWidth * 0.15,
//                           right: SizeConfig.screenWidth * 0.15,
//                           bottom: getProportionateScreenWidth(40),
//                           top: getProportionateScreenWidth(15),
//                         ),
//                         child: DefaultButton(
//                           text: "Add To Cart",
//                           press: () async {
//                             Order o = Order(
//                                 user: "234",
//                                 product: "234",
//                                 quantity: "2",
//                                 totalPrice: "350");

//                             bool isCreated = await addOrder(o);
//                             if (isCreated) {
//                               MotionToast.success(
//                                       description: Text('Added to cart.'))
//                                   .show(context);
//                             } else {
//                               MotionToast.error(
//                                       description: Text('Something failed'))
//                                   .show(context);
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
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
import 'package:shop_app/models/item.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Item product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ColorDots(product: product),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
