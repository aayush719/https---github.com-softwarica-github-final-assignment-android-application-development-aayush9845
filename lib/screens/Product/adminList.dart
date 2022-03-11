import 'package:flutter/material.dart';
import 'package:shop_app/http/httpproduct.dart';
import 'package:shop_app/screens/Product/adminCard.dart';
import 'package:shop_app/screens/Product/adminListBody.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import '../../size_config.dart';

class ProductList extends StatefulWidget {
  static String routeName = "/admin";
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 66, 64, 64),
        title: Text("Products"),
      ),
      body: adminListBody(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
