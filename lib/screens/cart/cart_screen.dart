import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import '../../http/httpOrder.dart';
import '../../models/responseorder.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Orders",
            style: TextStyle(color: Colors.black),
          ),
          // TotalItem()
        ],
      ),
    );
  }
}

class TotalItem extends StatefulWidget {
  const TotalItem({
    Key? key,
  }) : super(key: key);

  @override
  _TotalItemState createState() => _TotalItemState();
}

class _TotalItemState extends State<TotalItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder<List<ResponseOrder>>(
            future: HttpConnectOrder.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  "${snapshot.data!.length} items",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor,
                      fontSize: 18),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
