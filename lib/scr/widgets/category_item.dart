import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/reponsiveness.dart';
import 'package:flutter_efinder/scr/models/category.dart';
import '../helpers/style.dart';
import 'custom_text.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        shadowColor: grey.withOpacity(0.3),
        child: Stack(
          children: [
            Container(
              height: ResponsiveWidget.isSmallScreen(context) ? 100 : 150,
              width: ResponsiveWidget.isSmallScreen(context) ? 150 : 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                    image: NetworkImage(
                      category.image,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              height: ResponsiveWidget.isSmallScreen(context) ? 100 : 150,
              width: ResponsiveWidget.isSmallScreen(context) ? 150 : 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
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
            Positioned(
              bottom: 10,
              left: 10,
              child: Align(
                alignment: Alignment.center,
                child: CustomText(
                  size: 18,
                  text: category.name,
                  color: white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
