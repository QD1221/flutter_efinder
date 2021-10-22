import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/screen_navigation.dart';
import 'package:flutter_efinder/scr/helpers/style.dart';
import 'package:flutter_efinder/scr/providers/app.dart';
import 'package:flutter_efinder/scr/providers/product.dart';
import 'package:flutter_efinder/scr/providers/center.dart';
import 'package:flutter_efinder/scr/screens/center_detail_1.dart';
import 'package:flutter_efinder/scr/widgets/center_item.dart';
import 'package:flutter_efinder/scr/widgets/custom_text.dart';
import 'package:flutter_efinder/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

class CentersSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final centerProvider = Provider.of<CenterProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: CustomText(
          text: "Centers",
          size: 20,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : centerProvider.searchedCenters.length < 1
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: grey,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "No Centers Found",
                          color: grey,
                          weight: FontWeight.w300,
                          size: 22,
                        ),
                      ],
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: centerProvider.searchedCenters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          await productProvider.loadProductsByCenter(
                              centerId: centerProvider
                                  .searchedCenters[index].id);
                          app.changeLoading();

                          changeScreen(
                              context,
                              CenterScreen(
                                centerModel: centerProvider
                                    .searchedCenters[index],
                              ));
                        },
                        child: CenterItem(
                            center:
                                centerProvider.searchedCenters[index]));
                  }),
    );
  }
}
