import 'package:flutter/material.dart';
import 'package:flutter_efinder/scr/helpers/reponsiveness.dart';
import 'package:flutter_efinder/scr/widgets/custom_navigation_bar.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _bottomIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: ResponsiveWidget.isSmallScreen(context),
        child: CustomNavigationBar(bottomIndex: 1,),
      ),
      body: Container(
        child: Center(
          child: Text('Test Screen'),
        ),
      ),
    );
  }
}
