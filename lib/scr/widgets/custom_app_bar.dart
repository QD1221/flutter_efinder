import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/reponsiveness.dart';
import 'package:flutter_efinder/scr/helpers/screen_navigation.dart';
import 'package:flutter_efinder/scr/helpers/style.dart';
import 'package:flutter_efinder/scr/providers/app.dart';
import 'package:flutter_efinder/scr/providers/center.dart';
import 'package:flutter_efinder/scr/providers/product.dart';
import 'package:flutter_efinder/scr/providers/user.dart';
import 'package:flutter_efinder/scr/screens/cart.dart';
import 'package:flutter_efinder/scr/screens/centers_search.dart';
import 'package:flutter_efinder/scr/screens/login.dart';
import 'package:flutter_efinder/scr/screens/product_search.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final centerProvider = Provider.of<CenterProvider>(context);

    final productProvider = Provider.of<ProductProvider>(context);

    return AppBar(
      iconTheme: IconThemeData(color: white),
      elevation: 0.5,
      backgroundColor: primary,
      title: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: SizedBox(
                  width: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 20),
                child: CustomText(
                  text: "EFinder",
                  color: white,
                  size: 24,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: Stack(alignment: Alignment.center, children: [
                    TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern) async {
                        app.changeLoading();
                        if (app.search == SearchBy.PRODUCTS) {
                          await productProvider.search(productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        } else {
                          await centerProvider.search(name: pattern);
                          changeScreen(context, CentersSearchScreen());
                        }
                        app.changeLoading();
                      },
                      decoration: InputDecoration(
                          filled: true,
                          isCollapsed: true,
                          fillColor: Colors.white,
                          hintText: 'Tìm kiếm',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 20, bottom: 10, top: 15),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: white))),
                    ),
                    Positioned(
                      height: 30,
                      right: 5,
                      child: Container(
                        height: 30,
                        padding: EdgeInsets.only(left: 10, right: 2),
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: primary,
                            value: app.filterBy,
                            style: TextStyle(
                                color: white, fontWeight: FontWeight.w300),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: white,
                            ),
                            elevation: 0,
                            onChanged: (value) {
                              if (value == "Khóa học") {
                                app.changeSearchBy(
                                    newSearchBy: SearchBy.PRODUCTS);
                              } else {
                                app.changeSearchBy(
                                    newSearchBy: SearchBy.CENTERS);
                              }
                            },
                            items: <String>["Khóa học", "Trung tâm"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: SizedBox(
                  width: 10,
                ),
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: IconButton(
                    icon: Icon(
                      Icons.bookmark_outline_rounded,
                      color: white,
                    ),
                    onPressed: () {
                      user.status == Status.Unauthenticated
                          ? changeScreenReplacement(context, LoginScreen())
                          : changeScreen(context, CartScreen());
                    }),
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: SizedBox(
                  width: 10,
                ),
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: Container(
                  width: 1,
                  height: 24,
                  color: white,
                ),
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: SizedBox(
                  width: 20,
                ),
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: primary,
                  ),
                  child: user.status == Status.Unauthenticated
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(primary),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                          color: Colors.white, width: 1.5)))),
                          onPressed: () {
                            changeScreenReplacement(context, LoginScreen());
                          },
                          child: CustomText(
                            text: 'Đăng nhập',
                            color: white,
                            size: 14,
                          ))
                      : IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: white,
                          ),
                          onPressed: () {
                            changeScreenReplacement(
                              context,
                              LoginScreen(),
                            );
                          }),
                ),
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmallScreen(context),
                child: SizedBox(
                  width: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
