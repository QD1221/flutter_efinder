import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/screen_navigation.dart';
import 'package:flutter_efinder/scr/helpers/style.dart';
import 'package:flutter_efinder/scr/providers/user.dart';
import 'package:flutter_efinder/scr/screens/cart.dart';
import 'package:flutter_efinder/scr/screens/home.dart';
import 'package:flutter_efinder/scr/screens/login.dart';
import 'package:flutter_efinder/scr/screens/test.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class CustomNavigationBar extends StatelessWidget {
  final bottomIndex;

  const CustomNavigationBar({Key key, this.bottomIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: primary,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: bottomIndex == 0
                ? GestureDetector(
                    onTap: () {
                      changeScreenReplacement(context, Home());
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        color: primary,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.home,
                            color: white,
                          ),
                          CustomText(
                            text: 'Home',
                            color: white,
                          )
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      changeScreenReplacement(context, Home());
                    },
                    child: Icon(
                      Icons.home_outlined,
                      color: white,
                    ),
                  ),
          ),
          Expanded(
            child: bottomIndex == 1
                ? GestureDetector(
                    onTap: () {
                      changeScreenReplacement(context, TestScreen());
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        color: primary,
                        border: Border.all(
                          color: white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.bookmark_rounded,
                            color: white,
                          ),
                          CustomText(
                            text: 'Saved',
                            color: white,
                          )
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      user.status == Status.Unauthenticated
                          ? changeScreenReplacement(context, LoginScreen())
                          : changeScreen(context, CartScreen());
                    },
                    child: Icon(
                      Icons.bookmark_outline_rounded,
                      color: white,
                    ),
                  ),
          ),
          Expanded(
            child: bottomIndex == 2
                ? GestureDetector(
                    onTap: () {
                      changeScreenReplacement(context, LoginScreen());
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                        color: primary,
                        border: Border.all(
                          color: white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.person,
                            color: white,
                          ),
                          CustomText(
                            text: 'Profile',
                            color: white,
                          )
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      changeScreenReplacement(context, LoginScreen());
                    },
                    child: Icon(
                      Icons.person_outline,
                      color: white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
