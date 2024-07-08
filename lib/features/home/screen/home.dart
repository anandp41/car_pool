import 'package:flutter/material.dart';

import '../widgets/body.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_drawer_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawerHome(scaffoldKey: _scaffoldKey),
      body: Body(scaffoldKey: _scaffoldKey, screenHeight: screenHeight),
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
