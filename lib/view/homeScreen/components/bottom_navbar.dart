import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sepatuv5/view/profilPage/alamat.dart';
import 'package:sepatuv5/view/profilPage/profil_page.dart';
import 'icon_bottom_bar.dart';

class BottomNavBarFb1 extends StatelessWidget {
  BottomNavBarFb1({Key? key}) : super(key: key);

  // final primaryColor = Color.fromARGB(255, 236, 235, 254);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromARGB(133, 9, 150, 129),
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                text: "Home",
                icon: Icons.home_filled,
                selected: false,
                onPressed: () {
                  // Get.to(Api_Page(title: 'API'));
                },
              ),
              IconBottomBar(
                  text: "Store",
                  icon: Icons.store_mall_directory,
                  selected: false,
                  onPressed: () {
                    Get.to(
                      ());
                  }),
              IconBottomBar(
                  text: "Search",
                  icon: Icons.bookmark_border_outlined,
                  selected: false,
                  onPressed: () {
                    Get.to(());
                  }),
              IconBottomBar(
                  text: "Profile",
                  icon: Icons.account_box_rounded,
                  selected: false,
                  onPressed: () {
                    Get.to(Alamat());
                  }),
              IconBottomBar(
                  text: "Profile",
                  icon: Icons.account_balance_sharp,
                  selected: false,
                  onPressed: () {
                    Get.to(ProfilePage());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
