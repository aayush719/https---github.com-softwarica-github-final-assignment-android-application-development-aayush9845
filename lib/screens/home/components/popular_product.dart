import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/http/httpproduct.dart';
import 'package:shop_app/models/item.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<PopularProducts> {
  Future<List<Item>> products = HttpConnectProduct.getProducts();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   products = HttpConnectProduct.getProducts();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder<List<Item>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child:
                          SectionTitle(title: "Popular Products", press: () {}),
                    ),
                    SizedBox(height: getProportionateScreenWidth(20)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            snapshot.data!.length,
                            (index) {
                              // if (snapshot.data![index].isPopular)
                              return ProductCard(
                                  product: snapshot.data![index]);

                              // return SizedBox
                              //     .shrink(); // here by default width and height is 0
                            },
                          ),
                          SizedBox(width: getProportionateScreenWidth(20)),
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}













// class PopularProducts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         child: FutureBuilder<List<Item>>(
//             future: HttpConnectProduct.getProducts(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: getProportionateScreenWidth(20)),
//                       child:
//                           SectionTitle(title: "Popular Products", press: () {}),
//                     ),
//                     SizedBox(height: getProportionateScreenWidth(20)),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           ...List.generate(
//                             snapshot.data!.length,
//                             (index) {
//                               // if (snapshot.data![index].isPopular)
//                               return ProductCard(
//                                   product: snapshot.data![index]);

//                               // return SizedBox
//                               //     .shrink(); // here by default width and height is 0
//                             },
//                           ),
//                           SizedBox(width: getProportionateScreenWidth(20)),
//                         ],
//                       ),
//                     )
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//               return const CircularProgressIndicator();
//             }));
//   }
// }
