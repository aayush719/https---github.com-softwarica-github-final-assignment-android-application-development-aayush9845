// import 'package:flutter/material.dart';
// import 'package:shop_app/screens/Product/productForm.dart';

// import '../../http/httpproduct.dart';
// import '../../models/item.dart';
// import '../../size_config.dart';
// import '../home/components/section_title.dart';
// import 'adminCard.dart';

// class adminListBody extends StatefulWidget {
//   const adminListBody({Key? key}) : super(key: key);

//   @override
//   State<adminListBody> createState() => _adminListBodyState();
// }

// class _adminListBodyState extends State<adminListBody> {
//   Future<List<Item>> products = HttpConnectProduct.getProducts();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         child: FutureBuilder<List<Item>>(
//             future: products,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return GridView.count(
//                   crossAxisCount: 2,
//                   //  crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 40,
//                   children: [
//                     ...List.generate(
//                       snapshot.data!.length,
//                       (index) {
//                         return AdminCard(product: snapshot.data![index]);
//                       },
//                     ),
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//               return const CircularProgressIndicator();
//             }));
//   }
// }

import 'package:flutter/material.dart';
import 'package:shop_app/screens/Product/productForm.dart';
import '../../http/httpproduct.dart';
import '../../models/item.dart';
import '../../size_config.dart';
import '../home/components/section_title.dart';
import 'adminCard.dart';

class adminListBody extends StatefulWidget {
  const adminListBody({Key? key}) : super(key: key);
  @override
  State<adminListBody> createState() => _adminListBodyState();
}

class _adminListBodyState extends State<adminListBody> {
  Future<List<Item>> products = HttpConnectProduct.getProducts();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder<List<Item>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  SizedBox(height: getProportionateScreenWidth(20)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SectionTitle(title: "All Products", press: () {}),
                  ),
                  SizedBox(height: getProportionateScreenWidth(20)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 40),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AddProductScreen.routeName);
                      },
                      child: const Text("Add Product")),
                  SizedBox(height: getProportionateScreenWidth(20)),
                  new Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 40,
                    children: [
                      ...List.generate(
                        snapshot.data!.length,
                        (index) {
                          return AdminCard(product: snapshot.data![index]);
                        },
                      ),
                    ],
                  )),
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
