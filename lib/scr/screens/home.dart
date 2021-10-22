import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_efinder/scr/helpers/reponsiveness.dart';
import 'package:flutter_efinder/scr/helpers/screen_navigation.dart';
import 'package:flutter_efinder/scr/helpers/style.dart';
import 'package:flutter_efinder/scr/providers/app.dart';
import 'package:flutter_efinder/scr/providers/category.dart';
import 'package:flutter_efinder/scr/providers/product.dart';
import 'package:flutter_efinder/scr/providers/center.dart';
import 'package:flutter_efinder/scr/providers/user.dart';
import 'package:flutter_efinder/scr/screens/category_detail.dart';
import 'package:flutter_efinder/scr/screens/center_detail_2.dart';
import 'package:flutter_efinder/scr/widgets/category_item.dart';
import 'package:flutter_efinder/scr/widgets/center_item.dart';
import 'package:flutter_efinder/scr/widgets/custom_app_bar.dart';
import 'package:flutter_efinder/scr/widgets/custom_navigation_bar.dart';
import 'package:flutter_efinder/scr/widgets/custom_text.dart';
import 'package:flutter_efinder/scr/widgets/featured_products.dart';
import 'package:flutter_efinder/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final centerProvider = Provider.of<CenterProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    centerProvider.loadSingleCenter();
    print('${user.status}');
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: Visibility(
          visible: ResponsiveWidget.isSmallScreen(context),
          child: CustomNavigationBar(
            bottomIndex: 0,
          )),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: ResponsiveWidget.isSmallScreen(context) ? 10 : 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: !ResponsiveWidget.isSmallScreen(context),
                            child: SizedBox(
                              width: 50,
                            )),
                        CustomText(
                          text: "CATEGORY",
                          size: 18,
                          color: primary,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveWidget.isSmallScreen(context) ? 10 : 20,
                  ),

//Category

                  Container(
                    height: ResponsiveWidget.isSmallScreen(context) ? 100 : 150,
                    padding: EdgeInsets.only(left: 15, right: 10),
                    child: ResponsiveWidget.isSmallScreen(context) ||
                            ResponsiveWidget.isMediumScreen(context)

//Category S, M

                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: categoryProvider.categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await productProvider.loadProductsByCategory(
                                      categoryName: categoryProvider
                                          .categories[index].name);

                                  changeScreen(
                                      context,
                                      CategoryDetailScreen(
                                        categoryModel:
                                            categoryProvider.categories[index],
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CategoryItem(
                                    category:
                                        categoryProvider.categories[index],
                                  ),
                                ),
                              );
                            })

//Category L

                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: categoryProvider.categories
                                .map((item) => GestureDetector(
                                      onTap: () async {
                                        await productProvider
                                            .loadProductsByCategory(
                                                categoryName: item.name);

                                        changeScreen(
                                            context,
                                            CategoryDetailScreen(
                                              categoryModel: item,
                                            ));
                                      },
                                      child: CategoryItem(
                                        category: item,
                                      ),
                                    ))
                                .toList(),
                          ),
                  ),
                  SizedBox(
                    height: ResponsiveWidget.isSmallScreen(context) ? 10 : 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: !ResponsiveWidget.isSmallScreen(context),
                            child: SizedBox(
                              width: 50,
                            )),
                        CustomText(
                          text: "FEATURED",
                          size: 18,
                          color: primary,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveWidget.isSmallScreen(context) ? 10 : 20,
                  ),

//Feature Products

                  Featured(),
                  SizedBox(
                    height: ResponsiveWidget.isSmallScreen(context) ? 10 : 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: !ResponsiveWidget.isSmallScreen(context),
                          child: SizedBox(
                            width: 50,
                          ),
                        ),
                        CustomText(
                          text: "POPULAR CENTERS",
                          size: 18,
                          color: primary,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveWidget.isSmallScreen(context) ? 10 : 20,
                  ),

//Popular Centers

                  ResponsiveWidget.isSmallScreen(context)

//Popular Centers - S

                      ? Container(
                          height: 200,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 10),
                            itemCount: centerProvider.centers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  await productProvider.loadProductsByCenter(
                                      centerId:
                                          centerProvider.centers[index].id);
                                  changeScreen(
                                    context,
                                    CenterDetail(
                                      centerModel:
                                          centerProvider.centers[index],
                                    ),
                                  );
                                },
                                child: CenterItem(
                                    center: centerProvider.centers[index]),
                              );
                            },
                          ),
                        )

//Popular Centers - M, L

                      : Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 325,
                              aspectRatio: 1.5,
                              viewportFraction: 0.45,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              // enableInfiniteScroll: false,
                              // initialPage: 2,
                              autoPlay: true,
                            ),
                            items: centerProvider.centers
                                .map((item) => GestureDetector(
                                      onTap: () async {
                                        app.changeLoading();
                                        await productProvider
                                            .loadProductsByCenter(
                                                centerId: item.id);
                                        app.changeLoading();
                                        changeScreen(
                                            context,
                                            CenterDetail(
                                              centerModel: item,
                                            ));
                                      },
                                      child: CenterItem(
                                        center: item,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
