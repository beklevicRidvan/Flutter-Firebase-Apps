import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:harcama_takip_app/view_model/homepage_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/expanses_page_view_model.dart';

class HomePageView extends StatelessWidget {
  const  HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: _buildNavbar(context),
    );
  }

  Widget _buildNavbar(BuildContext context) {
    return Consumer<HomepageViewModel>(
      builder: (context, value, child) {
        return FluidNavBar(
          icons: [
            FluidNavBarIcon(

                svgPath: "assets/svg_icons/home.svg",
                //backgroundColor: const Color(0xFF4285F4),
                extras: {"label": "home"}),

            FluidNavBarIcon(

                svgPath: "assets/svg_icons/add.svg",
                //backgroundColor: const Color(0xFF4285F4),
                extras: {"label": "add"}),
            FluidNavBarIcon(
                svgPath: "assets/svg_icons/person.svg",
                //backgroundColor: Color(0xFF34A950),
                extras: {"label": "conference"}),
          ],
          onChange: (myValue) {
            value.changeSelectedIndex(myValue);
          },
          style: const FluidNavBarStyle(
              barBackgroundColor: Color(0xff81D4FA),

              iconSelectedForegroundColor: Colors.white,
              iconUnselectedForegroundColor: Colors.black),
          scaleFactor: 1.5,
          defaultIndex: 1,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        );
      },
    );
  }


  _buildBody(BuildContext context) {
    return Consumer<HomepageViewModel>(
      builder: (context, value, child) {
        return value.pages[value.selectedIndex];
      },
    );
  }
}
