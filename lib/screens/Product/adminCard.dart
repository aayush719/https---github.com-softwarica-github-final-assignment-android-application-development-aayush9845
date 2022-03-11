import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shop_app/http/httpproduct.dart';
import 'package:shop_app/screens/Product/adminList.dart';
import 'package:shop_app/screens/Product/updateForm.dart';
// import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../../constants.dart';
import '../../models/item.dart';
import '../../size_config.dart';

class AdminCard extends StatefulWidget {
  const AdminCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Item product;

  @override
  State<AdminCard> createState() => _AdminCardState();
}

class _AdminCardState extends State<AdminCard> {
  @override
  Widget build(BuildContext context) {
    var image = widget.product.image;
    final UriData? data = Uri.parse(image).data;
    Uint8List? myImage = data!.contentAsBytes();

    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            UpdateProductScreen.routeName,
            arguments: ProductArguments(product: widget.product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.4,
                child: Container(
                  // padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widget.product.id.toString(),
                    child: Image.memory(myImage),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs ${widget.product.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () async {
                      var del = await HttpConnectProduct.deleteProduct(
                          widget.product.id.toString());

                      if (del == "deleted") {
                        Navigator.pushNamed(context, ProductList.routeName);

                        MotionToast.success(
                                description:
                                    Text('Product deleted successfully'))
                            .show(context);

                        // setState(() {
                        //   snapshot.data!.removeAt(index);
                        //   totalPrice = HttpConnectOrder.getPrice();
                        // });
                      } else {
                        MotionToast.error(
                                description: Text('Failed to delete product'))
                            .show(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(35),
                      width: getProportionateScreenWidth(35),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/Trash.svg",
                          color: Color(0xFFFF4848)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
