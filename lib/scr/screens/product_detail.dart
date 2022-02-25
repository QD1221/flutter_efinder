import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/screen_navigation.dart';
import 'package:flutter_efinder/scr/helpers/style.dart';
import 'package:flutter_efinder/scr/models/products.dart';
import 'package:flutter_efinder/scr/providers/app.dart';
import 'package:flutter_efinder/scr/providers/user.dart';
import 'package:flutter_efinder/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'login.dart';

class ProductDetail2 extends StatefulWidget {
  final ProductModel product;

  const ProductDetail2({Key key, @required this.product}) : super(key: key);

  @override
  _ProductDetail2State createState() => _ProductDetail2State();
}

class _ProductDetail2State extends State<ProductDetail2> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            Container(
              child: SliverAppBar(
                title: Text(widget.product.name),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: primary,
                pinned: true,
                elevation: 2,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  titlePadding: EdgeInsets.all(10),
                  background: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.network(
                        widget.product.image,
                        height: 500,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 500,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.black,
                            ],
                            stops: [0.0, 1.0],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: widget.product.center,
                                  color: Colors.white,
                                ),
                                CustomText(
                                  text: "\$${widget.product.price / 100}",
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text:
                                  'Địa chỉ: KCN Sài Đồng B, Long Biên, Hà Nội',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.bookmark_border,
                        color: white,
                      ),
                      onPressed: () {
                        user.status == Status.Unauthenticated
                            ? changeScreenReplacement(context, LoginScreen())
                            : changeScreen(context, CartScreen());
                      }),
                ],
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  'Tổng quan',
                  style: Theme.of(context).textTheme.headline6,
                ),
                children: [
                  ListTile(
                    title: Text(
                      '- Đối tượng học viên: Dành cho các học viên đang có nhu cầu đạt được điểm số 6.5 trong thời gian nhanh nhất trong vòng 9 tuần (2 tháng)\n- Quy mô lớp học: 3 - 6 học viên\n- Học phí: 32.000.000 VNĐ\n- Lộ trình học: 38 buổi ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              ExpansionTile(
                initiallyExpanded: false,
                title: Text(
                  'Mô tả chi tiết',
                  style: Theme.of(context).textTheme.headline6,
                ),
                children: [
                  ListTile(
                    title: Text(
                      '- Đối tượng học viên: Dành cho các học viên đang có nhu cầu đạt được điểm số 6.5 trong thời gian nhanh nhất trong vòng 9 tuần (2 tháng)\n- Quy mô lớp học: 3 - 6 học viên\n- Học phí: 32.000.000 VNĐ\n- Lộ trình học: 38 buổi ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              ExpansionTile(
                initiallyExpanded: false,
                title: Text(
                  'Quyền lợi và trách nhiệm',
                  style: Theme.of(context).textTheme.headline6,
                ),
                children: [
                  ListTile(
                    title: Text(
                      '- Đối tượng học viên: Dành cho các học viên đang có nhu cầu đạt được điểm số 6.5 trong thời gian nhanh nhất trong vòng 9 tuần (2 tháng)\n- Quy mô lớp học: 3 - 6 học viên\n- Học phí: 32.000.000 VNĐ\n- Lộ trình học: 38 buổi ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          user.status == Status.Unauthenticated
              ? changeScreen(context, LoginScreen())
              : app.changeLoading();
          print("All set loading");

          bool value = await user.addToCart(product: widget.product);
          if (value) {
            print("Item added to cart");
            _key.currentState
                .showSnackBar(SnackBar(content: Text("Added To Cart!")));
            user.reloadUserModel();
            app.changeLoading();
          } else {
            print("Item NOT added to cart");
          }
          print("LOADING SET TO FALSE");
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.bookmark_add),
        ),
        backgroundColor: primary,
      ),
    );
  }
}
