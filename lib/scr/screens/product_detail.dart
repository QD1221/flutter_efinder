import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/screen_navigation.dart';
import 'package:flutter_efinder/scr/models/products.dart';
import 'package:flutter_efinder/scr/providers/app.dart';
import 'package:flutter_efinder/scr/providers/user.dart';
import 'package:flutter_efinder/scr/screens/cart.dart';
import 'package:flutter_efinder/scr/widgets/custom_text.dart';
import 'package:flutter_efinder/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../helpers/style.dart';
import 'login.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel product;

  const ProductDetail({@required this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () async {
              user.status == Status.Unauthenticated
                  ? changeScreen(context, LoginScreen())
                  : changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: app.isLoading
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(widget.product.image),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      text: widget.product.name,
                      size: 26,
                      weight: FontWeight.bold),
                  CustomText(
                      text: "\$${widget.product.price / 100}",
                      size: 20,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text: "Description", size: 18, weight: FontWeight.w400),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.description,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: grey, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          user.status == Status.Unauthenticated
                              ? changeScreen(context, LoginScreen())
                              : app.changeLoading();
                          print("All set loading");

                          bool value =
                              await user.addToCart(product: widget.product);
                          if (value) {
                            print("Item added to cart");
                            _key.currentState.showSnackBar(
                                SnackBar(content: Text("Added To Cart!")));
                            user.reloadUserModel();
                            app.changeLoading();
                          } else {
                            print("Item NOT added to cart");
                          }
                          print("LOADING SET TO FALSE");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: app.isLoading
                              ? Loading()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                  child: CustomText(
                                    text: "Add To Cart",
                                    color: white,
                                    size: 22,
                                    weight: FontWeight.w300,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
