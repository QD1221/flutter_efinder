import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/responsiveness.dart';
import 'package:flutter_efinder/scr/helpers/screen_navigation.dart';
import 'package:flutter_efinder/scr/helpers/style.dart';
import 'package:flutter_efinder/scr/models/center.dart';
import 'package:flutter_efinder/scr/providers/product.dart';
import 'package:flutter_efinder/scr/screens/product_detail.dart';
import 'package:flutter_efinder/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';


class CenterDetail extends StatefulWidget {
  final CenterModel centerModel;

  const CenterDetail({Key key, this.centerModel}) : super(key: key);

  @override
  _CenterDetailState createState() => _CenterDetailState();
}

class _CenterDetailState extends State<CenterDetail>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    Widget aboutWidget() {
      return Container(
        child: Center(
          child: Text('Thông tin'),
        ),
      );
    }

    Widget galleryWidget() {
      return Container(
        child: Center(
          child: Text('Hình ảnh'),
        ),
      );
    }

    Widget serviceWidget() {
      return ResponsiveWidget.isSmallScreen(context)
          ? GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: productProvider.productsByCenter.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    changeScreen(
                        context,
                        ProductDetail2(
                          product: productProvider.productsByCenter[index],
                        ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                  productProvider.productsByCenter[index].image,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
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
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 80,
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
                                    margin: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          productProvider
                                              .productsByCenter[index].name,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                child: Text(
                                                  "\$${productProvider.productsByCenter[index].price}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                child: Text(
                                                  "\$${productProvider.productsByCenter[index].price}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          productProvider
                                              .productsByCenter[index].center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 7,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
          : GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: productProvider.productsByCenter.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    changeScreen(
                        context,
                        ProductDetail2(
                          product: productProvider.productsByCenter[index],
                        ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                                  productProvider.productsByCenter[index].image,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: ResponsiveWidget.isMediumScreen(context)
                              ? 10
                              : 15,
                          right: ResponsiveWidget.isMediumScreen(context)
                              ? 10
                              : 15,
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
                                size: ResponsiveWidget.isMediumScreen(context)
                                    ? 14
                                    : 16,
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
                                ? 80
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
                                          productProvider
                                              .productsByCenter[index].name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height:
                                              ResponsiveWidget.isMediumScreen(
                                                      context)
                                                  ? 5
                                                  : 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                child: Text(
                                                  "\$${productProvider.productsByCenter[index].price}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                child: Text(
                                                  "\$${productProvider.productsByCenter[index].price}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              ResponsiveWidget.isMediumScreen(
                                                      context)
                                                  ? 5
                                                  : 10,
                                        ),
                                        CustomText(
                                          text: productProvider
                                              .productsByCenter[index].center,
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
              });
    }

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              Container(
                child: SliverAppBar(
                  title: Text(widget.centerModel.name),
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
                          widget.centerModel.image,
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
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    labelColor: white,
                    unselectedLabelColor: white,
                    isScrollable: true,
                    indicatorColor: primary,
                    tabs: [
                      Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Giới thiệu',
                                style: TextStyle(fontSize: 16))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Tab(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Khóa học',
                                  style: TextStyle(fontSize: 16))),
                        ),
                      ),
                      Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Hình ảnh',
                                style: TextStyle(fontSize: 16))),
                      ),
                    ],
                    controller: controller,
                  ),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.call, color: white, size: 16),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.message, color: white, size: 16),
                        onPressed: () {}),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              aboutWidget(),
              serviceWidget(),
              galleryWidget(),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Icon(Icons.favorite),
        //   ),
        //   backgroundColor: primary,
        // ),
      ),
    );
  }
}
