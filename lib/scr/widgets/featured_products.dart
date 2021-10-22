import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/reponsiveness.dart';
import 'package:flutter_efinder/scr/helpers/screen_navigation.dart';
import 'package:flutter_efinder/scr/providers/product.dart';
import 'package:flutter_efinder/scr/screens/product_detail.dart';
import 'package:provider/provider.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      margin: ResponsiveWidget.isSmallScreen(context)
          ? EdgeInsets.only(left: 10, right: 10)
          : EdgeInsets.only(left: 50, right: 50),
      height: ResponsiveWidget.isSmallScreen(context) ? 200 : 600,
      child: ResponsiveWidget.isSmallScreen(context) ||
              ResponsiveWidget.isMediumScreen(context)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productProvider.products.length,
              itemBuilder: (_, index) {
                return Container(
                    width: 200,
                    margin: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        changeScreen(
                            _,
                            ProductDetail(
                              product: productProvider.products[index],
                            ));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        // margin: EdgeInsets.fromLTRB(0, 8, 16, 8),

                        elevation: 3,
                        shadowColor: grey.withOpacity(0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(
                                      productProvider.products[index].image,
                                      height: 100,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    )),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    width: 70,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CustomText(
                                        text: '65 tuần',
                                        color: white,
                                        size: 14,
                                        weight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        productProvider.products[index].name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "\$${productProvider.products[index].price}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "\$${productProvider.products[index].price}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        productProvider.products[index].center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              })
          : GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    changeScreen(
                      context,
                      ProductDetail(
                        product: productProvider.products[index],
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    shadowColor: grey.withOpacity(0.3),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  productProvider.products[index].image,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(5)),
                            child: Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                text: '65 tuần',
                                color: white,
                                size: 16,
                                weight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: ResponsiveWidget.isMediumScreen(context)
                                ? 75
                                : 100,
                            alignment: AlignmentDirectional.bottomCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          productProvider.products[index].name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "\$${productProvider.products[index].price}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomText(
                                                text:
                                                    "\$${productProvider.products[index].price}",
                                                size: 14,
                                                weight: FontWeight.w300),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: productProvider
                                              .products[index].center,
                                          weight: FontWeight.w300,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
